//
//  TrainInfoView.swift
//  KORAILTALK-iOS
//
//  Created by 어재선 on 11/20/25.
//

import UIKit

import SnapKit
import Then

final class TrainInfoView: BaseView {
    
    let trainName: TrainNameType
    let trainNumber: String
    let isDisabled: Bool
    
    init(trainName: TrainNameType, trainNumber: String, isDisabled: Bool) {
        self.trainName = trainName
        self.trainNumber = trainNumber
        self.isDisabled = isDisabled
        super.init(frame: .zero)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private lazy var trainNameLabel = TrainNameLabel(trainName: trainName, isDisable: isDisabled)
    private let trainNumberLabel = UILabel()
    private let trainInofoStackView = UIStackView()
    
    override func setUI() {
        addSubviews(trainInofoStackView)
    }
    
    override func setStyle() {
        trainNumberLabel.do {
            $0.text = trainNumber
            $0.font = .body4_m_14
            $0.textColor = .mainBlack
            $0.textAlignment = .center
        }
        
        trainInofoStackView.do {
            $0.addArrangedSubviews(trainNameLabel,trainNumberLabel)
            $0.axis = .horizontal
            $0.spacing = 4
            $0.alignment = .center
        }
    }
    
    override func setLayout() {
        trainInofoStackView.snp.makeConstraints{
            $0.edges.equalToSuperview()
        }
    }
    
}
