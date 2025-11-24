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
    }
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
        setupLayout()
    }
    
    // MARK: - Setup
    
    private func setupView() {
        backgroundColor = .gray50
        
        addSubview(titleLabel)
        addSubview(rightLabel)
    }
    
    private func setupLayout() {
        snp.makeConstraints { make in
            make.height.equalTo(44)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(20)
            make.centerY.equalToSuperview()
        }
        
        rightLabel.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(20)
            make.centerY.equalToSuperview()
        }
    }
    
    // MARK: - Configure
    
    func configure(title: String, rightText: String? = nil) {
        titleLabel.text = title
        
        if let rightText = rightText, rightText.isEmpty == false {
            rightLabel.text = rightText
            rightLabel.isHidden = false
        } else {
            rightLabel.isHidden = true
        }
    }
}
