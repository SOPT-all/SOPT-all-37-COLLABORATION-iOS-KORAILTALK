//
//  PriceTag.swift
//  KORAILTALK-iOS
//
//  Created by sumin Kong on 11/22/25.
//

import UIKit

import SnapKit
import Then

enum SeatStyleType: CaseIterable {
    case general
    case disabled
    case selected
}

final class PriceTagView: BaseView {
    
    private let roomLabel = UILabel()
    private let priceLabel = UILabel()
    
    var seatStyle: SeatStyleType = .general {
        didSet {
            updateSelectedStyle()
        }
    }
    
    init(roomLabel: String, price: String, seatStyle: SeatStyleType = .general) {
        super.init(frame: .zero)
        self.roomLabel.text = roomLabel
        self.priceLabel.text = price
        self.seatStyle = seatStyle
        setStyle()
        setUI()
        setLayout()
        updateSelectedStyle()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var isSelected: Bool = false {
        didSet {
            updateSelectedStyle()
        }
    }
    private func updateSelectedStyle() {
        switch seatStyle {
        case .general:
            layer.borderWidth = 1
            layer.borderColor = UIColor.gray200.cgColor
            backgroundColor = .mainWhite
            roomLabel.textColor = .mainBlack
            priceLabel.textColor = .mainBlack
        case .disabled:
            backgroundColor = .gray200
            roomLabel.textColor = .gray300
            priceLabel.textColor = .gray300
        case .selected:
            layer.borderWidth = 1
            layer.borderColor = UIColor.primary400.cgColor
            backgroundColor = .primary200
            roomLabel.textColor = .primary400
            priceLabel.textColor = .primary400
        }
            
    }
    
    override func setStyle() {
        layer.cornerRadius = 8
        roomLabel.font = .body1_r_16
        priceLabel.font = .body1_r_16
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
