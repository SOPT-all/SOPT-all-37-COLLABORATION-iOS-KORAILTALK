//
//  CheckModalView.swift
//  KORAILTALK-iOS
//
//  Created by sumin Kong on 11/23/25.
//

import UIKit

import SnapKit
import Then

final class CheckModalView: BaseView {
    
    var onNoTapped: (() -> Void)?
    
    private let questionLabel = UILabel().then{
        $0.textAlignment = .center
        $0.font = .sub3_m_16
    }
    
    private let confirmButton = UIButton().then{
        $0.layer.cornerRadius = 8
        $0.setTitleColor(.mainWhite, for: .normal)
    }
    
    private let noButton = UIButton().then {
        $0.setTitle("아니오", for: .normal)
        $0.backgroundColor = .gray100
        $0.setTitleColor(.mainBlack, for: .normal)
        $0.layer.cornerRadius = 8
        $0.isHidden = true
    }
    
    private let buttonStack = UIStackView().then {
        $0.axis = .horizontal
        $0.spacing = 8
        $0.distribution = .fillEqually
    }

    override init(frame: CGRect){
        super.init(frame: frame)
        setupUI()
        setupActions()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(
        question: String,
        confirmText: String,
        confirmColor: UIColor,
        showNoButton: Bool = false
    ) {
        questionLabel.text = question
        confirmButton.setTitle(confirmText, for: .normal)
        confirmButton.backgroundColor = confirmColor
        noButton.isHidden = !showNoButton
    }
    
    private func setupUI() {
        backgroundColor = .mainWhite
        layer.cornerRadius = 12
        
        addSubviews(questionLabel, buttonStack)
        
        buttonStack.addArrangedSubview(noButton)
        buttonStack.addArrangedSubview(confirmButton)
        
        questionLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(40)
            $0.leading.trailing.equalToSuperview().inset(12)
        }
        
        buttonStack.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(12)
            $0.bottom.equalToSuperview().inset(12)
            $0.height.equalTo(40)
        }
    }
    
    private func setupActions() {
        noButton.addTarget(self, action: #selector(didTapNoButton), for: .touchUpInside)
    }
    
    @objc private func didTapNoButton() {
        onNoTapped?()
    }
}
