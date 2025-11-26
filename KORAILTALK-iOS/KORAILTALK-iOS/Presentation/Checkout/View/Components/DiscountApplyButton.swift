//
//  DiscountApplyButton.swift
//  KORAILTALK-iOS
//
//  Created by sun on 11/26/25.
//

import UIKit

import SnapKit
import Then

final class DiscountApplyButton: UIControl {
    
    // MARK: - UI
    
    private let containerView = UIView().then {
        $0.backgroundColor = .mainWhite
        $0.layer.cornerRadius = 8
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor.gray200.cgColor
        $0.clipsToBounds = true
    }
    
    private let titleLabel = UILabel().then {
        $0.font = .body1_r_16
        $0.textColor = .gray400
    }
    
    private let arrowImageView = UIImageView().then {
        $0.image = UIImage.down
        $0.tintColor = .gray400
        $0.contentMode = .scaleAspectFit
    }
    
    // MARK: - Properties
    
    private var placeholderText: String = ""
    var onTap: (() -> Void)?
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    private func commonInit() {
        setupUI()
        addTarget(self, action: #selector(didTap), for: .touchUpInside)
    }
    
    // MARK: - Setup
    
    private func setupUI() {
        addSubview(containerView)
        containerView.snp.makeConstraints {
            $0.edges.equalToSuperview()
            $0.height.equalTo(36)
        }
        
        let stackView = UIStackView(arrangedSubviews: [titleLabel, arrowImageView]).then {
            $0.axis = .horizontal
            $0.alignment = .center
            $0.distribution = .equalSpacing
        }
        
        containerView.addSubview(stackView)
        stackView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.centerY.equalToSuperview()
        }
    }
    
    // MARK: - Action
    
    @objc
    private func didTap() {
        onTap?()
    }
    
    // MARK: - Public
    
    func configure(placeholder: String) {
        placeholderText = placeholder
        titleLabel.text = placeholder
        titleLabel.textColor = .gray400
    }
    
    func updateSelected(text: String?) {
        if let text = text {
            titleLabel.text = text
            titleLabel.textColor = .mainBlack
        } else {
            titleLabel.text = placeholderText
            titleLabel.textColor = .gray400
        }
    }
}
