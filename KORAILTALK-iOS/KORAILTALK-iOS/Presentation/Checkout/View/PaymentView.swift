//
//  PaymentView.swift
//  KORAILTALK-iOS
//
//  Created by sun on 11/21/25.
//

import UIKit

import SnapKit
import Then

final class PaymentView: BaseView {

    // MARK: - Properties

    private let fareLabel = UILabel().then {
        $0.textColor = .gray400
        $0.font = .body1_r_16
        $0.text = "운임"
    }

    private let fareValueLabel = UILabel().then {
        $0.textColor = .gray400
        $0.font = .body1_r_16
        $0.text = nil
    }

    private let feeLabel = UILabel().then {
        $0.textColor = .gray400
        $0.font = .body1_r_16
        $0.text = "요금"
    }

    private let feeValueLabel = UILabel().then {
        $0.textColor = .gray400
        $0.font = .body1_r_16
        $0.text = nil
    }

    private let discountFareLabel = UILabel().then {
        $0.textColor = .gray400
        $0.font = .body1_r_16
        $0.text = "운임할인"
    }

    private let discountFareValueLabel = UILabel().then {
        $0.textColor = .gray400
        $0.font = .body1_r_16
        $0.text = nil
    }

    private let discountFeeLabel = UILabel().then {
        $0.textColor = .gray400
        $0.font = .body1_r_16
        $0.text = "요금할인"
    }

    private let discountFeeValueLabel = UILabel().then {
        $0.textColor = .gray400
        $0.font = .body1_r_16
        $0.text = nil
    }

    private let totalTitleLabel = UILabel().then {
        $0.textColor = .mainBlack
        $0.font = .head2_m_20
        $0.text = "결제금액"
    }

    private let totalValueLabel = UILabel().then {
        $0.textColor = .mainBlack
        $0.font = .head2_m_20
        $0.text = nil
    }

    private let cautionLabel = UILabel().then {
        $0.textColor = .pointRed
        $0.font = .body5_r_13
        $0.numberOfLines = 0
        $0.lineBreakMode = .byWordWrapping
    }

    private lazy var fareRowStack = UIStackView().then {
        $0.axis = .horizontal
        $0.alignment = .fill
        $0.distribution = .equalSpacing
        $0.addArrangedSubviews(fareLabel, fareValueLabel)
    }

    private lazy var feeRowStack = UIStackView().then {
        $0.axis = .horizontal
        $0.alignment = .fill
        $0.distribution = .equalSpacing
        $0.addArrangedSubviews(feeLabel, feeValueLabel)
    }

    private lazy var discountFareRowStack = UIStackView().then {
        $0.axis = .horizontal
        $0.alignment = .fill
        $0.distribution = .equalSpacing
        $0.addArrangedSubviews(discountFareLabel, discountFareValueLabel)
    }

    private lazy var discountFeeRowStack = UIStackView().then {
        $0.axis = .horizontal
        $0.alignment = .fill
        $0.distribution = .equalSpacing
        $0.addArrangedSubviews(discountFeeLabel, discountFeeValueLabel)
    }

    private lazy var totalRowStack = UIStackView().then {
        $0.axis = .horizontal
        $0.alignment = .fill
        $0.distribution = .equalSpacing
        $0.addArrangedSubviews(totalTitleLabel, totalValueLabel)
    }

    private lazy var contentStack = UIStackView().then {
        $0.axis = .vertical
        $0.alignment = .fill
        $0.distribution = .fill
        $0.spacing = 12
        $0.addArrangedSubviews(
            fareRowStack,
            feeRowStack,
            discountFareRowStack,
            discountFeeRowStack,
            totalRowStack,
            cautionLabel
        )
    }

    // MARK: - Init

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Layout

    private func setupLayout() {
        addSubview(contentStack)

        contentStack.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }

        cautionLabel.setAttributedText(
            "*특(우등)실은 운임과 요금으로 구성되며 운임만 할인됩니다.\n*23:09까지 결제하지 않으면 취소됩니다.",
            lineHeightMultiple: 1.09,
            kern: -0.19
        )
    }

    // MARK: - Public

    func updatePrice(
        fare: Int,
        fee: Int,
        discountFare: Int,
        discountFee: Int
    ) {
        fareValueLabel.text = fare.formattedPrice
        feeValueLabel.text = fee.formattedPrice
        discountFareValueLabel.text = discountFare.formattedPrice
        discountFeeValueLabel.text = discountFee.formattedPrice

        let total = fare + fee + discountFare + discountFee
        totalValueLabel.text = total.formattedPrice
    }
}
