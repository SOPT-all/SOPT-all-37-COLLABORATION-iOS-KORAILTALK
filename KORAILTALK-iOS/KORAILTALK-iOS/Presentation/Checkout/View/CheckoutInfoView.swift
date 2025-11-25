//
//  CheckoutInfoView.swift
//  KORAILTALK-iOS
//
//  Created by sun on 11/23/25.
//

import UIKit

import SnapKit
import Then

final class CheckoutInfoView: BaseView {
    
    // MARK: - Properties
    
    private let termsDescriptionLabel = UILabel().then {
        $0.textColor = UIColor.gray400
        $0.font = .cap2_r_12
        $0.numberOfLines = 0
        $0.lineBreakMode = .byWordWrapping
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 1.3
        
        let text =
        """
        · 추가로 할인 가능한 항목이 있으신 경우 할인을 적용해주세요.
        · 추가 할인은 어른/청소년 기준, 예매한 매수만큼 적용할 수 있습니다.
        · 할인승차권 이용시에는 관련 신분증 또는 증명서를 소지하셔야 합니다.
        · 할인 승차권의 할인율은 별도의 공지 없이 변경될 수 있습니다.
        · 할인은 운임에만 적용하고 요금은 미적용(특실/우등실은 운임과 요금으
          로 구분)되며, 최저운임 이하로 할인하지 않습니다.
        
        · 경증: 장애의 정도가 심하지 않은 장애인 (구 4-6급)
        · 중증: 장애의 정도가 심한 장애인 (구 1-3급)
        """
        
        $0.attributedText = .pretendardString(
            text,
            style: .cap2_r_12
        )
    }
    
    // MARK: - Initializer
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureViewHierarchy()
        configureLayout()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configureViewHierarchy()
        configureLayout()
    }
    
    // MARK: - Layout
    
    private func configureViewHierarchy() {
        backgroundColor = .gray50
        addSubview(termsDescriptionLabel)
    }
    
    private func configureLayout() {
        termsDescriptionLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(24)
            make.leading.trailing.equalToSuperview().inset(16)
            make.bottom.equalToSuperview().inset(24)
        }
    }
}

