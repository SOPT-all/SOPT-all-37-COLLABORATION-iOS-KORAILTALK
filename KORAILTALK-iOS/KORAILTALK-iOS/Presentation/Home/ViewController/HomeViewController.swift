//
//  HomeViewController.swift
//  KORAILTALK-iOS
//
//  Created by 한현서 on 11/20/25.
//

import Foundation
import UIKit
import SnapKit

final class HomeViewController: UIViewController {
    
    // MARK: - Properties
    
    private let menuData = ServiceMenuModel.mockData
    
    // MARK: - UI Components
    
    private let serviceMenuView = ServiceMenuView()
    
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupStyle()
        setupDelegate()
        setupHierarchy()
        setupLayout()
    }
    
    // MARK: - Setup Actions
    
    private func setupStyle() {
        view.backgroundColor = .gray50
    }
    
    private func setupDelegate() {
        serviceMenuView.collectionView.dataSource = self
        serviceMenuView.collectionView.delegate = self
    }
    
    private func setupHierarchy() {
        view.addSubview(serviceMenuView)
    }
    
    private func setupLayout() {
        serviceMenuView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(20)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(600)
        }
        
    }
}

// MARK: - UICollectionView DataSource & Delegate

extension HomeViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    // 아이템 개수: 데이터 배열의 개수만큼
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return menuData.count
    }
    
    // 셀 구성: 어떤 모양의 셀을 보여줄지
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: ServiceMenuCell.identifier,
            for: indexPath
        ) as? ServiceMenuCell else {
            return UICollectionViewCell()
        }
        
        // 데이터 전달
        cell.configure(model: menuData[indexPath.item])
        
        return cell
    }
    
    // 셀 클릭 시 동작
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("\(menuData[indexPath.item].title) 클릭됨!")
    }
}
