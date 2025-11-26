//
//  SectionHeaderView.swift
//  KORAILTALK-iOS
//
//  Created by sun on 11/25/25.
//

import UIKit

import SnapKit
import Then

final class SectionHeaderView: UIView {
    
    // MARK: - UI
    
    private let titleLabel = UILabel().then {
        $0.textColor = .mainBlack
        $0.font = .body1_r_16
    }
    
    private let rightLabel = UILabel().then {
        $0.textColor = .pointRed
        $0.font = .body5_r_13
        $0.isHidden = true
        $0.textAlignment = .right
    }
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
        setupConstraints()
    }
    
    // MARK: - Setup
    
    private func setupUI() {
        backgroundColor = .gray50
        addSubviews(titleLabel, rightLabel)
    }
    
    private func setupConstraints() {
        snp.makeConstraints {
            $0.height.equalTo(44)
        }
        
        titleLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(20)
            $0.centerY.equalToSuperview()
        }
        
        rightLabel.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(20)
            $0.centerY.equalToSuperview()
        }
    }
    
    // MARK: - Configure
    
    func configure(title: String, rightText: String? = nil) {
        titleLabel.text = title
        
        guard let rightText, !rightText.isEmpty else {
            rightLabel.isHidden = true
            return
        }
        
        rightLabel.text = rightText
        rightLabel.isHidden = false
    }
}
