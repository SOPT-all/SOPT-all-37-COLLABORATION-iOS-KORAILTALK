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
    
    private let ticketSearchFormView = TicketSearchFormView()
    private let serviceMenuView = ServiceMenuView()
    
    override func setView() {
        setupStyle()
        setupHierarchy()
        setupLayout()
    }
    
    // ?
    override func setDelegate() {
        serviceMenuView.collectionView.dataSource = self
        serviceMenuView.collectionView.delegate = self
    }
    
    private func setupStyle() {
        view.backgroundColor = .gray50
    }
    
    private func setupHierarchy() {
        view.addSubview(ticketSearchFormView)
        view.addSubview(serviceMenuView)
    }
    
    private func setupLayout() {
        ticketSearchFormView.snp.makeConstraints{
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(20)
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.height.equalTo(324)
        }
        
        serviceMenuView.snp.makeConstraints {
            $0.top.equalTo(ticketSearchFormView.snp.bottom).offset(20)
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.height.equalTo(260)
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
