//
//  CheckoutDropdownOptionCell.swift
//  KORAILTALK-iOS
//
//  Created by sun on 11/19/25.
//

import UIKit

import SnapKit
import Then

final class CheckoutDropdownOptionCell: UITableViewCell {

    // MARK: - UI
    
    private let titleLabel = UILabel().then {
        $0.font = .body1_r_16
        $0.textColor = .mainBlack
    }

    // MARK: - Properties
    
    static let reuseIdentifier = "DropdownOptionCell"

    // MARK: - Init
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }

    // MARK: - UI Setup
    
    private func setupUI() {
        selectionStyle = .none
        
        contentView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(12)
            $0.centerY.equalToSuperview()
        }
    }

    // MARK: - Configure
    
    func configure(text: String, isSelected: Bool) {
        titleLabel.text = text
        contentView.backgroundColor = isSelected ? .primary200 : .mainWhite
    }
}

