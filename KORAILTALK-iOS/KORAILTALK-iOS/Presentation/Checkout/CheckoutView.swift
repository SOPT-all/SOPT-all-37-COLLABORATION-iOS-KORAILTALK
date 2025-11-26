//
//  CheckoutView.swift
//  KORAILTALK-iOS
//
//  Created by sun on 11/27/25.
//

import UIKit

import SnapKit
import Then

final class CheckoutView: BaseView {
    
    // MARK: - UI
    
    let navigationBar = NavigationBar(style: .payment)
    
    let statusBarBackgroundView = UIView().then {
        $0.backgroundColor = .primary700
    }
    
    let scrollView = UIScrollView()
    let contentView = UIView()
    
    let footerView = CheckoutFooterView()
    let checkoutInfoView = CheckoutInfoView()
    
    let dateTrainInfoView = DateTrainInfoView().then {
        $0.configure(
            dateText: "2025년 10월 31일 (금)",
            trainInfoText: "KTX 171 · 1호차 12A"
        )
    }
    
    let routeInfoView = RouteInfoView().then {
        $0.configure(
            departureCity: "서울",
            departureTime: "06:48",
            arrivalCity: "부산",
            arrivalTime: "10:09"
        )
    }
    
    let topContainerView = UIView()
    let separator1 = DividerView()
    let separator2 = DividerView()
    
    let paymentView = PaymentView()
    
    let couponSectionHeaderView = SectionHeaderView().then {
        $0.configure(title: "할인 쿠폰 적용")
    }
    
    let discountApplyView = DiscountApplyView()
    
    let veteranSectionHeaderView = SectionHeaderView().then {
        $0.configure(title: "국가 유공자 할인")
    }
    
    let veteranDiscountView = DiscountView()
    
    let veteranTargetApplyView = DiscountApplyView()
    
    let personalInfoAgreementView = PersonalInfoAgreementView()
    
    let guardianSectionHeaderView = SectionHeaderView().then {
        $0.configure(title: "중증 보호자 할인", rightText: "적용대상 없음")
    }
    
    let soldierSectionHeaderView = SectionHeaderView().then {
        $0.configure(title: "현역병 할인")
    }
    
    let soldierDiscountApplyView = DiscountApplyView()
    
    override func setUI() {
        addSubviews(
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
    
    override func setLayout() {
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
}
