//
//  DiscountView.swift
//  KORAILTALK-iOS
//
//  Created by sumin Kong on 11/24/25.
//

import UIKit

import SnapKit
import Then

final class DiscountView: BaseView, UITextFieldDelegate {
    
    // MARK: - UI
    
    private let labelWidth: CGFloat = 95
    
    private let veteransLabel = UILabel().then {
        $0.font = .sub3_m_16
        $0.textColor = .mainBlack
        $0.text = "보훈 번호"
        $0.textAlignment = .left
    }
    
    var veteransTextField = UITextField().then {
        let placeholder = "보훈번호 8자리"
        $0.font = .body1_r_16
        $0.textColor = .mainBlack
        $0.placeholder = placeholder
        $0.attributedPlaceholder = NSAttributedString(
            string: placeholder,
            attributes: [
                .foregroundColor: UIColor.gray400,
                .font: UIFont.body1_r_16
            ]
        )
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
        let placeholder = "숫자 4자리"
        $0.font = .body1_r_16
        $0.textColor = .mainBlack
        $0.placeholder = placeholder
        $0.attributedPlaceholder = NSAttributedString(
            string: placeholder,
            attributes: [
                .foregroundColor: UIColor.gray400,
                .font: UIFont.body1_r_16
            ]
        )
        $0.keyboardType = .numberPad
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor.gray200.cgColor
        $0.layer.cornerRadius = 8
        $0.addPadding()
    }
    
    private let birthLabel = UILabel().then {
        $0.text = "생년월일"
        $0.font = .sub3_m_16
        $0.textColor = .mainBlack
        $0.textAlignment = .left
    }
    
    var birthTextField = UITextField().then {
        let placeholder = "생년월일 6자리"
        $0.font = .body1_r_16
        $0.textColor = .mainBlack
        $0.placeholder = placeholder
        $0.attributedPlaceholder = NSAttributedString(
            string: placeholder,
            attributes: [
                .foregroundColor: UIColor.gray400,
                .font: UIFont.body1_r_16
            ]
        )
        $0.keyboardType = .numberPad
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor.gray200.cgColor
        $0.layer.cornerRadius = 8
        $0.addPadding()
    }
    
    let checkButton = OKButton().then {
        $0.isSelected = false
        $0.isEnabled = false
    }
    
    let agreecheckboxButton = CheckBox()
    
    
    // MARK: - StackViews
    
    private lazy var veteransRowStack = UIStackView().then {
        $0.axis = .horizontal
        $0.alignment = .fill
        $0.spacing = 12
        $0.addArrangedSubviews(veteransLabel, veteransTextField)
    }
    
    private lazy var passwordRowStack = UIStackView().then {
        $0.axis = .horizontal
        $0.alignment = .fill
        $0.spacing = 12
        $0.addArrangedSubviews(passwordLabel, passwordTextField)
    }
    
    private lazy var birthFieldStack = UIStackView().then {
        $0.axis = .horizontal
        $0.alignment = .fill
        $0.spacing = 8
        $0.addArrangedSubviews(birthTextField, checkButton)
    }
    
    private lazy var birthRowStack = UIStackView().then {
        $0.axis = .horizontal
        $0.alignment = .fill
        $0.spacing = 12
        $0.addArrangedSubviews(birthLabel, birthFieldStack)
    }
    
    private lazy var mainStack = UIStackView().then {
        $0.axis = .vertical
        $0.alignment = .fill
        $0.spacing = 16
        $0.addArrangedSubviews(
            veteransRowStack,
            passwordRowStack,
            birthRowStack
        )
    }
    
    private var didSetupTextFields = false
    
    override func setUI() {
        addSubview(mainStack)
    }
    
    override func setLayout() {
        
        [veteransLabel, passwordLabel, birthLabel].forEach { label in
            label.snp.makeConstraints { make in
                make.width.equalTo(labelWidth)
            }
        }
        
        [veteransTextField, passwordTextField, birthTextField].forEach { tf in
            tf.snp.makeConstraints { make in
                make.height.equalTo(36)
            }
        }
        
        checkButton.snp.makeConstraints { make in
            make.width.equalTo(58)
            make.height.equalTo(36)
        }
        
        mainStack.snp.makeConstraints {
            $0.top.equalToSuperview().inset(16)
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.bottom.equalToSuperview().inset(16)
        }
        
        [veteransTextField, passwordTextField, birthTextField].forEach { tf in
            tf.setContentHuggingPriority(.defaultLow, for: .horizontal)
            tf.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        }
        
        checkButton.setContentHuggingPriority(.required, for: .horizontal)
        checkButton.setContentCompressionResistancePriority(.required, for: .horizontal)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        if !didSetupTextFields {
            didSetupTextFields = true
            setupTextFields()
        }
    }
    
    
    // MARK: - Setup
    
    private func setupTextFields() {
        veteransTextField.delegate = self
        passwordTextField.delegate = self
        birthTextField.delegate = self
        
        veteransTextField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        passwordTextField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        birthTextField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
    }
    
    
    // MARK: - UITextFieldDelegate
    
    func textField(_ textField: UITextField,
                   shouldChangeCharactersIn range: NSRange,
                   replacementString string: String) -> Bool {
        
        let allowedCharacters = CharacterSet.decimalDigits
        
        if string.rangeOfCharacter(from: allowedCharacters.inverted) != nil && !string.isEmpty {
            return false
        }
        
        if textField == veteransTextField {
            let currentText = textField.text ?? ""
            let nsString = currentText as NSString
            let newText = nsString.replacingCharacters(in: range, with: string)
                .replacingOccurrences(of: "-", with: "")
            
            if newText.count > 8 { return false }
            
            var formattedText = ""
            for (index, char) in newText.enumerated() {
                if index == 2 { formattedText += "-" }
                formattedText.append(char)
            }
            
            textField.text = formattedText
            return false
        }
        
        if textField == passwordTextField {
            let currentText = textField.text ?? ""
            let nsString = currentText as NSString
            let newText = nsString.replacingCharacters(in: range, with: string)
            return newText.count <= 4
        }
        
        if textField == birthTextField {
            let currentText = textField.text ?? ""
            let nsString = currentText as NSString
            let newText = nsString.replacingCharacters(in: range, with: string)
            return newText.count <= 6
        }
        
        return true
    }
    
    
    // MARK: - Validation
    
    @objc
    private func textFieldDidChange() {
        let veteranValid = veteransTextField.text?.isValidVeteranNumber ?? false
        let passwordValid = passwordTextField.text?.isValidPassword ?? false
        let birthValid = birthTextField.text?.isValidBirth ?? false
        
        let allValid = veteranValid && passwordValid && birthValid
        
        checkButton.isSelected = allValid
        checkButton.isEnabled = allValid
    }
}


