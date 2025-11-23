//
//  TicketSearchComponents.swift
//  KORAILTALK-iOS
//
//  Created by 한현서 on 11/24/25.
//

import UIKit
import SnapKit
import Then

// MARK: - StationRowView (출발/도착)

final class StationRowView: BaseView{
    private let titleLabel = UILabel().then{
        $0.font = .body2_m_15
        $0.textColor = .gray400
    }
    
    let stationLabel = UILabel().then {
        $0.font = .head2_m_20
        $0.textColor = .mainBlack
    }
    
    init (title: String, station: String){
        super.init(frame: CGRect.zero)
        titleLabel.text = title
        stationLabel.text = station
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setUI() {
        addSubviews(titleLabel)
        addSubviews(stationLabel)
    }
    
    override func setLayout() {
        titleLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(20)
            $0.centerY.equalToSuperview()
            $0.width.equalTo(40)
        }
        
        stationLabel.snp.makeConstraints {
            $0.leading.equalTo(titleLabel.snp.trailing).offset(20)
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview().inset(20)
        }
    }
    
    func updateStation(_ name: String) {
            stationLabel.text = name
    }
}


// MARK: - InfoRowView (날짜/인원)

final class InfoRowView: BaseView{
    
    private let iconImageView = UIImageView().then{
        $0.contentMode = .scaleAspectFit
        $0.tintColor = .gray300
    }
    
    private let contentLabel = UILabel().then {
        $0.font = .sub3_m_16
        $0.textColor = .mainBlack
    }
    
    init(iconName: String, content: String) {
        super.init(frame: .zero)
        iconImageView.image = UIImage(systemName: iconName)
        contentLabel.text = content
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setUI() {
        addSubview(iconImageView)
        addSubview(contentLabel)
    }
    
    override func setLayout() {
        iconImageView.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(20)
            $0.centerY.equalToSuperview()
            $0.size.equalTo(24)
        }
        
        contentLabel.snp.makeConstraints {
            $0.leading.equalTo(iconImageView.snp.trailing).offset(20)
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview().inset(20)
        }
    }
}
