//
//  DisCountView.swift
//  KORAILTALK-iOS
//
//  Created by sumin Kong on 11/24/25.
//

import UIKit

import SnapKit
import Then

final class DiscountView: BaseView {
    
    private let veteransLabel = UILabel().then{
        $0.font = .sub3_m_16
        $0.textColor = .mainBlack
        $0.text = "보훈 번호"
        $0.textAlignment = .left
    }
    private let veteransTextField = UITextField().then{
        $0.font = .body1_r_16
        $0.textColor = .gray400
        $0.placeholder = "보훈번호 9자리"
        $0.textAlignment = .left
    }
    
    private lazy var veteransStack = UIStackView().then {
        $0.axis = .horizontal
        $0.alignment = .fill
        $0.distribution = .equalSpacing
        $0.addArrangedSubviews(veteransLabel, veteransTextField)
    }
    
    override func setUI() {
        addSubviews(veteransStack)
    }
    override func setLayout() {
        veteransStack.snp.makeConstraints {
            $0.top.equalToSuperview().inset(16)
            $0.leading.trailing.equalToSuperview().inset(16)
        }
    }
}
