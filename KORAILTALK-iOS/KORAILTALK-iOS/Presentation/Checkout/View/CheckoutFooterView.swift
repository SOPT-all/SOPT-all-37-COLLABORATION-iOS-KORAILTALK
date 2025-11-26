//
//  CheckoutFooterView.swift
//  KORAILTALK-iOS
//
//  Created by sun on 11/23/25.
//

import UIKit

import SnapKit
import Then

final class CheckoutFooterView: BaseView {

    // MARK: - Properties

    private let totalPaymentContainerView = UIView().then {
        $0.backgroundColor = .primary700
    }

    private let bottomButtonContainerView = UIView().then {
        $0.backgroundColor = .primary200
    }

    private let totalPaymentTitleLabel = UILabel().then {
        $0.text = "총 결제 금액"
        $0.textColor = .mainWhite
        $0.font = .body2_m_15
    }

    private let totalPaymentAmountLabel = UILabel().then {
        $0.textColor = .mainWhite
        $0.font = .body1_r_16
    }

    private let reservationCancelButton = UIButton(type: .system).then {
        $0.setTitle("예약취소", for: .normal)
        $0.setTitleColor(.primary700, for: .normal)
        $0.titleLabel?.font = .body1_r_16
    }

    private let nextStepButton = UIButton(type: .system).then {
        $0.setTitle("다음", for: .normal)
        $0.setTitleColor(.primary700, for: .normal)
        $0.titleLabel?.font = .body1_r_16
    }

    private lazy var bottomButtonStackView = UIStackView(arrangedSubviews: [
        reservationCancelButton,
        nextStepButton
    ]).then {
        $0.axis = .horizontal
        $0.distribution = .fillEqually
    }

    // MARK: - Setup

    override func setUI() {
        addSubviews(
            totalPaymentContainerView,
            bottomButtonContainerView
        )

        totalPaymentContainerView.addSubviews(
            totalPaymentTitleLabel,
            totalPaymentAmountLabel
        )

        bottomButtonContainerView.addSubview(bottomButtonStackView)
    }

    override func setLayout() {
        totalPaymentContainerView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.height.equalTo(84)
        }

        bottomButtonContainerView.snp.makeConstraints {
            $0.top.equalTo(totalPaymentContainerView.snp.bottom)
            $0.leading.trailing.bottom.equalToSuperview()
            $0.height.equalTo(70)
        }

        totalPaymentTitleLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(20)
            $0.centerY.equalToSuperview()
        }

        totalPaymentAmountLabel.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(20)
            $0.centerY.equalToSuperview()
        }

        bottomButtonStackView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.height.equalTo(56)
        }
    }

    // MARK: - Public

    func updateTotalPaymentAmount(_ text: String) {
        totalPaymentAmountLabel.text = text
    }
}

