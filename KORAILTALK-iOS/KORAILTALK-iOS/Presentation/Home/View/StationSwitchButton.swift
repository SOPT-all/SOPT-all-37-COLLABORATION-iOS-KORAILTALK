//
//  StationSwitchButton.swift
//  KORAILTALK-iOS
//
//  Created by 한현서 on 11/24/25.
//

import UIKit
import Then
import SnapKit

final class StationSwitchButton: UIButton {

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupStyle()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupStyle() {
        // 아이콘 설정
        let config = UIImage.SymbolConfiguration(pointSize: 16, weight: .medium)
        let image = UIImage(systemName: "arrow.up.arrow.down", withConfiguration: config)
        
        self.setImage(image, for: .normal)
        self.tintColor = .black
        self.backgroundColor = .white
        
        // 원형 및 테두리
        self.layer.cornerRadius = 20
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.systemGray5.cgColor
    }
    
    // 버튼 자체의 회전 애니메이션 메서드
    func rotateAnimation() {
        UIView.animate(withDuration: 0.25) {
            self.transform = self.transform.rotated(by: .pi)
        }
    }
}
