//
//  DisCountView.swift
//  KORAILTALK-iOS
//
//  Created by sumin Kong on 11/24/25.
//

import UIKit

import SnapKit
import Then

class DisCountView: BaseView {
    
    private let veteransLabel = UILabel().then{
        $0.font = .sub3_m_16
        $0.textColor = .mainBlack
        $0.text = "보훈 번호"
        $0.textAlignment = .left
    }
    private let veteransTextField = UITextField().then{
        $0.font = .body1_r_16
        $0.textColor = .gray400
        $0.placeholder = "보훈번호 9자리"
        $0.textAlignment = .left
    }
    
    private lazy var veteransStack = UIStackView().then {
        $0.axis = .horizontal
        $0.alignment = .fill
        $0.distribution = .equalSpacing
        $0.addArrangedSubviews(veteransLabel, veteransTextField)
    }
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
    override func setStyle() {}
        
    /// UI 위계 설정 (addSubView 등)
    override func setUI() {
        addSubviews(veteransStack)
    }
        
    /// 오토레이아웃 설정 (SnapKit 코드 관련)
    override func setLayout() {
        veteransStack.snp.makeConstraints {
            $0.top.equalToSuperview().inset(16)
            $0.leading.trailing.equalToSuperview().inset(16)
        }
    }

    
}
