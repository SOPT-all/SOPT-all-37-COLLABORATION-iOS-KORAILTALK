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

    private var currentAngle: CGFloat = .pi / 2
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupStyle()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupStyle() {
        let image = UIImage.exchange
        
        self.setImage(image, for: .normal)
        self.tintColor = .mainBlack
        self.backgroundColor = .mainWhite
        
        self.layer.cornerRadius = 20
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.gray150.cgColor
        
        self.rotate(to: currentAngle, duration: 0)
    }
    
    func rotateAnimation() {
        currentAngle += .pi
        self.rotate(to: currentAngle)
    }
}
