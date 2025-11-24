//
//  ServiceMenuCell.swift
//  KORAILTALK-iOS
//
//  Created by 한현서 on 11/22/25.
//

import UIKit
import SnapKit
import Then

final class ServiceMenuCell: UICollectionViewCell {
    static let identifier = "ServiceMenuCell"
    
    // MARK: - UI Components
    
    private let iconImageView = UIImageView().then {
        $0.contentMode = .scaleAspectFit
        $0.tintColor = UIColor(named: "primary_400")
    }
    
    private let titleLabel = UILabel().then {
        $0.font = .body4_m_14
        $0.textColor = .mainBlack
        $0.textAlignment = .center
    }
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupHierarchy()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup
    
    private func setupHierarchy() {
        contentView.addSubview(iconImageView)
        contentView.addSubview(titleLabel)
    }
    
    private func setupLayout() {

        iconImageView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(28)
            $0.centerX.equalToSuperview()
            $0.size.equalTo(24)
        }
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(iconImageView.snp.bottom).offset(7)
            $0.leading.trailing.equalToSuperview().inset(2)
            $0.bottom.lessThanOrEqualToSuperview().offset(-5)
        }
    }
    
    // MARK: - Configure
    
    func configure(model: ServiceMenuModel) {
        titleLabel.text = model.title
        iconImageView.image = model.serviceImage?.withRenderingMode(.alwaysTemplate)
    }
}
