//
//  ReservationModal.swift
//  KORAILTALK-iOS
//
//  Created by sumin Kong on 11/25/25.
//

import UIKit

import SnapKit
import Then

final class ReservationModal: BaseView {
    // MARK: - Properties
    private let time: String
    private let trainNameType: TrainNameType
    private let trainNumber: String
    private let generalPrice: String
    private let specialPrice: String
    
    // MARK: - UI Components
    private let containerView = UIView().then {
        $0.backgroundColor = .mainWhite
        $0.layer.cornerRadius = 12
        $0.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
    }
    private let handleView = UIView().then {
       $0.backgroundColor = .gray300
       $0.layer.cornerRadius = 2.5
    }
   
   private let timeLabel = UILabel().then {
       $0.text = ""
       $0.font = .head2_m_20
       $0.textColor = .primary400
       $0.textAlignment = .center
   }
    private lazy var trainInfoView: TrainInfoView = {
        return TrainInfoView(trainName: trainNameType, trainNumber: trainNumber, isDisabled: false)
    }()
    private lazy var generalSeatView = PriceTagView(roomLabel: "일반실", price: generalPrice)
    private lazy var specialSeatView = PriceTagView(roomLabel: "특실", price: specialPrice)
    
    
    private let reservationButton = UIButton().then{
        $0.setTitle("예매하기", for: .normal)
        $0.backgroundColor = .primary700
        $0.setTitleColor(.mainWhite, for: .normal)
        $0.layer.cornerRadius = 8
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor.gray200.cgColor
    }
    
    private let selectSeatButton = UIButton().then {
        $0.setTitle("좌석선택", for: .normal)
        $0.backgroundColor = .mainWhite
        $0.setTitleColor(.mainBlack, for: .normal)
        $0.layer.cornerRadius = 8
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor.gray200.cgColor
    }
    
    private let buttonStack = UIStackView().then {
        $0.axis = .horizontal
        $0.spacing = 12
        $0.distribution = .fillEqually
    }

   // MARK: - Init
    init(time: String, trainNameType: TrainNameType, trainNumber: String, generalPrice: String,
         specialPrice: String){
        self.time = time
        self.trainNameType = trainNameType
        self.trainNumber = trainNumber
        self.generalPrice = generalPrice
        self.specialPrice = specialPrice
        super.init(frame: .zero)
        
        timeLabel.text = time
        setupLayout()
        setupSeatActions()
   }
       
   required init?(coder: NSCoder) {
       fatalError("init(coder:) has not been implemented")
   }
       
       
   // MARK: - Layout
   private func setupLayout() {
       addSubview(containerView)
       containerView.snp.makeConstraints {
           $0.leading.trailing.bottom.equalToSuperview()
           $0.height.equalTo(300)
       }
       
       containerView.addSubview(handleView)
       handleView.snp.makeConstraints {
           $0.top.equalToSuperview().offset(8)
           $0.centerX.equalToSuperview()
           $0.width.equalTo(56)
           $0.height.equalTo(4)
       }
       
       containerView.addSubview(timeLabel)
       timeLabel.snp.makeConstraints {
           $0.top.equalTo(handleView.snp.bottom).offset(18)
           $0.centerX.equalToSuperview()
       }
       
       containerView.addSubview(trainInfoView)
       trainInfoView.snp.makeConstraints {
           $0.top.equalTo(timeLabel.snp.bottom).offset(12)
           $0.centerX.equalToSuperview()
       }
       
       containerView.addSubview(generalSeatView)
       generalSeatView.snp.makeConstraints {
           $0.top.equalTo(trainInfoView.snp.bottom).offset(12)
           $0.leading.trailing.equalToSuperview().inset(16)
           $0.height.equalTo(45)
       }
       
       containerView.addSubview(specialSeatView)
       specialSeatView.snp.makeConstraints {
           $0.top.equalTo(generalSeatView.snp.bottom).offset(12)
           $0.leading.trailing.equalToSuperview().inset(16)
           $0.height.equalTo(45)
       }
       
       buttonStack.addArrangedSubviews(selectSeatButton, reservationButton)
       buttonStack.do {
           $0.axis = .horizontal
           $0.spacing = 12
           $0.distribution = .fillEqually
       }
       
       containerView.addSubview(buttonStack)
       buttonStack.snp.makeConstraints {
           $0.top.equalTo(specialSeatView.snp.bottom).offset(12)
           $0.leading.trailing.equalToSuperview().inset(16)
           $0.height.equalTo(48)
       }
   }
    
    //MARK: - Button Action
    private func setupSeatActions() {
        generalSeatView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(selectGeneralSeat)))
        specialSeatView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(selectSpecialSeat)))
    }

    // MARK: - SeatButton toggle
    @objc private func selectGeneralSeat() {
        guard !generalSeatView.isDisabled else { return }

        if generalSeatView.isSelected {
            generalSeatView.isSelected = false
            specialSeatView.isDisabled = false
        } else {
            generalSeatView.isSelected = true
            specialSeatView.isSelected = false
            specialSeatView.isDisabled = true
        }
    }

    @objc private func selectSpecialSeat() {
        guard !specialSeatView.isDisabled else { return }

        if specialSeatView.isSelected {
            specialSeatView.isSelected = false
            generalSeatView.isDisabled = false
        } else {
            specialSeatView.isSelected = true
            generalSeatView.isSelected = false
            generalSeatView.isDisabled = true
        }
    }
}
