//
//  CheckoutViewController.swift
//  KORAILTALK-iOS
//
//  Created by sumin Kong on 11/26/25.
//

import UIKit

import SnapKit
import Then

final class CheckoutViewController: BaseViewController {
    
    // MARK: - Properties
    
    private let reservationId: Int
    private let cancelReservationService: CancelReservationServiceProtocol
    
    
    // MARK: - UI
    
    private let navigationBar = NavigationBar(style: .payment)
    private let statusBarBackgroundView = UIView().then {
        $0.backgroundColor = .primary700
    }
    
    private let scrollView = UIScrollView()
    private let contentView = UIView()
    
    private let footerView = CheckoutFooterView()
    private let checkoutInfoView = CheckoutInfoView()
    
    private let dateTrainInfoView = DateTrainInfoView().then {
        $0.configure(
            dateText: "2025년 10월 31일 (금)",
            trainInfoText: "KTX 171 · 1호차 12A"
        )
    }
    
    private let routeInfoView = RouteInfoView().then {
        $0.configure(
            departureCity: "서울",
            departureTime: "06:48",
            arrivalCity: "부산",
            arrivalTime: "10:09"
        )
    }
    
    private let topContainerView = UIView()
    private let separator1 = DividerView()
    private let separator2 = DividerView()
    
    private let paymentView = PaymentView()
    
    private let couponSectionHeaderView = SectionHeaderView().then {
        $0.configure(title: "할인 쿠폰 적용")
    }
    
    private let discountApplyView = DiscountApplyView()
    
    private let veteranSectionHeaderView = SectionHeaderView().then {
        $0.configure(title: "국가 유공자 할인")
    }
    
    private let veteranDiscountView = DiscountView()
    
    private let veteranTargetApplyView = DiscountApplyView()
    
    private let personalInfoAgreementView = PersonalInfoAgreementView()
    
    private let guardianSectionHeaderView = SectionHeaderView().then {
        $0.configure(title: "중증 보호자 할인", rightText: "적용대상 없음")
    }
    
    private let soldierSectionHeaderView = SectionHeaderView().then {
        $0.configure(title: "현역병 할인")
    }
    
    private let soldierDiscountApplyView = DiscountApplyView()
    
    
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
        setUI()
        setLayout()
        bindFooter()
        bindDiscountApplyView()
    }
    
    
    // MARK: - Setup
    
    func setUI() {
        view.addSubviews(
            statusBarBackgroundView,
            navigationBar,
            scrollView,
            footerView
        )
        
        scrollView.addSubview(contentView)
        
        contentView.addSubviews(
            topContainerView,
            couponSectionHeaderView,
            discountApplyView,
            veteranSectionHeaderView,
            veteranDiscountView,
            veteranTargetApplyView,
            personalInfoAgreementView,
            guardianSectionHeaderView,
            soldierSectionHeaderView,
            soldierDiscountApplyView,
            checkoutInfoView
        )
        
        topContainerView.addSubviews(
            dateTrainInfoView,
            separator1,
            routeInfoView,
            separator2,
            paymentView
        )
        
        discountApplyView.configureForCouponSection()
        
        veteranTargetApplyView.configureForTargetOnly(title: "적용 대상")
        
        soldierDiscountApplyView.configureForTargetOnly(title: "적용 대상")
    }
    
    func setLayout() {
        statusBarBackgroundView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.bottom.equalTo(navigationBar.snp.top)
        }
        
        navigationBar.snp.makeConstraints {
            $0.top.equalToSuperview().offset(50)
            $0.leading.trailing.equalToSuperview()
        }
        
        footerView.snp.makeConstraints {
            $0.leading.trailing.bottom.equalToSuperview()
        }
        
        scrollView.snp.makeConstraints {
            $0.top.equalTo(navigationBar.snp.bottom)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalTo(footerView.snp.top)
        }
        
        contentView.snp.makeConstraints {
            $0.edges.equalToSuperview()
            $0.width.equalToSuperview()
        }
        
        topContainerView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.trailing.equalToSuperview().inset(16)
        }
        
        dateTrainInfoView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(20)
            $0.leading.trailing.equalToSuperview()
        }
        
        separator1.snp.makeConstraints {
            $0.top.equalTo(dateTrainInfoView.snp.bottom).offset(16)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(1)
        }
        
        routeInfoView.snp.makeConstraints {
            $0.top.equalTo(separator1.snp.bottom).offset(16)
            $0.centerX.equalToSuperview()
        }
        
        separator2.snp.makeConstraints {
            $0.top.equalTo(routeInfoView.snp.bottom).offset(16)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(1)
        }
        
        paymentView.snp.makeConstraints {
            $0.top.equalTo(separator2.snp.bottom).offset(20)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalToSuperview().offset(-24)
        }
        
        couponSectionHeaderView.snp.makeConstraints {
            $0.top.equalTo(topContainerView.snp.bottom)
            $0.leading.trailing.equalToSuperview()
        }
        
        discountApplyView.snp.makeConstraints {
            $0.top.equalTo(couponSectionHeaderView.snp.bottom)
            $0.leading.trailing.equalToSuperview()
        }
        
        veteranSectionHeaderView.snp.makeConstraints {
            $0.top.equalTo(discountApplyView.snp.bottom)
            $0.leading.trailing.equalToSuperview()
        }
        
        veteranDiscountView.snp.makeConstraints {
            $0.top.equalTo(veteranSectionHeaderView.snp.bottom)
            $0.leading.trailing.equalToSuperview()
        }
        
        veteranTargetApplyView.snp.makeConstraints {
            $0.top.equalTo(veteranDiscountView.snp.bottom).inset(12)
            $0.leading.trailing.equalToSuperview()
        }
        
        personalInfoAgreementView.snp.makeConstraints {
            $0.top.equalTo(veteranTargetApplyView.snp.bottom).inset(12)
            $0.leading.trailing.equalToSuperview()
        }
        
        guardianSectionHeaderView.snp.makeConstraints {
            $0.top.equalTo(personalInfoAgreementView.snp.bottom)
            $0.leading.trailing.equalToSuperview()
        }
        
        soldierSectionHeaderView.snp.makeConstraints {
            $0.top.equalTo(guardianSectionHeaderView.snp.bottom)
            $0.leading.trailing.equalToSuperview()
        }
        
        soldierDiscountApplyView.snp.makeConstraints {
            $0.top.equalTo(soldierSectionHeaderView.snp.bottom)
            $0.leading.trailing.equalToSuperview()
        }
        
        checkoutInfoView.snp.makeConstraints {
            $0.top.equalTo(soldierDiscountApplyView.snp.bottom)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
    }
    
    
    // MARK: - Bind
    
    private func bindFooter() {
        footerView.onTapCancelConfirm = { [weak self] in
            Task { await self?.handleCancelReservation() }
        }
    }
    
    private func bindDiscountApplyView() {
        discountApplyView.couponButton.addTarget(
            self,
            action: #selector(didTapCouponButton),
            for: .touchUpInside
        )
        
        discountApplyView.targetButton.addTarget(
            self,
            action: #selector(didTapTargetButton),
            for: .touchUpInside
        )
        
        veteranTargetApplyView.targetButton.addTarget(
            self,
            action: #selector(didTapTargetButton),
            for: .touchUpInside
        )
        
        soldierDiscountApplyView.targetButton.addTarget(
            self,
            action: #selector(didTapSoldierTargetButton),
            for: .touchUpInside
        )
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
            self?.discountApplyView.couponButton.updateSelected(text: selected)
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
            self?.discountApplyView.targetButton.updateSelected(text: selected)
            self?.veteranTargetApplyView.targetButton.updateSelected(text: selected)
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
            self?.soldierDiscountApplyView.targetButton.updateSelected(text: selected)
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
}

#Preview {
    CheckoutViewController(reservationId: 17)
}

