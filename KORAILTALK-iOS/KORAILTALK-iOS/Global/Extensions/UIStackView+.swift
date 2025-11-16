//
//  UIStackView+.swift
//  KORAILTALK-iOS
//
//  Created by sun on 11/17/25.
//

import UIKit

extension UIStackView {
    func addArrangedSubviews(_ views: UIView...) {
        views.forEach {
            self.addArrangedSubview($0)
        }
    }
}
