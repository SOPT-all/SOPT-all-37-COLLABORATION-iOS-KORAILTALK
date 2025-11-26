//
//  DividerView.swift
//  KORAILTALK-iOS
//
//  Created by sun on 11/26/25.
//

import UIKit

final class DividerView: BaseView {

    // MARK: - Init

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }

    // MARK: - Setup

    private func setup() {
        backgroundColor = .gray150
    }

    override var intrinsicContentSize: CGSize {
        .init(width: UIView.noIntrinsicMetric, height: 1)
    }
}

