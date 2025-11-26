//
//  ReservationViewController.swift
//  KORAILTALK-iOS
//
//  Created by 어재선 on 11/26/25.
//

import UIKit

import SnapKit
import Then

final class ReservationViewController: BaseViewController {
    
    
    //MARK: - UI
    
    private let navBar = NavigationBar(style: .trainLookup)
    private let navBarBackgroundView = UIView()
    private let reservationInfoView = ReservationInfoView()
    private let tagStackView = UIStackView()
    private let tagScrollView = UIScrollView()
    
    private let seatDropdown = ReservationDropdownView()
    private let serviceDropdown = ReservationDropdownView()
    private let dropdownStackView = UIStackView()
    private let resultLabel = UILabel()
    
    private let reservationListView = ReservationListView()
    
    //MARK: - SetView
    
    override func setView() {
        createButtons()
        setUI()
        setStyle()
        setLayout()
    }
    
    //MARK: - SetUI
    
    func setUI() {
        view.backgroundColor = .gray100
        view.addSubviews(
            navBarBackgroundView,
            navBar,
            reservationListView,
            reservationInfoView,
            tagScrollView,
            dropdownStackView,
            resultLabel
            
        )
        tagScrollView.addSubview(tagStackView)
        
    }
    
    //MARK: - SetStyle
    
    func setStyle() {
        navBarBackgroundView.do {
            $0.backgroundColor = .primary700
        }
        
        reservationInfoView.do {
            $0.backgroundColor = .mainWhite
        }
        
        tagStackView.do {
            $0.axis = .horizontal
            $0.spacing = 8
            $0.distribution = .fillProportionally
            $0.alignment = .center
            
        }
        
        tagScrollView.do {
            $0.showsHorizontalScrollIndicator = false
            $0.backgroundColor = .mainWhite
        }
        
        seatDropdown.do {
            $0.configure(placeholder: "전체", items: ["일반실", "특실"])
        }
        
        serviceDropdown.do {
            $0.configure(placeholder: "직통", items: ["환승"])
        }
        
        dropdownStackView.do {
            $0.addArrangedSubviews(seatDropdown, serviceDropdown)
            $0.axis = .horizontal
            $0.spacing = 8
            
        }
        
        resultLabel.do {
            $0.font = .cap1_m_12
            $0.textColor = .mainBlack
            $0.text = "결과(12)"
            $0.textAlignment = .center
        }
        
        reservationListView.do {
            $0.setTrainSchedule(TrainSchedule.mockData)
        }
        
        
    }
    
    //MARK: - SetLayout
    
    func setLayout() {
        navBarBackgroundView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.bottom.equalTo(navBar.snp.top)
        }
        
        navBar.snp.makeConstraints {
            $0.top.equalToSuperview().offset(50)
            $0.leading.trailing.equalToSuperview()
        }
        reservationInfoView.snp.makeConstraints {
            $0.top.equalTo(navBar.snp.bottom)
            $0.trailing.leading.equalToSuperview()
            $0.bottom.equalTo(tagStackView.snp.top)
        }
        
        tagScrollView.snp.makeConstraints{
            $0.top.equalTo(reservationInfoView.snp.bottom)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(52)
            
        }
        tagStackView.snp.makeConstraints {
            $0.top.bottom.equalToSuperview()
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.centerY.equalToSuperview()
            
        }
        
        dropdownStackView.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(16)
            $0.top.equalTo(tagScrollView.snp.bottom).offset(16)
            $0.trailing.lessThanOrEqualTo(resultLabel.snp.leading)
            $0.bottom.equalToSuperview()
            
        }
        
        resultLabel.snp.makeConstraints {
            $0.top.equalTo(seatDropdown).offset(10)
            $0.trailing.equalToSuperview().inset(16)
        }
        
        reservationListView.snp.makeConstraints {
            $0.top.equalTo(resultLabel.snp.bottom).offset(10+16)
            $0.leading.trailing.bottom.equalToSuperview()
        }
        
    }
    
    //MARK: - SetDelegate
    
    override func setDelegate() {
        
    }
    
    //MARK: - SetAddTaget
    
    override func setAddTarget() {
        
    }
    
    //MARK: - Private
    
    private func createButtons() {
        TrainTagType.allCases.forEach { type in
            let button = TrainTagButton(type: type)
            
            tagStackView.addArrangedSubview(button)
        }
    }
    
    
    
}
