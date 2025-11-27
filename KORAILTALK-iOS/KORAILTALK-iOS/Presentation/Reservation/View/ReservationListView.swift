//
//  ReservationListView.swift
//  KORAILTALK-iOS
//
//  Created by 어재선 on 11/25/25.
//

import UIKit

import SnapKit
import Then

final class ReservationListView: BaseView {
    
    //MARK: - UI
    
    private let collectionViewlayout = UICollectionViewFlowLayout()
    private lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewlayout)
    
    //MARK: - Properties
    
    private var trainSchedules: [TrainSchedule] = []

    
    //MARK: - SetUI
    
    override func setUI() {
        addSubviews(collectionView)
    }
    
    //MARK: - SetStyle
    
    override func setStyle() {
        
        collectionViewlayout.do {
            $0.scrollDirection = .vertical
        }
        
        collectionView.do {
            $0.delegate = self
            $0.dataSource = self
            $0.register(ReservationListCell.self, forCellWithReuseIdentifier: ReservationListCell.reuseIdentifier)
            $0.backgroundColor = .gray100
            $0.showsVerticalScrollIndicator = false

        }
    }
    
    //MARK: - SetStyle
    
    override func setLayout() {
        collectionView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    
    //MARK: - Public
    
    func setTrainSchedule(_ trainSchedules: [TrainSchedule]) {
        self.trainSchedules = trainSchedules
        collectionView.reloadData()
    }
    
}

// MARK: - UICollectionViewDataSource

extension ReservationListView: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        trainSchedules.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: ReservationListCell.reuseIdentifier,
                for: indexPath
            ) as? ReservationListCell else {
                return UICollectionViewCell()
            }
        cell.configure(schedule: trainSchedules[indexPath.row])
        
        return cell
    }
    
}

// MARK: - UICollectionViewDelegate

extension ReservationListView: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        //TODO: -  셀이 선택 되었을 때 동작 만들기
        
    }
}

//MARK: - UICollectionViewDelegateFlowLayout

extension ReservationListView: UICollectionViewDelegateFlowLayout {
   
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let horizontalInset: CGFloat = 16
        let width = collectionView.bounds.width - (horizontalInset * 2)
        
        let isSoldOut = (trainSchedules[indexPath.row].normalSeatStatus  == .soldOut && trainSchedules[indexPath.row].premiumSeatStatus  == .soldOut)
        
        if isSoldOut {
            return CGSize(width: width, height: 96)
        }
        return CGSize(width: width, height: 128)
      }

      func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
          return 8
      }
      
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
          return UIEdgeInsets(top: 8, left: 16, bottom: 0, right: 16)
      }
}
