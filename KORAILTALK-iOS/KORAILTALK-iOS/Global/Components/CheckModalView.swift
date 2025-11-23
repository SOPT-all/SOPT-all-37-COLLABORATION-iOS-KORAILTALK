//
//  CheckModalView.swift
//  KORAILTALK-iOS
//
//  Created by sumin Kong on 11/23/25.
//

import UIKit

import SnapKit
import Then

enum ModalType: CaseIterable {
    case cancel
    case delete
    
    var question: String {
        switch self {
        case .cancel:
            return "예약을 취소하시겠습니까?"
        case .delete:
            return "해당 카테고리를 삭제할까요?"
        }
    }
}

final class CheckModalView: BaseView {

    private let modalType: ModalType
    
    private let questionLabel = UILabel()
    private let confirmButton = UIButton()
    private let noButton = UIButton()
    
    // MARK: - Init

    init(modalType: ModalType){
        self.modalType = modalType
        super.init(frame: .zero)
        setupUI()
        configureContents()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        backgroundColor = .mainWhite
        layer.cornerRadius = 12
        
        noButton.setTitle("아니오", for: .normal)
        noButton.backgroundColor = .gray100
        noButton.setTitleColor(.mainBlack, for: .normal)
        noButton.layer.cornerRadius = 8
        confirmButton.layer.cornerRadius = 8
        confirmButton.setTitleColor(.mainWhite, for: .normal)
        
        addSubviews(questionLabel)
        questionLabel.textAlignment = .center
        questionLabel.font = .sub3_m_16
        questionLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(40)
            $0.leading.trailing.equalToSuperview().inset(12)
        }
        addSubview(confirmButton)
        
        if modalType == .cancel {
            addSubview(noButton)
            noButton.snp.makeConstraints {
                $0.height.equalTo(40)
                $0.leading.equalToSuperview().inset(12)
                $0.bottom.equalToSuperview().inset(12)
            }
            confirmButton.snp.makeConstraints {
                $0.trailing.equalToSuperview().inset(12)
                $0.leading.equalTo(noButton.snp.trailing).offset(8)
                $0.height.equalTo(40)
                $0.bottom.equalToSuperview().inset(12)
                $0.width.equalTo(136)
            }
        }else{
            confirmButton.snp.makeConstraints {
                $0.trailing.leading.equalToSuperview().inset(12)
                $0.height.equalTo(40)
                $0.bottom.equalToSuperview().inset(12)
            }
        }
    }
    
    
    private func configureContents() {
        questionLabel.text = modalType.question
        
        if modalType == .cancel {
            confirmButton.setTitle("예", for: .normal)
            confirmButton.backgroundColor = .pointRed
        }
        else{
            confirmButton.setTitle("확인", for: .normal)
            confirmButton.backgroundColor = .primary500
        }
    }
}
