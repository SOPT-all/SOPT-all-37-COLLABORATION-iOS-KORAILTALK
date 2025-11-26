//
//  DiscountApplyView.swift
//  KORAILTALK-iOS
//
//  Created by sun on 11/26/25.
//

import UIKit

import SnapKit
import Then

final class DiscountApplyView: BaseView {
    
    private let couponLabel = UILabel().then {
        $0.font = .sub3_m_16
        $0.textColor = .mainBlack
        $0.text = "할인 쿠폰"
        $0.textAlignment = .left
    }
    
    private let targetLabel = UILabel().then {
        $0.font = .sub3_m_16
        $0.textColor = .mainBlack
        $0.text = "적용 대상"
        $0.textAlignment = .left
    }
    
    let couponButton = DiscountApplyButton()
    let targetButton = DiscountApplyButton()
    
    var onTapCoupon: (() -> Void)?
    var onTapTarget: (() -> Void)?
    
    private lazy var couponRow = UIStackView(arrangedSubviews: [couponLabel, couponButton]).then {
        $0.axis = .horizontal
        $0.alignment = .center
        $0.spacing = 48
        $0.distribution = .fill
    }
    
    private lazy var targetRow = UIStackView(arrangedSubviews: [targetLabel, targetButton]).then {
        $0.axis = .horizontal
        $0.alignment = .center
        $0.spacing = 48
        $0.distribution = .fill
    }
    
    private lazy var verticalStack = UIStackView(arrangedSubviews: [couponRow, targetRow]).then {
        $0.axis = .vertical
        $0.alignment = .fill
        $0.spacing = 12
    }
    
    override func setUI() {
        couponButton.configure(placeholder: "적용할 쿠폰 선택")
        targetButton.configure(placeholder: "적용할 승객 선택")
        
        couponButton.onTap = { [weak self] in
            self?.onTapCoupon?()
        }
        targetButton.onTap = { [weak self] in
            self?.onTapTarget?()
        }
        
        addSubview(verticalStack)
        
        verticalStack.snp.makeConstraints {
            $0.top.equalToSuperview().inset(16)
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.bottom.equalToSuperview().inset(16)
        }
        
        couponButton.snp.makeConstraints {
            $0.height.equalTo(36)
        }
        targetButton.snp.makeConstraints {
            $0.height.equalTo(36)
        }
    }
    
    func configureForCouponSection() {
        couponRow.isHidden = false
        couponLabel.text = "할인 쿠폰"
        couponButton.isHidden = false
        
        targetLabel.text = "적용 대상"
    }
    
    func configureForTargetOnly(title: String = "적용 대상") {
        couponRow.isHidden = true
        targetLabel.text = title
    }
}

