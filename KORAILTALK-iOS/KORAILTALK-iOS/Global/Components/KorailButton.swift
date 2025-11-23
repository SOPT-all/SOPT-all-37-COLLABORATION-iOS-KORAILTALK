//
//  KorailButton.swift
//  KORAILTALK-iOS
//
//  Created by 한현서 on 11/22/25.
//

import UIKit

final class KorailButton: UIButton {

    private let style: KorailButtonStyle

    init(title: String, style: KorailButtonStyle) {
        self.style = style
        super.init(frame: .zero)
        setup(title: title)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setup(title: String) {
        setTitle(title, for: .normal)
        layer.cornerRadius = 8
        clipsToBounds = true
        applyStyle()
    }

    private func applyStyle() {
        backgroundColor = isEnabled ? style.enabledBackgroundColor : style.disabledBackgroundColor
        
        setTitleColor(style.enabledTitleColor, for: .normal)
        setTitleColor(style.disabledTitleColor, for: .disabled)
        
        layer.borderWidth = style.borderWidth
        layer.borderColor = style.borderColor
    }

    override var isHighlighted: Bool {
        didSet {
            UIView.animate(withDuration: 0.08) {
                self.transform = self.isHighlighted
                ? CGAffineTransform(scaleX: 0.97, y: 0.97)
                : .identity
            }
        }
    }
}
