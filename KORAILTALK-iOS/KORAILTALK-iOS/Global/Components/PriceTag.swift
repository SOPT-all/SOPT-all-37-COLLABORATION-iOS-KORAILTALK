//
//  PriceTag.swift
//  KORAILTALK-iOS
//
//  Created by sumin Kong on 11/22/25.
//

import UIKit

import SnapKit
import Then

enum SeatStateType: CaseIterable {
    case general
    case disabled
    case selected
    
    var backgroundColor: UIColor {
        switch self {
        case .general:
            return .mainWhite
        case .disabled:
            return .gray200
        case .selected:
            return .primary200
        }
    }
    var borderColor: CGColor? {
        switch self {
        case .general:
            return UIColor.gray200.cgColor
        case .disabled:
            return nil
        case .selected:
            return UIColor.primary400.cgColor
        }
    }
    
    var textColor: UIColor {
        switch self {
        case .general:
            return .mainBlack
        case .disabled:
            return .gray300
        case .selected:
            return .primary400
        }
    }
}

final class PriceTagView: UIButton {
    
    private let seatState: SeatStateType
    private let roomLabelText : String //특실/일반
    private let priceText: String   //W52,000
    
    private let fixedSize = CGSize(width: 343, height: 45)
    
    
    private let roomLabel = UILabel()
    private let priceLabel = UILabel()
    
    override var intrinsicContentSize: CGSize {
        return fixedSize
    }
    
    init(
        seatState: SeatStateType,
        roomLabel: String,
        price: String
    ) {
        self.seatState = seatState
        self.roomLabelText = roomLabel
        self.priceText = price
        
        let frame = CGRect(origin: .zero, size: fixedSize)
        super.init(frame: frame)
        
        setupButton()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
         self.seatState = .general
         self.roomLabelText = "일반실"
         self.priceText = "₩0"
         super.init(coder: coder)
         self.frame.size = fixedSize
         setupButton()
         setupLayout()
     }
    
    private func setupButton() {
        layer.cornerRadius = 8
        if let border = seatState.borderColor {
            layer.borderColor = border
            layer.borderWidth = 1
        }else {
            layer.borderWidth = 0
        }
        backgroundColor = seatState.backgroundColor
        
        roomLabel.text = roomLabelText
        roomLabel.font = .body1_r_16
        roomLabel.textColor = seatState.textColor
        
        priceLabel.text = priceText
        priceLabel.font = .body1_r_16
        priceLabel.textColor = seatState.textColor
        
        addSubviews(roomLabel,priceLabel)
        
        snp.makeConstraints { make in
            make.width.equalTo(fixedSize.width)
            make.height.equalTo(fixedSize.height)
        }
    }
    
    private func setupLayout() {
        roomLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(16)
            $0.centerY.equalToSuperview()
        }
        
        priceLabel.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(16)
            $0.centerY.equalToSuperview()
        }
    }
}
