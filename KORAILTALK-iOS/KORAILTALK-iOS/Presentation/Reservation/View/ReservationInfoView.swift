//
//  ReservationInfoView.swift
//  KORAILTALK-iOS
//
//  Created by 어재선 on 11/21/25.
//

import UIKit

import SnapKit
import Then

final class ReservationInfoView: BaseView {
    
    
    
    //MARK: - UI
    
    private let originLabel = UILabel()
    private let destinationLabel = UILabel()
    private let arrowImageView = UIImageView()
    private let routeStackView = UIStackView()
    
    private let reservationDetailLabel = UILabel()
    
    
    override func setUI() {
     addSubviews(routeStackView)
        addSubviews(reservationDetailLabel)
    }
    
    override func setStyle() {
        originLabel.do {
            $0.text = "서울"
            $0.textColor = .primary400
            $0.font = .head2_m_20
            $0.textAlignment = .center
        }
        
        arrowImageView.do {
            $0.image = UIImage(named: "right")
            $0.tintColor = .primary400
        }
        
        destinationLabel.do {
            $0.text = "부산"
            $0.textColor = .primary400
            $0.font = .head2_m_20
        }
        
        routeStackView.do {
            $0.addArrangedSubviews(originLabel, arrowImageView, destinationLabel)
            $0.axis = .horizontal
            $0.spacing = 8
            $0.alignment = .center
        }
        
        reservationDetailLabel.do {
            $0.text = "11월 10일 · 편도 · 어른 1명"
            $0.font = .cap1_m_12
            $0.textColor = .gray400
            $0.textAlignment = .center
        }
        
    }
    
    override func setLayout() {
        routeStackView.snp.makeConstraints{
            $0.edges.equalToSuperview()
        }
        reservationDetailLabel.snp.makeConstraints {
            $0.leading.equalTo(routeStackView.snp.leading)
            $0.top.equalTo(routeStackView.snp.bottom).offset(8)
        }
    }
    
}

#Preview {
    ReservationInfoView()
}
