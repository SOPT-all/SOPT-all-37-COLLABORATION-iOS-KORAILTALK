//
//  SeatStatusView.swift
//  KORAILTALK-iOS
//
//  Created by 어재선 on 11/21/25.
//

import UIKit

import SnapKit
import Then

final class SeatStatusView: BaseView {
    
    // MARK: - Properties
    
    private let seatType: SeatType
    private let seatStatus: SeatStatus
    
    // MARK: - UI
    
    private let seatTitleLabel = UILabel()
    private let seatTitleStackView = UIStackView()
    private let statusLabel = UILabel()
    private let seatStatusStackView = UIStackView()
    
    // MARK: - Init
    
    init(seatType: SeatType, seatStatus: SeatStatus) {
        self.seatType = seatType
        self.seatStatus = seatStatus
        super.init(frame: .zero)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - SetUI
    
    override func setUI() {
        addSubviews(seatStatusStackView)
    }
    
    // MARK: - SetStyle
    
    override func setStyle() {
        seatTitleStackView.do {
            $0.addArrangedSubview(seatTitleLabel)
            $0.backgroundColor = .mainWhite
            $0.layer.cornerRadius = 4
            $0.layer.borderWidth = 1
            $0.layer.borderColor = UIColor.gray200.cgColor
            $0.axis = .horizontal
            $0.alignment = .center
            $0.layoutMargins = UIEdgeInsets(top: 2, left: 8, bottom: 2, right: 8)
            $0.isLayoutMarginsRelativeArrangement = true
            
        }
        
        seatTitleLabel.do {
            $0.text = seatType.title
            $0.font = .cap2_r_12
            $0.textColor = .black
            $0.textAlignment = .center
        }
        
        statusLabel.do {
            $0.text = seatStatus.title
            $0.font = .cap1_m_12
            $0.textColor = seatStatus.textColor
            $0.textAlignment = .center
        }
        
        seatStatusStackView.do {
            $0.addArrangedSubviews(seatTitleStackView ,statusLabel)
            $0.axis = .horizontal
            $0.spacing = 8
            $0.alignment = .center
        }
    }
    
    // MARK: - SetLayout
    
    override func setLayout() {
        
        seatStatusStackView.snp.makeConstraints{
            $0.edges.equalToSuperview()
        }
        
    }
    
}

#Preview {
    SeatStatusView(seatType: .premium, seatStatus: .almostSoldOut)
}
