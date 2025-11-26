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
    
    var onTapCancelConfirm: (() -> Void)?
    
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
    
    private let dimView = UIView().then {
        $0.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        $0.alpha = 0
    }
    
    private let modalView = CheckModalView()
    
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
        
        reservationCancelButton.addTarget(self, action: #selector(didTapCancelButton), for: .touchUpInside)
        
        modalView.onNoTapped = { [weak self] in
            self?.dismissModal()
        }
        
        modalView.onConfirmTapped = { [weak self] in
            self?.dismissModal()
            self?.onTapCancelConfirm?()
        }
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
    
    func updateTotalPaymentAmount(_ text: String) {
        totalPaymentAmountLabel.text = text
    }
    
    @objc private func didTapCancelButton() {
        modalView.configure(
            question: "예약을 취소하시겠습니까?",
            confirmText: "예",
            confirmColor: .pointRed,
            showNoButton: true
        )
        
        guard let parentView = superview else { return }
        
        if dimView.superview == nil {
            parentView.addSubview(dimView)
            dimView.snp.makeConstraints {
                $0.edges.equalToSuperview()
            }
        }
        
        if modalView.superview == nil {
            parentView.addSubview(modalView)
            modalView.snp.makeConstraints {
                $0.center.equalToSuperview()
                $0.width.equalToSuperview().multipliedBy(0.8)
                $0.height.equalTo(160)
            }
        }
        
        dimView.alpha = 0
        modalView.alpha = 0
        modalView.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
        
        UIView.animate(withDuration: 0.25) {
            self.dimView.alpha = 1
            self.modalView.alpha = 1
            self.modalView.transform = .identity
        }
    }
    
    private func dismissModal() {
        UIView.animate(withDuration: 0.25, animations: {
            self.dimView.alpha = 0
            self.modalView.alpha = 0
            self.modalView.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
        }, completion: { _ in
            self.dimView.removeFromSuperview()
            self.modalView.removeFromSuperview()
            self.modalView.transform = .identity
        })
    }
}
