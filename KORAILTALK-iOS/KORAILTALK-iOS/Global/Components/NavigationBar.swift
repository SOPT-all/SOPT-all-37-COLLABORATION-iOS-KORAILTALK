//
//  NavigationBar.swift
//  KORAILTALK-iOS
//
//  Created by sumin Kong on 11/20/25.
//

import UIKit

import SnapKit
import Then

final class NavigationBar: UIView {
    private let backButton = UIButton(type: .system)
    private let titleLabel = UILabel()
    
    private let reloadButton = UIButton(type: .system)
    private let cancelButton = UIButton(type: .system)
    private let hamburgerButton = UIButton(type: .system)
    private let translateImageView = UIImageView(image: UIImage(named: "translate"))
    private let logoImageView = UIImageView(image: UIImage(named: "logo-svg"))
    
    private let rightWrap = UIView()
    
    enum NavigationBarStyle {
        case home
        case trainLookup
        case payment
    }
    
    private let fixedHeight: CGFloat = 44
    
    override var intrinsicContentSize: CGSize{
        return CGSize(width: UIView.noIntrinsicMetric, height: fixedHeight)
    }
    
    init(style: NavigationBarStyle) {
        super.init(frame: .zero)
        setupUI()
        configureContents(for: style)
        setupLayout(for: style)
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
        setupLayout(for: .home)
    }
    
    //MARK: - UI
    private func setupUI() {
        backgroundColor = .primary700
        backButton.setImage(UIImage(named: "back"), for: .normal)
                backButton.tintColor = .white
                
        reloadButton.setImage(UIImage(named: "reload"), for: .normal)
        reloadButton.tintColor = .white
        
        cancelButton.setImage(UIImage(named: "cancel"), for: .normal)
        cancelButton.tintColor = .white
        
        hamburgerButton.setImage(UIImage(named: "hamburger"), for: .normal)
        hamburgerButton.tintColor = .white
        
        logoImageView.contentMode = .scaleAspectFit
                
        titleLabel.font = .sub3_m_16
        titleLabel.textColor = .white
        titleLabel.textAlignment = .center
    }
    
    private func configureContents(for style: NavigationBarStyle) {
        
        subviews.forEach { $0.removeFromSuperview() }
        rightWrap.subviews.forEach { $0.removeFromSuperview() }
        
        switch style {
        case .home:
            addSubview(logoImageView)
            addSubview(rightWrap)
            rightWrap.addSubviews(translateImageView, hamburgerButton)
        case .payment:
            addSubview(backButton)
            addSubview(titleLabel)
            addSubview(rightWrap)
            titleLabel.text = "결제"
            rightWrap.addSubview(cancelButton)
        case .trainLookup:
            addSubview(backButton)
            addSubview(titleLabel)
            addSubview(rightWrap)
            titleLabel.text = "열차 조회"
            rightWrap.addSubviews(reloadButton, hamburgerButton)
        }
    }
    
    //MARK: - Layout
    private func setupLayout(for style: NavigationBarStyle) {
        switch style {
            case .home:
                logoImageView.snp.makeConstraints {
                    $0.leading.equalToSuperview().offset(12)
                    $0.centerY.equalToSuperview()
                    $0.width.equalTo(82)
                    $0.height.equalTo(20)
                }
                rightWrap.snp.makeConstraints {
                    $0.trailing.equalToSuperview()
                    $0.centerY.equalToSuperview()
                }
                [translateImageView, hamburgerButton].forEach {
                    $0.snp.makeConstraints {
                        $0.centerY.equalToSuperview()
                        $0.height.equalTo(fixedHeight)
                        $0.width.equalTo(fixedHeight)
                    }
                }
                translateImageView.snp.makeConstraints {
                    $0.trailing.equalTo(hamburgerButton.snp.leading)
                }
                hamburgerButton.snp.makeConstraints {
                    $0.trailing.equalToSuperview()
                }
            case .payment:
                backButton.snp.makeConstraints {
                    $0.leading.equalToSuperview()
                    $0.centerY.equalToSuperview()
                    $0.size.equalTo(fixedHeight)
                }
                titleLabel.snp.makeConstraints {
                    $0.center.equalToSuperview()
                }
                rightWrap.snp.makeConstraints {
                    $0.trailing.equalToSuperview()
                    $0.centerY.equalToSuperview()
                    $0.height.equalTo(fixedHeight)
                    $0.width.equalTo(fixedHeight)
                }
                cancelButton.snp.makeConstraints {
                    $0.centerY.equalToSuperview()
                    $0.height.equalTo(fixedHeight)
                    $0.width.equalTo(fixedHeight)
                    $0.trailing.equalToSuperview()
                }
            case .trainLookup:
                backButton.snp.makeConstraints {
                    $0.leading.equalToSuperview()
                    $0.centerY.equalToSuperview()
                    $0.size.equalTo(fixedHeight)
                }
                titleLabel.snp.makeConstraints {
                    $0.center.equalToSuperview()
                }
                rightWrap.snp.makeConstraints {
                    $0.trailing.equalToSuperview()
                    $0.centerY.equalToSuperview()
                }
                [reloadButton, hamburgerButton].forEach {
                    $0.snp.makeConstraints { make in
                        make.centerY.equalToSuperview()
                        make.height.equalTo(fixedHeight)
                        make.width.equalTo(fixedHeight)
                    }
                }
                reloadButton.snp.makeConstraints {
                    $0.trailing.equalTo(hamburgerButton.snp.leading)
                }
                hamburgerButton.snp.makeConstraints {
                    $0.trailing.equalToSuperview()
                }
            }
        
    }
}
