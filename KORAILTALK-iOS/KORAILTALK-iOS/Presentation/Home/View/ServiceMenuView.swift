//
//  ServiceMenuView.swift
//  KORAILTALK-iOS
//
//  Created by 한현서 on 11/22/25.
//

import UIKit
import SnapKit
import Then

final class ServiceMenuView: UIView {
    // MARK: - UI Components
    
    lazy var collectionView = UICollectionView(
        frame: .zero,
        collectionViewLayout: createLayout()
    ).then {
        $0.backgroundColor = .mainWhite
        $0.isScrollEnabled = false
        $0.register(ServiceMenuCell.self, forCellWithReuseIdentifier: ServiceMenuCell.identifier)
    }
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupStyle()
        setupHierarchy()
        setupLayout()
        
        collectionView.addObserver(self, forKeyPath: "contentSize", options: .new, context: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        collectionView.removeObserver(self, forKeyPath: "contentSize")
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "contentSize" {
            if object is UICollectionView {
                if collectionView.contentSize.height > 0 {
                    self.snp.updateConstraints {
                        $0.height.equalTo(collectionView.contentSize.height)
                    }
                }
            }
        }
    }
    
    // MARK: - Setup
    
    private func setupHierarchy() {
        addSubview(collectionView)
    }
    
    private func setupLayout() {
        collectionView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        self.snp.makeConstraints {
                $0.height.equalTo(100)
            }
    }
    
    private func setupStyle() {
        backgroundColor = .white
        layer.cornerRadius = 10
        clipsToBounds = true
    }
    
    // MARK: - Layout Logic
    
    private func createLayout() -> UICollectionViewCompositionalLayout {
        return UICollectionViewCompositionalLayout { (sectionIndex, layoutEnvironment) -> NSCollectionLayoutSection? in
            
            // 1. Item: 셀 하나의 크기
            // widthDimension: .fractionalWidth(0.25) -> 1/4 크기 (한 줄에 4개)
            let itemSize = NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(0.25),
                heightDimension: .fractionalHeight(1.0)
            )
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            
            // 2. Group: 한 줄의 크기
            let groupSize = NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .absolute(110)
            )
            let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
            
            // 3. Section: 그룹들이 모인 섹션
            let section = NSCollectionLayoutSection(group: group)
            section.contentInsets = NSDirectionalEdgeInsets(top: 20, leading: 10, bottom: 20, trailing: 10) // 전체 여백
            section.interGroupSpacing = 10 // 줄 간격
            
            return section
        }
    }
}
