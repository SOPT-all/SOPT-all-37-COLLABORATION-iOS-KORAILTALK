import UIKit

import SnapKit
import Then

final class DiscountViewController: UIViewController, UITextFieldDelegate {
    
    private let discountView = DiscountView()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupUI()
        
        discountView.veteransTextField.delegate = self
        discountView.passwordTextField.delegate = self
        discountView.birthTextField.delegate = self
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
}


#Preview{
    DiscountViewController()
}
