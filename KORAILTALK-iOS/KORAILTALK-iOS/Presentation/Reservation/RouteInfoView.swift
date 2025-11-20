//
//  RouteInfoView.swift
//  KORAILTALK-iOS
//
//  Created by sun on 11/20/25.
//

import UIKit
import SnapKit
import Then

final class RouteInfoView: BaseView {

    // MARK: - UI

    private let departureCityLabel = UILabel().then {
        $0.font = .head1_m_30
        $0.textColor = .primary700
        $0.textAlignment = .center
    }

    private let departureTimeLabel = UILabel().then {
        $0.font = .body1_r_16
        $0.textColor = .mainBlack
        $0.textAlignment = .center
    }

    private let arrivalCityLabel = UILabel().then {
        $0.font = .head1_m_30
        $0.textColor = .primary700
        $0.textAlignment = .center
    }

    private let arrivalTimeLabel = UILabel().then {
        $0.font = .body1_r_16
        $0.textColor = .mainBlack
        $0.textAlignment = .center
    }

    private let arrowImageView = UIImageView().then {
        $0.image = UIImage.right.withRenderingMode(.alwaysTemplate)
        $0.tintColor = .gray300
        $0.contentMode = .scaleAspectFit
    }

    private lazy var departureStackView = UIStackView(arrangedSubviews: [
        departureCityLabel,
        departureTimeLabel
    ]).then {
        $0.axis = .vertical
        $0.alignment = .center
        $0.spacing = 8
    }

    private lazy var arrivalStackView = UIStackView(arrangedSubviews: [
        arrivalCityLabel,
        arrivalTimeLabel
    ]).then {
        $0.axis = .vertical
        $0.alignment = .center
        $0.spacing = 8
    }

    private lazy var contentStackView = UIStackView(arrangedSubviews: [
        departureStackView,
        arrowImageView,
        arrivalStackView
    ]).then {
        $0.axis = .horizontal
        $0.alignment = .center
        $0.spacing = 67
        $0.distribution = .fill
    }

    // MARK: - Setup

    override func setUI() {
        addSubview(contentStackView)
    }

    override func setStyle() {
        backgroundColor = .clear
    }

    override func setLayout() {
        contentStackView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }

        arrowImageView.snp.makeConstraints {
            $0.width.height.equalTo(12)
        }
    }

    // MARK: - Public

    func configure(
        departureCity: String,
        departureTime: String,
        arrivalCity: String,
        arrivalTime: String
    ) {
        departureCityLabel.text = departureCity
        departureTimeLabel.text = departureTime
        arrivalCityLabel.text = arrivalCity
        arrivalTimeLabel.text = arrivalTime
    }
}

