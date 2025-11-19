//
//  TrainTagButton.swift
//  KORAILTALK-iOS
//
//  Created by 어재선 on 11/18/25.
//

import UIKit

final class TrainTagButton: UIButton {
    
    
    var type: TrainTagType? {
        didSet {
            updateStyle()
        }
    }
    
    override var isSelected: Bool {
        didSet {
            updateStyle()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setLayout()
    }
    
    convenience init(type: TrainTagType, isSelected: Bool = false) {
        self.init(frame: .zero)
        self.type = type
        self.isSelected = isSelected
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override var intrinsicContentSize: CGSize {
        let labelSize = titleLabel?.intrinsicContentSize ?? .zero
        
        return CGSize(width: labelSize.width + 24, height: labelSize.height + 16)
    }
    
    private func setLayout() {
        self.layer.cornerRadius = 4
        self.titleLabel?.font = .body2_m_15
        
    }
    
    private func updateStyle() {
            guard let type = type else { return }
            
            self.setTitle(type.title, for: .normal)
            
            let style = type.style(isSelected: self.isSelected)
            
            self.backgroundColor = style.backgroundColor
            self.setTitleColor(style.titleColor, for: .normal)
            
            if let borderColor = style.borderColor {
                self.layer.borderColor = borderColor.cgColor
                self.layer.borderWidth = 1.0
            } else {
                self.layer.borderWidth = 0.0
            }
        }

}
