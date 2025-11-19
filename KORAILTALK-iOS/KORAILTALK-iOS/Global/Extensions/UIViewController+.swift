//
//  UIViewController+.swift
//  KORAILTALK-iOS
//
//  Created by sumin Kong on 11/19/25.
//

import UIKit

extension UIViewController {
    
    func hideKeyboardWhenTappedAround() {
        let tapped = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tapped.cancelsTouchesInView = false
        view.addGestureRecognizer(tapped)
    }
    
    @objc
    func dismissKeyboard() {
        view.endEditing(true)
    }
}
