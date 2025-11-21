//
//  KorailButton.swift
//  KORAILTALK-iOS
//
//  Created by 한현서 on 11/22/25.
//

import UIKit
import SnapKit
import Then

// MARK: - Button Size

enum KorailButtonSize {
    case small
    case medium
    case large
}

// MARK: - Button Style

enum KorailButtonStyle {
    case primary
    case secondary
    case gray
    case red
}

final class KorailButton: UIButton{
    private var buttonSize: KorailButtonSize
    private var buttonStyle: KorailButtonStyle
    
    init(title: String, size: KorailButtonSize, style: KorailButtonStyle){
        self.buttonSize = size
        self.buttonStyle = style
        super.init(frame: .zero)
        
        setTitle(title, for: .normal)
        setupStyle()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup Style
    private func setupStyle() {
        layer.cornerRadius = 8
        
        switch buttonSize {
        case .small:
            titleLabel?.font = .body3_r_15
        case .medium:
            titleLabel?.font = .body2_m_15
        case .large:
            titleLabel?.font = .head4_m_18
        }
        
        switch buttonStyle {
        case .primary:
            backgroundColor = .primary700
            setTitleColor(.white, for: .normal)
            
        case .secondary:
            backgroundColor = .mainWhite
            setTitleColor(.mainBlack, for: .normal)
            layer.borderWidth = 1.5
            layer.borderColor = UIColor.gray200.cgColor
            
        case .gray:
            backgroundColor = .gray100
            setTitleColor(.mainBlack, for: .normal)
            
        case .red:
            backgroundColor = .pointRed
            setTitleColor(.white, for: .normal)
        }
        
        addTarget(self, action: #selector(buttonPressed), for: .touchDown)
        addTarget(self, action: #selector(buttonReleased), for: [.touchUpInside, .touchUpOutside, .touchCancel])
    }
    
    // MARK: - Setup Layout
    
    private func setupLayout() {
        translatesAutoresizingMaskIntoConstraints = false
        
        let height: CGFloat
        switch buttonSize {
        case .small:
            height = 40
        case .medium:
            height = 40
        case .large:
            height = 48
        }
        
        heightAnchor.constraint(equalToConstant: height).isActive = true
    }
    
    // MARK: - Touch Feedback
    
    @objc private func buttonPressed() {
        UIView.animate(withDuration: 0.1) {
            self.transform = CGAffineTransform(scaleX: 0.97, y: 0.97)
            self.alpha = 0.8
        }
    }
    
    @objc private func buttonReleased() {
        UIView.animate(withDuration: 0.1) {
            self.transform = .identity
            self.alpha = 1.0
        }
    }
    
    override var isEnabled: Bool {
        didSet {
            if isEnabled {
                setupStyle()
            } else {
                backgroundColor = .gray200
                setTitleColor(.gray300, for: .normal)
                layer.borderWidth = 0
            }
        }
    }
}
