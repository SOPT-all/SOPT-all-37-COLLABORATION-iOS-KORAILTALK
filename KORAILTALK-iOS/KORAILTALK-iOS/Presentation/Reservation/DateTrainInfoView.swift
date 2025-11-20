//
//  DateTrainInfoView.swift
//  KORAILTALK-iOS
//
//  Created by sun on 11/20/25.
//

import UIKit

import SnapKit
import Then

final class DateTrainInfoView: UIView {

    private let dateLabel = UILabel().then {
        $0.numberOfLines = 1
        $0.textColor = .mainBlack
        $0.textAlignment = .center
    }

    private let trainInfoLabel = UILabel().then {
        $0.numberOfLines = 1
        $0.textColor = .mainBlack
        $0.textAlignment = .center
    }

    // MARK: - Init

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }

    // MARK: - Public

    func configure(dateText: String, trainInfoText: String) {
        dateLabel.attributedText = .pretendardString(
            dateText,
            style: .head5_r_18,
            alignment: .center,
            isSingleLine: true
        )

        trainInfoLabel.attributedText = .pretendardString(
            trainInfoText,
            style: .head5_r_18,
            alignment: .center,
            isSingleLine: true
        )
    }

    // MARK: - Private

    private func setupUI() {
        addSubviews(dateLabel, trainInfoLabel)

        dateLabel.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
        }

        trainInfoLabel.snp.makeConstraints {
            $0.top.equalTo(dateLabel.snp.bottom).offset(12)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
    }
}
