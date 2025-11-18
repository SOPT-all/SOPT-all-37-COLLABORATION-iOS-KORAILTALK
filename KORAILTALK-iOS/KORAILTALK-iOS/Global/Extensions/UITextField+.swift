//
//  UITextField.swift
//  KORAILTALK-iOS
//
//  Created by sumin Kong on 11/18/25.
//

import UIKit

extension UITextField {
    func addLeftPadding(_ width: CGFloat = 12) {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: width, height: self.frame.height))
        self.leftView = paddingView
        self.leftViewMode = ViewMode.always
    }
    
    func addRightPadding(_ width: CGFloat = 12) {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: width, height: self.frame.height))
        self.rightView = paddingView
        self.rightViewMode = ViewMode.always
    }
    
    func addPadding(leftAmount: CGFloat = 12, rightAmount: CGFloat = 12){
        addLeftPadding(leftAmount)
        addRightPadding(rightAmount)
    }
}
