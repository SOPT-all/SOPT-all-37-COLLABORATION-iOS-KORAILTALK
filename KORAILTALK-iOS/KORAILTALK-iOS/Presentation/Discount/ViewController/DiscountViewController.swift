import UIKit

import SnapKit
import Then

final class DiscountViewController: UIViewController, UITextFieldDelegate {
    
    private let discountView = DiscountView()
    private let validVeteranNumber = "11-111111"
    private var modalView: CheckModalView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupUI()
        
        discountView.veteransTextField.delegate = self
        discountView.passwordTextField.delegate = self
        discountView.birthTextField.delegate = self
        
        discountView.checkButton.isEnabled = false
        
        discountView.veteransTextField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        discountView.passwordTextField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        discountView.birthTextField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        discountView.checkButton.addTarget(self, action: #selector(checkButtonDidTap), for: .touchUpInside)
    }
    
    private func setupUI() {
        view.addSubview(discountView)
        discountView.snp.makeConstraints {
            $0.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    // MARK: - UITextFieldDelegate
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        let allowedCharacters = CharacterSet.decimalDigits
        if string.rangeOfCharacter(from: allowedCharacters.inverted) != nil && !string.isEmpty {
            return false
        }
        if textField == discountView.veteransTextField{
            let currentText = textField.text ?? ""
            let nsString = currentText as NSString
            let newText = nsString.replacingCharacters(in: range, with: string)
                .replacingOccurrences(of: "-", with: "")
            if newText.count > 8 {
                return false
            }
            var formattedText = ""
            for (index, char) in newText.enumerated() {
                if index == 2 { formattedText += "-" }
                formattedText.append(char)
            }
            textField.text = formattedText
            return false
        }
        else if textField == discountView.passwordTextField {
            let allowedCharacters = CharacterSet.decimalDigits
            let currentText = textField.text ?? ""
            let nsString = currentText as NSString
            let newText = nsString.replacingCharacters(in: range, with: string)
            return newText.count <= 4 && string.rangeOfCharacter(from: allowedCharacters.inverted) == nil
        }
        else if textField == discountView.birthTextField {
            let currentText = textField.text ?? ""
            let nsString = currentText as NSString
            let newText = nsString.replacingCharacters(in: range, with: string)
            return newText.count <= 6 && string.rangeOfCharacter(from: allowedCharacters.inverted) == nil
        }
        return true
    }
    
    //MARK: - ChangeButton
    @objc private func textFieldDidChange(){
        let veteranValid = discountView.veteransTextField.text?.isValidVeteranNumber ?? false
        let passwordValid = discountView.passwordTextField.text?.isValidPassword ?? false
        let birthValid = discountView.birthTextField.text?.isValidBirth ?? false
        discountView.checkButton.isSelected = veteranValid && passwordValid && birthValid
        discountView.checkButton.isEnabled = veteranValid && passwordValid && birthValid
    }
    @objc private func checkButtonDidTap(){
        if !discountView.agreecheckboxButton.isChecked {
            showModal(question: "개인정보 수집 및 이용에 동의해주세요.", confirmColor: .primary500)
            return
        }
        let enteredNumber = discountView.veteransTextField.text ?? ""
        if enteredNumber == validVeteranNumber {
            showModal(question: "인증되었습니다.", confirmColor: .primary500)
        }else {
            showModal(question: "해당 보훈번호가 인증되지 않았습니다.", confirmColor: .primary500)
            discountView.veteransTextField.text = ""
            discountView.passwordTextField.text = ""
            discountView.birthTextField.text = ""
            discountView.agreecheckboxButton.isChecked = false
            textFieldDidChange()
        }
    }
    
    
    private func showModal(question: String, confirmColor: UIColor,confirmAction: (() -> Void)? = nil) {
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
    DiscountViewController()
}
