//
//  OKButton.swift
//  KORAILTALK-iOS
//
//  Created by sumin Kong on 11/24/25.
//

import UIKit

import SnapKit
import Then

final class OKButton: UIButton {
    private let textLabel = UILabel()
    
    override var isSelected: Bool {
        didSet {
            updateStyle()
        }
    }
    
    private let fixedSize = CGSize(width: 56, height: 36)
    
    override init(frame: CGRect){
        let fixedFrame = CGRect(origin: frame.origin, size: fixedSize)
        super.init(frame: fixedFrame)
        setUI()
        setStyle()
        setLayout()
        setupButton()
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.frame.size = fixedSize
        setupButton()
    }
    
    func setStyle(){
        layer.cornerRadius = 8
        textLabel.font = .body1_r_16
        textLabel.textColor = .mainWhite
        textLabel.text = "확인"
    }
    func setUI() {
        addSubview(textLabel)
    }
    func setLayout() {
        textLabel.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(14)
            $0.top.bottom.equalToSuperview().inset(7)
        }
    }
    
    private func setupButton() {
        updateStyle()
        self.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
    }
        
    @objc
    func buttonTapped() {
        self.isSelected.toggle()
    }
    
    private func updateStyle() {
        if isSelected {
            self.backgroundColor = .primary300
        }else {
            self.backgroundColor = .gray300
        }
    }
}
