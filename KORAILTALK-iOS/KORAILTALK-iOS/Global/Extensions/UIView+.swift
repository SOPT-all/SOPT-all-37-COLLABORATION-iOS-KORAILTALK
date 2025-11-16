//
//  UIView+.swift
//  KORAILTALK-iOS
//
//  Created by sun on 11/17/25.
//

import UIKit

extension UIView {
    func addSubviews(_ views: UIView...) {
        views.forEach {
            addSubview($0)
        }
    }
}
