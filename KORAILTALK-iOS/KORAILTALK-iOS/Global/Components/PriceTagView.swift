//
//  PriceTagView.swift
//  KORAILTALK-iOS
//
//  Created by sumin Kong on 11/22/25.
//

import UIKit

import SnapKit
import Then


final class PriceTagView: BaseView {
    
    private let roomLabel = UILabel()
    private let priceLabel = UILabel()
    
    var isSelected: Bool = false {
        didSet {
            updateSelectedStyle()
        }
    }
    var isDisabled: Bool = false {
        didSet {
            updateDisabledStyle()
        }
    }
    
    init(roomLabel: String, price: String) {
        super.init(frame: .zero)
        self.roomLabel.text = roomLabel
        self.priceLabel.text = price
        setStyle()
        setUI()
        setLayout()
        updateSelectedStyle()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func updateSelectedStyle() {
        guard !isDisabled else { return }
        if isSelected {
            layer.borderWidth = 1
            layer.borderColor = UIColor.primary400.cgColor
            backgroundColor = .primary200
            roomLabel.textColor = .primary400
            priceLabel.textColor = .primary400
        }else {
            layer.borderColor = UIColor.gray200.cgColor
            backgroundColor = .mainWhite
            roomLabel.textColor = .mainBlack
            priceLabel.textColor = .mainBlack
        }
    }
    private func updateDisabledStyle() {
        if isDisabled {
            layer.borderWidth = 0
            backgroundColor = .gray200
            roomLabel.textColor = .gray300
            priceLabel.textColor = .gray300
        } else {
            updateSelectedStyle()
        }
    }
    
    override func setStyle() {
        layer.cornerRadius = 8
        roomLabel.font = .body1_r_16
        priceLabel.font = .body1_r_16
        layer.borderWidth = 1
        layer.borderColor = UIColor.gray200.cgColor
        backgroundColor = .mainWhite
        roomLabel.textColor = .mainBlack
        priceLabel.textColor = .mainBlack        
    }
    
    override func setUI() {
        addSubviews(roomLabel, priceLabel)
    }
            
    override func setLayout() {
        roomLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(16)
            $0.top.equalToSuperview().inset(12)
            $0.bottom.equalToSuperview().inset(12)
        }
        
        priceLabel.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(16)
            $0.top.equalToSuperview().inset(12)
            $0.bottom.equalToSuperview().inset(12)
        }
    }
}
