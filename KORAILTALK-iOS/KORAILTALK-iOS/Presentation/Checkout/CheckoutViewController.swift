//
//  CheckoutViewController.swift
//  KORAILTALK-iOS
//
//  Created by sun on 11/26/25.
//

import UIKit

import SnapKit
import Then

final class CheckoutViewController: BaseViewController, UITextFieldDelegate {
    
    // MARK: - Properties
    
    private let trainId: Int
    private let seatType: SeatType
    private var reservationId: Int?
    private var selectedCouponRate: Int?
    
    private let trainReservationService: TrainReservationServiceProtocol
    private let cancelReservationService: CancelReservationServiceProtocol
    private let veteransService: VeteranVerificationServiceProtocol = VeteranVerificationService()
    
    private var modalView: CheckModalView?
    
    private var veteransId: String = ""
    private var password: String = ""
    private var birth: String = ""
    
    private let checkoutView = CheckoutView()
    private var trainReservation: TrainReservation?
    
    
    // MARK: - Init
    
    init(
        trainId: Int,
        seatType: SeatType,
        trainReservationService: TrainReservationServiceProtocol = TrainReservationService(),
        cancelReservationService: CancelReservationServiceProtocol = CancelReservationService()
    ) {
        self.trainId = trainId
        self.seatType = seatType
        self.trainReservationService = trainReservationService
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
        bindNavigationBar()
        bindFooter()
        bindDiscountApplyView()
        setupVeteranDiscountBindings()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        Task { [weak self] in
            await self?.fetchTrainReservation()
        }
    }
    
    
    // MARK: - Setup View
    
    private func setupView() {
        view.addSubview(checkoutView)
        checkoutView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    private func bindNavigationBar() {
        let navBar = checkoutView.navigationBar
        
        navBar.onTapBack = { [weak self] in
            guard let self else { return }
            
            if let navigationController = self.navigationController {
                navigationController.popViewController(animated: true)
            } else {
                self.dismiss(animated: true)
            }
        }
        
        navBar.onTapCancel = { [weak self] in
            self?.navigateToHome()
        }
    }
    
    private func navigateToHome() {
        if let navigationController {
            if let homeVC = navigationController.viewControllers.first(where: { $0 is HomeViewController }) {
                navigationController.popToViewController(homeVC, animated: true)
            } else {
                let homeVC = HomeViewController()
                navigationController.setViewControllers([homeVC], animated: true)
            }
        } else {
            let homeVC = HomeViewController()
            homeVC.modalPresentationStyle = .fullScreen
            present(homeVC, animated: true)
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
        presentTargetBottomSheet()
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
    
    
    // MARK: - Coupon Logic

    private func applyCoupon(discountRate: Int) {
        guard let reservation = trainReservation else { return }

        let price = reservation.trainInfo.price
        let discount = -price.discount(by: discountRate)

        checkoutView.paymentView.updatePrice(
            fare: price,
            fee: 0,
            discountFare: discount,
            discountFee: 0
        )
    }
    
    
    // MARK: - BottomSheet
    
    private func presentCouponBottomSheet() {
        guard let reservation = trainReservation else { return }
        
        let coupons = reservation.coupons
        let couponItems = coupons.map { $0.name }

        let vc = CheckoutDropdownBottomSheetViewController(
            placeholder: "적용할 쿠폰 선택",
            items: couponItems
        )

        vc.onSelect = { [weak self] selected in
            guard let self else { return }

            self.checkoutView.discountApplyView.couponButton.updateSelected(text: selected)

            if let coupon = coupons.first(where: { $0.name == selected }) {
                self.applyCoupon(discountRate: coupon.discountRate)
            }
        }

        present(vc, animated: true)
    }
    
    private func presentTargetBottomSheet() {
        guard let reservation = trainReservation else {
            let vc = CheckoutDropdownBottomSheetViewController(
                placeholder: "할인 쿠폰 적용 대상 선택",
                items: ["적용 가능한 승객이 없습니다."]
            )
            
            vc.onSelect = { _ in }
            
            present(vc, animated: true)
            return
        }
        
        let info = reservation.trainInfo
        let priceText = info.price.formattedPrice

        let passengerText = "어른 - 1호차 12A / \(priceText)"
        
        let vc = CheckoutDropdownBottomSheetViewController(
            placeholder: "할인 쿠폰 적용 대상 선택",
            items: [passengerText]
        )
        
        vc.onSelect = { [weak self] selected in
            guard let self else { return }
            self.checkoutView.discountApplyView.targetButton.updateSelected(text: selected)
            self.checkoutView.veteranTargetApplyView.targetButton.updateSelected(text: selected)
        }
        
        present(vc, animated: true)
    }
    
    
    // MARK: - Network
    
    @MainActor
    private func fetchTrainReservation() async {
        do {
            let reservation = try await trainReservationService.getTrainReservation(
                trainId: trainId,
                seatType: seatType
            )
            trainReservation = reservation
            reservationId = reservation.trainInfo.reservationId
            checkoutView.configure(with: reservation)
        } catch {
            print("❌ 열차 예약 조회 실패: \(error)")
        }
    }
    
    @MainActor
    private func handleCancelReservation() async {
        guard let reservationId else {
            print("❌ 예약 ID 없음")
            return
        }
        
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
