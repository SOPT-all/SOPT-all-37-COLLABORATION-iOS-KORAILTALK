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
    
    private let navBar = NavigationBar(style: .trainLookup)
    private let navBarBackgroundView = UIView()
    private let reservationInfoView = ReservationInfoView()
    private let tagStackView = UIStackView()
    private let tagScrollView = UIScrollView()
    

    override func setView() {
        createButtons()
        setUI()
        setStyle()
        setLayout()
        
       
    }
    
    func setUI() {
        view.backgroundColor = .mainWhite
        view.addSubviews(navBarBackgroundView,navBar,reservationInfoView,tagScrollView)
        tagScrollView.addSubview(tagStackView)
        
    }
    
    func setStyle() {
        navBarBackgroundView.do {
            $0.backgroundColor = .primary700
        }
        
        tagStackView.do {
            $0.axis = .horizontal
            $0.spacing = 8
            $0.distribution = .fillProportionally
            $0.alignment = .leading
            }
        
        tagScrollView.do {
            $0.showsHorizontalScrollIndicator = false
            
        }
    }
    
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
            $0.top.equalTo(navBar.snp.bottom).offset(16)
            $0.trailing.leading.equalToSuperview().inset(16)
            $0.bottom.equalTo(tagStackView.snp.top)
        }
        
        tagScrollView.snp.makeConstraints{
            $0.top.equalTo(reservationInfoView.snp.bottom)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(52)
        
        }
        tagStackView.snp.makeConstraints {
            $0.top.bottom.equalToSuperview()
            $0.leading.trailing.equalToSuperview().offset(16)
        
        }
    }
    
    override func setDelegate() {
        
    }
            
    
    override func setAddTarget() {
        
    }
    
    private func createButtons() {
        TrainTagType.allCases.forEach { type in
            let button = TrainTagButton(type: type)
            
            tagStackView.addArrangedSubview(button)
        }
    }
    
    
    
}
