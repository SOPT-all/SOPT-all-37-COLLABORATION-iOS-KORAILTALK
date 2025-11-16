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
        
        /// UI 컴포넌트 속성 설정 (do 메서드 관련)
        func setStyle() {}
        
        /// UI 위계 설정 (addSubView 등)
        func setUI() {}
        
        /// 오토레이아웃 설정 (SnapKit 코드 관련)
        func setLayout() {}

}

