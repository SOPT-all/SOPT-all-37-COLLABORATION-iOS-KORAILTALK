//
//  TicketSearchFormView.swift
//  KORAILTALK-iOS
//
//  Created by 한현서 on 11/24/25.
//

import UIKit
import SnapKit
import Then

final class TicketSearchFormView: BaseView{
    
    var isBusanDestination = true
    
    private let departureRow = StationRowView(title: "출발", station: "서울")
    private let separator1 = UIView()
    
    private let arrivalRow = StationRowView(title: "도착", station: "부산")
    private let separator2 = UIView()
    
    private let dateRow = InfoRowView(image: UIImage(named: "calendar"), content: "11.10 (월) · 14시 이후")
    private let separator3 = UIView()
    
    private let passengerRow = InfoRowView(image: UIImage(named: "person"), content: "어른 1명")
    
    lazy var switchButton = StationSwitchButton().then {
        $0.addTarget(self, action: #selector(switchButtonTapped), for: .touchUpInside)
    }
    
    let searchButton = KorailButton(title: "열차조회", style: .primary)
    
    override func setStyle() {
        self.backgroundColor = .mainWhite
        self.layer.cornerRadius = 10
        
        self.layer.shadowColor = UIColor.mainBlack.cgColor
        self.layer.shadowOpacity = 0.1
        self.layer.shadowOffset = CGSize(width: 0, height: 4)
        self.layer.shadowRadius = 10
        
        [separator1, separator2, separator3].forEach {
            $0.backgroundColor = .gray150
        }
        
    }
    
    override func setUI() {
        addSubviews(departureRow, separator1, arrivalRow, separator2, dateRow, separator3, passengerRow, switchButton, searchButton)
    }
    
    override func setLayout() {
        let rowHeight = 55
        
        departureRow.snp.makeConstraints {
            $0.top.equalToSuperview().offset(10)
            $0.horizontalEdges.equalToSuperview()
            $0.height.equalTo(rowHeight)
        }
        
        separator1.snp.makeConstraints {
            $0.top.equalTo(departureRow.snp.bottom)
            $0.horizontalEdges.equalToSuperview().inset(20)
            $0.height.equalTo(1)
        }
        
        switchButton.snp.makeConstraints {
            $0.size.equalTo(40)
            $0.trailing.equalToSuperview().inset(27)
            $0.centerY.equalTo(separator1)
        }
        
        arrivalRow.snp.makeConstraints {
            $0.top.equalTo(separator1.snp.bottom)
            $0.horizontalEdges.equalToSuperview()
            $0.height.equalTo(rowHeight)
        }
        
        separator2.snp.makeConstraints {
            $0.top.equalTo(arrivalRow.snp.bottom)
            $0.horizontalEdges.equalToSuperview().inset(20)
            $0.height.equalTo(1)
        }
        
        dateRow.snp.makeConstraints {
            $0.top.equalTo(separator2.snp.bottom)
            $0.horizontalEdges.equalToSuperview()
            $0.height.equalTo(rowHeight)
        }
        
        separator3.snp.makeConstraints {
            $0.top.equalTo(dateRow.snp.bottom)
            $0.horizontalEdges.equalToSuperview().inset(20)
            $0.height.equalTo(1)
        }
        
        passengerRow.snp.makeConstraints {
            $0.top.equalTo(separator3.snp.bottom)
            $0.horizontalEdges.equalToSuperview()
            $0.height.equalTo(rowHeight)
        }
        
        searchButton.snp.makeConstraints {
            $0.top.equalTo(passengerRow.snp.bottom).offset(20)
            $0.horizontalEdges.equalToSuperview().inset(20)
            $0.height.equalTo(50)
            $0.bottom.equalToSuperview().inset(20)
        }
    }
    
    // MARK: - Logic
    
    func switchStations() {
        isBusanDestination.toggle()
        
        if isBusanDestination {
            departureRow.updateStation("서울")
            arrivalRow.updateStation("부산")
        } else {
            departureRow.updateStation("부산")
            arrivalRow.updateStation("서울")
        }
    }
    
    @objc private func switchButtonTapped() {
        switchButton.rotateAnimation()
        switchStations()
    }
}
