//
//  UIView+Rotation.swift
//  KORAILTALK-iOS
//
//  Created by sun on 11/19/25.
//

import UIKit

extension UIView {
    
    func setRotation(expanded: Bool,
                     duration: TimeInterval = 0.25) {
        let angle: CGFloat = expanded ? 0 : .pi
        
        UIView.animate(withDuration: duration) {
            self.transform = CGAffineTransform(rotationAngle: angle)
        }
    }
    
    func rotate(to angle: CGFloat,
                duration: TimeInterval = 0.25,
                completion: (() -> Void)? = nil) {
        UIView.animate(withDuration: duration,
                       animations: {
            self.transform = CGAffineTransform(rotationAngle: angle)
        }, completion: { _ in
            completion?()
        })
    }
}
