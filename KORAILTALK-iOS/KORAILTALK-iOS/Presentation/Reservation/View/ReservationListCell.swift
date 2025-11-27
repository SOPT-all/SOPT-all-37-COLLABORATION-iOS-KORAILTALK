//
//  ReservationListCell.swift
//  KORAILTALK-iOS
//
//  Created by 어재선 on 11/25/25.
//

import UIKit

import SnapKit
import Then

final class ReservationListCell: UICollectionViewCell,ReuseIdentifiable {
    
    //MARK: - UI
    
    private let traininfoView = TrainInfoView()

    private let departureTimeLabel = UILabel()
    private let arrowImageView = UIImageView()
    private let arrivalTimeLabel = UILabel()
    private let trainTimeStackView = UIStackView()
    
    private let durationLabel = UILabel()
   
    private let normalSeatStatus = SeatStatusView()
    private let premiumSeatStatus = SeatStatusView()
    private let seatStatusStackView = UIStackView()
    
    
    //MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUI()
        setStyle()
        setLayout()
        
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setUI()
        setStyle()
        setLayout()
    }
    
    override func prepareForReuse() {
           super.prepareForReuse()
           
           layer.backgroundColor = UIColor.white.cgColor
           layer.borderColor = UIColor.gray150.cgColor
           
           departureTimeLabel.text = nil
           arrivalTimeLabel.text = nil
           durationLabel.text = nil
           
           normalSeatStatus.isHidden = true
           premiumSeatStatus.isHidden = true
           
       }
    
    //MARK: - SetUI
    
    private func setUI() {
        contentView.addSubviews(
            traininfoView,
            trainTimeStackView,
            durationLabel,
            seatStatusStackView
        )
        layer.backgroundColor = UIColor.white.cgColor
        layer.cornerRadius = 12
        layer.borderWidth = 1
        layer.borderColor = UIColor.gray150.cgColor
        
    }
    
    //MARK: - SetStyle
    
    private func setStyle() {
        
        departureTimeLabel.do {
            $0.font = .head2_m_20
            $0.textColor = .mainBlack
            $0.textAlignment = .center
        }
        
        arrowImageView.do {
            $0.image = .rightTextarrowIcon
        }
        
        arrivalTimeLabel.do {
            $0.font = .head2_m_20
            $0.textColor = .mainBlack
            $0.textAlignment = .center
        }
        
        durationLabel.do {
            $0.font = .body4_m_14
            $0.textColor = .gray400
            $0.textAlignment = .center
        }
        
        trainTimeStackView.do {
            $0.addArrangedSubviews(departureTimeLabel, arrowImageView, arrivalTimeLabel)
            $0.axis = .horizontal
            $0.spacing = 8
            $0.alignment = .center
        }
        
        seatStatusStackView.do {
            $0.addArrangedSubviews(normalSeatStatus,
                                   premiumSeatStatus)
            $0.axis = .horizontal
            $0.spacing = 10
            $0.alignment = .center
        }
    }
    
    //MARK: - SetLayout
    
    private func setLayout() {
        traininfoView.snp.makeConstraints {
            $0.leading.top.equalToSuperview().inset(16)
            $0.trailing.lessThanOrEqualToSuperview()
        }
        trainTimeStackView.snp.makeConstraints {
            $0.leading.equalTo(traininfoView)
            $0.top.equalTo(traininfoView.snp.bottom).offset(12)
            $0.trailing.lessThanOrEqualToSuperview()
        }
        durationLabel.snp.makeConstraints {
            $0.leading.equalTo(trainTimeStackView.snp.trailing).offset(16)
            $0.top.bottom.equalTo(trainTimeStackView)
            $0.centerY.equalTo(trainTimeStackView)
            $0.trailing.lessThanOrEqualToSuperview()
        }
        
        seatStatusStackView.snp.makeConstraints {
            $0.top.equalTo(trainTimeStackView.snp.bottom).offset(12)
            $0.leading.equalTo(traininfoView.snp.leading)
            $0.bottom.trailing.lessThanOrEqualToSuperview()
        }
    }
    
    //MARK: - Public
    
    func configure(schedule: TrainSchedule) {
        
        let isEmptySeat = schedule.normalSeatStatus == .soldOut && schedule.premiumSeatStatus == .soldOut
        
        
        traininfoView.configure(trainName: schedule.type, trainNumber: schedule.trailNumber, isDisabled: isEmptySeat)
        if isEmptySeat {
            layer.backgroundColor = UIColor.gray100.cgColor
        }
        
        if let normalStatus = schedule.normalSeatStatus,
           normalStatus != .soldOut {
            normalSeatStatus.isHidden = false
            normalSeatStatus.configure(
                seatType: .normal,
                seatStatus: normalStatus
            )
        } else {
            normalSeatStatus.isHidden = true
        }

        if let premiumStatus = schedule.premiumSeatStatus,
           premiumStatus != .soldOut {
            premiumSeatStatus.isHidden = false
            premiumSeatStatus.configure(
                seatType: .premium,
                seatStatus: premiumStatus
            )
        } else {
            premiumSeatStatus.isHidden = true
        }
        
        departureTimeLabel.text = schedule.startAt
        arrivalTimeLabel.text = schedule.arriveAt
        durationLabel.text = schedule.formattedDuration
    }
}

#Preview {
    ReservationListCell()
}

