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
    
    private func setUI() {
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
    
    private func setStyle() {
        navBarBackgroundView.backgroundColor = .primary700
        reservationInfoView.backgroundColor = .mainWhite
        
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
        
        seatDropdown.configure(placeholder: "전체", items: ["일반실", "특실"])
        serviceDropdown.configure(placeholder: "직통", items: ["환승"])
        
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
        
        reservationListView.setTrainSchedule(TrainSchedule.mockData)
    }
    
    //MARK: - SetLayout
    
    private func setLayout() {
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
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalTo(tagStackView.snp.top)
        }
        
        tagScrollView.snp.makeConstraints {
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
        }
        
        resultLabel.snp.makeConstraints {
            $0.top.equalTo(seatDropdown).offset(10)
            $0.trailing.equalToSuperview().inset(16)
        }
        
        reservationListView.snp.makeConstraints {
            $0.top.equalTo(resultLabel.snp.bottom).offset(26)
            $0.leading.trailing.bottom.equalToSuperview()
        }
    }
    
    //MARK: - SetDelegate
    
    override func setDelegate() { }
    
    //MARK: - SetAddTaget
    
    override func setAddTarget() {
        navBar.onTapBack = { [weak self] in
            self?.navigationController?.popViewController(animated: true)
        }
        
        navBar.onTapReload = { [weak self] in
            self?.reloadTrainList()
        }
    }
    
    //MARK: - Private
    
    private func createButtons() {
        TrainTagType.allCases.forEach { type in
            let button = TrainTagButton(type: type)
            tagStackView.addArrangedSubview(button)
        }
    }
    
    private func resetFiltersAndList() {
        tagStackView.arrangedSubviews.forEach {
            tagStackView.removeArrangedSubview($0)
            $0.removeFromSuperview()
        }
        createButtons()
        
        seatDropdown.configure(placeholder: "전체", items: ["일반실", "특실"])
        serviceDropdown.configure(placeholder: "직통", items: ["환승"])
        
        tagScrollView.setContentOffset(.zero, animated: false)
        
        // TODO: API 연동 시 여기에서 응답 데이터로 교체
        let schedules = TrainSchedule.mockData
        reservationListView.setTrainSchedule(schedules)
        
        resultLabel.text = "결과(\(schedules.count))"
    }
    
    private func reloadTrainList() {
        print("🌟 열차 화면 필터/리스트 초기화 된당")
        
        UIView.animate(withDuration: 0.15, animations: {
            self.reservationListView.alpha = 0.0
        }, completion: { _ in
            self.resetFiltersAndList()
            
            UIView.animate(withDuration: 0.2) {
                self.reservationListView.alpha = 1.0
            }
        })
    }
}

