//
//  CheckBox.swift
//  KORAILTALK-iOS
//
//  Created by sumin Kong on 11/19/25.
//

import UIKit

protocol CheckBoxDelegate: AnyObject {
    func didTapCheckBox()
}

final class CheckBox: UIButton {
    var checkedImage = UIImage(named: "checkbox_on")
    var uncheckedImage = UIImage(named: "checkbox_off")
    
    weak var delegate: CheckBoxDelegate?
    
    var isChecked: Bool = false
    {
        didSet {
            delegate?.didTapCheckBox()
            updateImage()
        }
    }
    
    private let fixedSize = CGSize(width: 24, height: 24)
    
    override init(frame: CGRect){
        let fixedFrame = CGRect(origin: frame.origin, size: fixedSize)
        super.init(frame: fixedFrame)
        setupButton()
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.frame.size = fixedSize
        setupButton()
    }
    
    private func setupButton() {
        updateImage()
        self.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
    }
    
    @objc
    func buttonTapped() {
        self.isChecked.toggle()
    }
    
    private func updateImage() {
        if isChecked {
            self.setImage(checkedImage, for: .normal)
        }else {
            self.setImage(uncheckedImage, for: .normal)
        }
    }
    
}
