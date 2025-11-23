//
//  KorailButtonStyle.swift
//  KORAILTALK-iOS
//
//  Created by 한현서 on 11/22/25.
//

import UIKit

enum KorailButtonStyle {
    case primary
    case secondary
    case white
    case gray
    case red
    
    var enabledBackgroundColor: UIColor {
        switch self {
        case .primary:   return .primary700
        case .secondary:   return .primary500
        case .white: return .mainWhite
        case .gray:      return .gray100
        case .red:       return .pointRed
        }
    }
    
    var disabledBackgroundColor: UIColor {
        .gray200
    }
    
    var enabledTitleColor: UIColor {
        switch self {
        case .primary, .secondary, .red:
            return .mainWhite
        case .white, .gray:
            return .mainBlack
        }
    }
    
    var disabledTitleColor: UIColor {
        .gray300
    }
    
    var borderWidth: CGFloat {
        switch self {
        case .white:
            return 1
        case .primary, .secondary, .gray, .red:
            return 0
        }
    }
    
    var borderColor: CGColor? {
        switch self {
        case .white:
            return UIColor.gray200.cgColor
        case .primary, .secondary, .gray, .red:
            return nil
        }
    }
}
