import UIKit

import SnapKit
import Then

final class DiscountViewController: UIViewController, UITextFieldDelegate {

    private let discountView = DiscountView()
    
    private var validVeteranNumber = "12-345678"
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupUI()
        
        discountView.veteransTextField.delegate = self
    }
    
    private func setupUI() {
        view.addSubview(discountView)
        discountView.snp.makeConstraints {
            $0.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    // MARK: - UITextFieldDelegate
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard textField == discountView.veteransTextField else { return true }
        let currentText = textField.text ?? ""
        let nsString = currentText as NSString
        let newText = nsString.replacingCharacters(in: range, with: string)
            .replacingOccurrences(of: "-", with: "")
        let allowedCharacters = CharacterSet.decimalDigits
        if string.rangeOfCharacter(from: allowedCharacters.inverted) != nil && !string.isEmpty {
            return false
        }
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
    
    
    
    
    
    
    

//        @objc private func checkDiscount() {
//            let text = discountView.veteransTextField.text ?? ""
//            print("입력된 보훈 번호: \(text)")
//            // 여기서 추가 검증 로직도 가능
//        }
    }


#Preview{
    DiscountViewController()
}
