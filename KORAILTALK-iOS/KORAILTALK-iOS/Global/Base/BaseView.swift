//
//  BaseView.swift
//  KORAILTALK-iOS
//
//  Created by 어재선 on 11/17/25.
//

import UIKit

class BaseView: UIView {

    override init(frame: CGRect) {
            super.init(frame: frame)
            setUI()
            setStyle()
            setLayout()
        }
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        func setStyle() {
            backgroundColor = .mainWhite
        }
        
        func setUI() {}
        
        func setLayout() {}

}

