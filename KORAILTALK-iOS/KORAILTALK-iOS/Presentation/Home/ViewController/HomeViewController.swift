//
//  HomeViewController.swift
//  KORAILTALK-iOS
//
//  Created by 한현서 on 11/20/25.
//

import UIKit
import SnapKit
import Then

final class HomeViewController: BaseViewController {
    
    // MARK: - Properties
    
    private let menuData = ServiceMenuModel.mockData
    
    // MARK: - UI Components
    private let headerBackgroundView = UIView().then {
        $0.backgroundColor = .primary700
    }
    private let navBar = NavigationBar(style: .home)
    private let titleLabel = UILabel().then {
        $0.font = .head3_sb_18
        $0.textColor = .primary700
        $0.text = "어디로 가시겠어요?"
    }
    private let ticketSearchFormView = TicketSearchFormView()
    private let serviceMenuView = ServiceMenuView()
    
    override func setView() {
        setupStyle()
        setupHierarchy()
        setupLayout()
    }
    
    override func setDelegate() {
        serviceMenuView.collectionView.dataSource = self
        serviceMenuView.collectionView.delegate = self
    }
    
    private func setupStyle() {
        view.backgroundColor = .gray50
    }
    
    private func setupHierarchy() {
        view.addSubview(headerBackgroundView)
        view.addSubview(navBar)
        view.addSubview(titleLabel)
        view.addSubview(ticketSearchFormView)
        view.addSubview(serviceMenuView)
    }
    
    private func setupLayout() {
        headerBackgroundView.snp.makeConstraints{
            $0.top.equalToSuperview()
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(35)
        }
        
        navBar.snp.makeConstraints{
            $0.top.equalTo(headerBackgroundView.snp.bottom)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(35)
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(navBar.snp.bottom).offset(16)
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.height.equalTo(23)
        }
        
        ticketSearchFormView.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(16.5)
            $0.leading.trailing.equalToSuperview().inset(16)
        }
        
        serviceMenuView.snp.makeConstraints {
            $0.top.equalTo(ticketSearchFormView.snp.bottom).offset(16)
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.bottom.lessThanOrEqualTo(view.safeAreaLayoutGuide).inset(16)
            $0.height.equalTo(280)
        }
    }
    
}

// MARK: - UICollectionView DataSource & Delegate

extension HomeViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return menuData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: ServiceMenuCell.identifier,
            for: indexPath
        ) as? ServiceMenuCell else {
            return UICollectionViewCell()
        }
        
        cell.configure(model: menuData[indexPath.item])
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("\(menuData[indexPath.item].title) 클릭됨!")
    }
}
