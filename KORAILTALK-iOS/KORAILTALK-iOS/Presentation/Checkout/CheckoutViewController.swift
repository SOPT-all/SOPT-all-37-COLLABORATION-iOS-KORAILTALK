//
//  CheckoutViewController.swift
//  KORAILTALK-iOS
//
//  Created by sumin Kong on 11/26/25.
//

import UIKit

import SnapKit
import Then

final class CheckoutViewController: BaseViewController, UITextFieldDelegate {
    
    // MARK: - Properties
    
    private let reservationId: Int
    private let cancelReservationService: CancelReservationServiceProtocol
    private let veteransService: VeteranVerificationServiceProtocol = VeteranVerificationService()
    private var modalView: CheckModalView?
    
    private var veteransId: String = ""
    private var password: String = ""
    private var birth: String = ""

    private let checkoutView = CheckoutView()
    
    
    // MARK: - Init
    
    init(
        reservationId: Int,
        cancelReservationService: CancelReservationServiceProtocol = CancelReservationService()
    ) {
        self.reservationId = reservationId
        self.cancelReservationService = cancelReservationService
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .mainWhite
        
        setupView()
        bindFooter()
        bindDiscountApplyView()
        setupVeteranDiscountBindings()
    }
    
    
    // MARK: - Setup View
    
    private func setupView() {
        view.addSubview(checkoutView)
        checkoutView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    
    // MARK: - Bind
    
    private func bindFooter() {
        checkoutView.footerView.onTapCancelConfirm = { [weak self] in
            Task { await self?.handleCancelReservation() }
        }
    }
    
    private func bindDiscountApplyView() {
        checkoutView.discountApplyView.couponButton.addTarget(
            self,
            action: #selector(didTapCouponButton),
            for: .touchUpInside
        )
        
        checkoutView.discountApplyView.targetButton.addTarget(
            self,
            action: #selector(didTapTargetButton),
            for: .touchUpInside
        )
        
        checkoutView.veteranTargetApplyView.targetButton.addTarget(
            self,
            action: #selector(didTapTargetButton),
            for: .touchUpInside
        )
        
        checkoutView.soldierDiscountApplyView.targetButton.addTarget(
            self,
            action: #selector(didTapSoldierTargetButton),
            for: .touchUpInside
        )
    }
    
    private func setupVeteranDiscountBindings() {
        let veteranView = checkoutView.veteranDiscountView
        
        veteranView.checkButton.addTarget(self, action: #selector(checkButtonDidTap), for: .touchUpInside)
    }
    
    
    // MARK: - Actions
    
    @objc
    private func didTapCouponButton() {
        presentCouponBottomSheet()
    }
    
    @objc
    private func didTapTargetButton() {
        presentTargetBottomSheet()
    }
    
    @objc
    private func didTapSoldierTargetButton() {
        presentSoldierTargetBottomSheet()
    }
    
    @objc
    private func checkButtonDidTap() {
        let veteranView = checkoutView.veteranDiscountView
        let agreementView = checkoutView.personalInfoAgreementView
        
        if !agreementView.isAgreed {
            showModal(
                question: "개인정보 수집 및 이용에 동의해주세요.",
                confirmColor: .primary500
            )
            return
        }
        
        veteransId = veteranView.veteransTextField.text ?? ""
        password = veteranView.passwordTextField.text ?? ""
        birth = veteranView.birthTextField.text ?? ""
        
        postVeteranVerification()
    }
    
    
    // MARK: - BottomSheet
    
    private func presentCouponBottomSheet() {
        let couponItems = [
            "10% 할인 쿠폰",
            "주말 특가 쿠폰",
            "왕복 승차권 3,000원 할인"
        ]
        
        let vc = CheckoutDropdownBottomSheetViewController(
            placeholder: "적용할 쿠폰 선택",
            items: couponItems
        )
        
        vc.onSelect = { [weak self] selected in
            self?.checkoutView.discountApplyView.couponButton.updateSelected(text: selected)
        }
        
        present(vc, animated: true)
    }
    
    private func presentTargetBottomSheet() {
        let targetItems = [
            "성인 1명",
            "청소년 1명",
            "어린이 1명",
            "경로 1명"
        ]
        
        let vc = CheckoutDropdownBottomSheetViewController(
            placeholder: "적용할 승객 선택",
            items: targetItems
        )
        
        vc.onSelect = { [weak self] selected in
            guard let self else { return }
            self.checkoutView.discountApplyView.targetButton.updateSelected(text: selected)
            self.checkoutView.veteranTargetApplyView.targetButton.updateSelected(text: selected)
        }
        
        present(vc, animated: true)
    }
    
    private func presentSoldierTargetBottomSheet() {
        let soldierTargets = [
            "본인(현역병)",
            "동반 보호자 1명"
        ]
        
        let vc = CheckoutDropdownBottomSheetViewController(
            placeholder: "할인 적용 대상 선택",
            items: soldierTargets
        )
        
        vc.onSelect = { [weak self] selected in
            self?.checkoutView.soldierDiscountApplyView.targetButton.updateSelected(text: selected)
        }
        
        present(vc, animated: true)
    }
        
    // MARK: - Network
    
    @MainActor
    private func handleCancelReservation() async {
        do {
            try await cancelReservationService.cancelReservation(reservationId: reservationId)
            navigationController?.popViewController(animated: true)
        } catch {
            print("❌ 예약 취소 실패: \(error)")
        }
    }
    
    private func postVeteranVerification() {
        Task {
            do {
                let veteransVerification = try await veteransService.verifyVeteran(
                    nationalId: veteransId,
                    password: password,
                    birthdate: birth
                )
                
                await MainActor.run {
                    let veteranView = self.checkoutView.veteranDiscountView
                    let agreementView = self.checkoutView.personalInfoAgreementView
                    
                    if veteransVerification.verified {
                        self.showModal(question: "인증되었습니다.", confirmColor: .primary500)
                    } else {
                        self.showModal(question: "해당 보훈번호가 인증되지 않았습니다.", confirmColor: .primary500)
                        
                        veteranView.veteransTextField.text = ""
                        veteranView.passwordTextField.text = ""
                        veteranView.birthTextField.text = ""
                        
                        agreementView.checkBoxButton.isChecked = false
                        
                        veteranView.checkButton.isSelected = false
                        veteranView.checkButton.isEnabled = false
                    }
                }
            } catch {
                print("❌ 보훈 인증 실패:", error.localizedDescription)
            }
        }
    }
    
    // MARK: - Modal
    
    private func showModal(
        question: String,
        confirmColor: UIColor,
        confirmAction: (() -> Void)? = nil
    ) {
        modalView?.removeFromSuperview()
        
        let modal = CheckModalView()
        modal.configure(question: question, confirmText: "확인", confirmColor: confirmColor)
        view.addSubview(modal)
        modal.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.width.equalTo(304)
            $0.height.equalTo(148)
        }
        self.modalView = modal
        
        modal.confirmButton.addAction(.init(handler: { _ in
            confirmAction?()
            modal.removeFromSuperview()
        }), for: .touchUpInside)
    }
}

#Preview{
    CheckoutViewController(reservationId: 17)
}
