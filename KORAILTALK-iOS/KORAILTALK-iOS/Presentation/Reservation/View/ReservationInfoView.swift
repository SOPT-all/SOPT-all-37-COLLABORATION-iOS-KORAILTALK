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
    
    private let leftButton = UIButton()
    private let rightButton = UIButton()
    private let dateTitleLabel = UILabel()
    private let dateLabel = UILabel()
    private let dateStackView = UIStackView()
    
    
    private let checkBox = CheckBox()
    private let checkBoxLabel = UILabel()
    private let checkBoxStackView = UIStackView()
    
    //MARK: - SetUI
    
    override func setUI() {
        addSubviews(routeStackView,reservationDetailLabel,dateStackView, checkBoxStackView)
    }
    //MARK: - SetStyle
    
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
        
        leftButton.do {
            $0.setImage(UIImage(named: "leftarrow"), for: .normal)
            
        }
        
        dateTitleLabel.do {
            $0.text = "가는 날 "
            $0.font = .body4_m_14
            $0.textColor = .gray400
            $0.textAlignment = .center
        }
        
        
        dateLabel.do {
            $0.text = "11월 10일 (화)"
            $0.font = .body4_m_14
            $0.textColor = .mainBlack
            $0.textAlignment = .center
        }
        rightButton.do {
            $0.setImage(UIImage(named: "rightarrow"), for: .normal)
        }
        
        dateStackView.do {
            $0.addArrangedSubviews(leftButton, dateTitleLabel, dateLabel, rightButton)
            $0.axis = .horizontal
            $0.spacing = 11
        }
        
        checkBoxLabel.do {
            $0.text = "예약가능"
            $0.font = .body2_m_15
            $0.textColor = .gray500
        }
        
        checkBoxStackView.do {
            $0.addArrangedSubviews(checkBox,checkBoxLabel)
            $0.axis = .horizontal
            $0.spacing = 0
        }
    }
    
    //MARK: - SetLayout
    
    override func setLayout() {
        routeStackView.snp.makeConstraints{
            $0.leading.top.equalToSuperview()
            $0.trailing.lessThanOrEqualToSuperview()
        }
        
        reservationDetailLabel.snp.makeConstraints {
            $0.leading.equalTo(routeStackView.snp.leading)
            $0.top.equalTo(routeStackView.snp.bottom).offset(8)
        }
        
        dateStackView.snp.makeConstraints {
            $0.leading.equalTo(routeStackView.snp.leading)
            $0.top.equalTo(reservationDetailLabel.snp.bottom).offset(27)
            $0.bottom.equalTo(checkBoxStackView.snp.bottom)
            $0.trailing.lessThanOrEqualTo(checkBoxStackView.snp.leading).offset(-8)
        }
        
        checkBoxStackView.snp.makeConstraints {
            $0.top.equalTo(reservationDetailLabel.snp.bottom).offset(27)
            $0.trailing.equalToSuperview()
            $0.bottom.equalToSuperview()
            
        }
    }
    
}
