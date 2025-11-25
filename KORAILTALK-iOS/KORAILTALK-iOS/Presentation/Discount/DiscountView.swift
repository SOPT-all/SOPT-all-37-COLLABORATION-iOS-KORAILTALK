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
    
    private let couponSectionHeader = SectionHeaderView().then {
        $0.configure(title: "할인 쿠폰 적용")
    }
    
    private let veteranSectionHeader = SectionHeaderView().then {
        $0.configure(title: "국가 유공자 할인")
    }
    let guardianSectionHeader = SectionHeaderView().then {
        $0.configure(title: "중증 보호자 할인", rightText: "적용대상 없음")
    }
    private let soldierSectionHeader = SectionHeaderView().then {
        $0.configure(title: "현역병 할인")
    }
    
    private let veteransLabel = UILabel().then{
        $0.font = .sub3_m_16
        $0.textColor = .mainBlack
        $0.text = "보훈 번호"
        $0.textAlignment = .left
    }
    var veteransTextField = UITextField().then{
        $0.font = .body1_r_16
        $0.textColor = .gray400
        $0.placeholder = "보훈번호 8자리"
        $0.keyboardType = .numberPad
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor.gray200.cgColor
        $0.layer.cornerRadius = 8
        $0.addPadding()
    }
    
    private let passwordLabel = UILabel().then {
        $0.text = "비밀 번호"
        $0.font = .sub3_m_16
        $0.textColor = .mainBlack
        $0.textAlignment = .left
    }
    var passwordTextField = UITextField().then {
        $0.placeholder = "숫자 4자리"
        $0.font = .body1_r_16
        $0.textColor = .gray400
        $0.keyboardType = .numberPad
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor.gray200.cgColor
        $0.layer.cornerRadius = 8
        $0.addPadding()
    }
    private let birthLabel = UILabel().then {
        $0.text = "생년월일"
        $0.font = .body1_r_16
        $0.textColor = .mainBlack
    }
    var birthTextField = UITextField().then {
        $0.placeholder = "생년월일 6자리"
        $0.font = .body1_r_16
        $0.textColor = .gray400
        $0.keyboardType = .numberPad
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor.gray200.cgColor
        $0.layer.cornerRadius = 8
        $0.addPadding()
    }
    var checkButton = OKButton()
    
    private let targetLabel = UILabel().then {
        $0.text = "적용 대상"
        $0.font = .body1_r_16
        $0.textColor = .mainBlack
    }
    var targetTextField = UITextField().then{//드롭다운으로 교체할 것임!
        $0.font = .body1_r_16
        $0.textColor = .gray400
        $0.placeholder = "적용할 승객 선택"
        $0.textAlignment = .left
    }
    lazy var agreecheckboxButton = CheckBox()
    private let agreeLabel = UILabel().then {
        $0.text = "개인정보 수집 및 이용 동의"
        $0.font = .body1_r_16
        $0.textColor = .mainBlack
    }
    private lazy var veteransStack = UIStackView().then {
        $0.axis = .horizontal
        $0.alignment = .fill
        $0.addArrangedSubviews(veteransLabel, veteransTextField)
    }
    private lazy var passwordStack = UIStackView().then {
        $0.axis = .horizontal
        $0.alignment = .fill
        $0.addArrangedSubviews(passwordLabel, passwordTextField)
    }
    private lazy var birthStack = UIStackView().then {
        $0.axis = .horizontal
        $0.alignment = .center
        $0.spacing = 9
        $0.distribution = .fill
        $0.addArrangedSubviews(birthLabel, birthTextField, checkButton)
    }
    private lazy var targetStack = UIStackView().then {
        $0.axis = .horizontal
        $0.alignment = .fill
        $0.addArrangedSubviews(targetLabel, targetTextField)
    }
    private lazy var agreeStack = UIStackView().then {
        $0.axis = .horizontal
        $0.alignment = .fill
        $0.addArrangedSubviews(agreecheckboxButton, agreeLabel)
    }
    
    
    override func setUI() {
        addSubviews(
            couponSectionHeader,
            veteranSectionHeader,
            veteransStack,
            passwordStack,
            birthStack,
            targetStack,
            agreeStack,
            guardianSectionHeader,
            soldierSectionHeader
        )
    }
    override func setLayout() {
        couponSectionHeader.snp.makeConstraints {
            $0.top.equalToSuperview().inset(16)
            $0.leading.trailing.equalToSuperview()
        }
        veteranSectionHeader.snp.makeConstraints {
            $0.top.equalTo(couponSectionHeader.snp.bottom)
            $0.leading.trailing.equalToSuperview()
        }
        veteransLabel.snp.makeConstraints{
            $0.leading.equalTo(veteransStack.snp.leading)
            $0.top.equalTo(veteransStack.snp.bottom).offset(7.5)
        }
        veteransTextField.snp.makeConstraints {
            $0.width.greaterThanOrEqualTo(240)
            $0.leading.equalTo(veteransLabel.snp.leading).offset(115)
            $0.trailing.equalTo(veteransStack)
        }
        veteransStack.snp.makeConstraints {
            $0.top.equalTo(veteranSectionHeader.snp.bottom).offset(16)
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.height.equalTo(36)
        }
        passwordLabel.snp.makeConstraints{
            $0.leading.equalTo(passwordStack.snp.leading)
            $0.top.equalTo(passwordStack.snp.bottom).offset(7.5)
        }
        passwordTextField.snp.makeConstraints {
            $0.width.greaterThanOrEqualTo(240)
            $0.leading.equalTo(passwordLabel.snp.leading).offset(115)
            $0.trailing.equalTo(passwordStack)
        }
        passwordStack.snp.makeConstraints {
            $0.top.equalTo(veteransStack.snp.bottom).offset(16)
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.height.equalTo(36)
        }
        birthLabel.snp.makeConstraints{
            $0.leading.equalTo(birthStack.snp.leading)
            $0.top.equalTo(passwordStack.snp.bottom).offset(7.5)
        }
        birthTextField.snp.makeConstraints {
            $0.leading.equalTo(birthLabel.snp.leading).offset(115)
            $0.height.equalTo(36)
        }
        checkButton.snp.makeConstraints{
            $0.width.equalTo(56)
            $0.height.equalTo(36)
            $0.trailing.equalTo(birthStack.snp.trailing)
        }
        birthTextField.setContentHuggingPriority(.defaultLow, for: .horizontal)
        checkButton.setContentHuggingPriority(.required, for: .horizontal)
        birthStack.snp.makeConstraints {
            $0.top.equalTo(passwordStack.snp.bottom).offset(16)
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.height.equalTo(36)
        }
        
        targetLabel.snp.makeConstraints{
            $0.leading.equalTo(targetStack.snp.leading)
            $0.top.equalTo(targetStack.snp.bottom).offset(7.5)
        }
        targetTextField.snp.makeConstraints {
            $0.width.greaterThanOrEqualTo(240)
            $0.leading.equalTo(targetLabel.snp.leading).offset(115)
            $0.trailing.equalTo(targetStack)
        }
        targetStack.snp.makeConstraints {
            $0.top.equalTo(birthStack.snp.bottom).offset(16)
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.height.equalTo(36)
        }
        agreecheckboxButton.snp.makeConstraints{
            $0.width.height.equalTo(44)
            $0.leading.equalTo(agreeStack.snp.leading)
        }
        agreeLabel.snp.makeConstraints {
            $0.leading.equalTo(agreecheckboxButton.snp.trailing)
            $0.trailing.equalTo(agreeStack.snp.trailing)
        }
        agreeStack.snp.makeConstraints {
            $0.top.equalTo(targetStack.snp.bottom).offset(8)
            $0.leading.trailing.equalToSuperview().inset(4)
            $0.height.equalTo(44)
        }
        guardianSectionHeader.snp.makeConstraints {
            $0.top.equalTo(agreeStack.snp.bottom).offset(8)
            $0.leading.trailing.equalToSuperview()
        }
        soldierSectionHeader.snp.makeConstraints {
            $0.top.equalTo(guardianSectionHeader.snp.bottom)
            $0.leading.trailing.equalToSuperview()
        }
    }
}
#Preview{
    DiscountViewController()
}
