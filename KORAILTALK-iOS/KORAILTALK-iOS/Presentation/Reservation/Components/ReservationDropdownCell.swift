//
//  ReservationDropdownCell.swift
//  KORAILTALK-iOS
//
//  Created by 어재선 on 11/24/25.
//

import UIKit

import SnapKit
import Then

final class ReservationDropdownCell: UITableViewCell {

    // MARK: - UI
    
    private let titleLabel = UILabel()

    // MARK: - Properties
    
    static let reuseIdentifier = "ReservationDropdownCell"

    // MARK: - Init
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUI()
        setStyle()
        setLayout()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setUI()
        setStyle()
        setLayout()
    }

    // MARK: - SetUI
    
    private func setUI() {
        selectionStyle = .none
        contentView.addSubview(titleLabel)
        
    }
    
    // MARK: - SetStyle
    
    private func setStyle() {
        titleLabel.do {
            $0.font = .body1_r_16
            $0.textColor = .gray500
        }
        
    }
    
    // MARK: - SetLayout
    
    private func setLayout() {
        titleLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(8)
            $0.trailing.equalToSuperview().inset(2)
            $0.centerY.equalToSuperview()
        }
    }

    // MARK: - Configure
    
    func configure(text: String, isSelected: Bool) {
        titleLabel.text = text
        contentView.backgroundColor = isSelected ? .primary200 : .mainWhite
    }
}



