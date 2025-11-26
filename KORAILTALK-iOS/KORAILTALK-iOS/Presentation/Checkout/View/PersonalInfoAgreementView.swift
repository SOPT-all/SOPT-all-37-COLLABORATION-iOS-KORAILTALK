//
//  PersonalInfoAgreementView.swift
//  KORAILTALK-iOS
//
//  Created by sun on 11/27/25.
//

import UIKit

import SnapKit
import Then

final class PersonalInfoAgreementView: BaseView {
    
    let checkBoxButton = CheckBox()
    
    private let titleLabel = UILabel().then {
        $0.text = "개인정보 수집 및 이용 동의"
        $0.font = .body1_r_16
        $0.textColor = .mainBlack
    }
    
    private lazy var stackView = UIStackView().then {
        $0.axis = .horizontal
        $0.alignment = .fill
        $0.spacing = 4
        $0.addArrangedSubviews(checkBoxButton, titleLabel)
    }
    
    override func setUI() {
        addSubview(stackView)
    }
    
    override func setLayout() {
        checkBoxButton.snp.makeConstraints {
            $0.width.height.equalTo(33)
        }
        
        stackView.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(12)
        }
    }
}
