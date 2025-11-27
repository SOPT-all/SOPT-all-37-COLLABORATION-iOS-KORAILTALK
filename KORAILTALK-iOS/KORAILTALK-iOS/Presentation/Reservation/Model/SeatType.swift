//
//  SeatType.swift
//  KORAILTALK-iOS
//
//  Created by 어재선 on 11/21/25.
//

import UIKit

enum SeatStatus: String, CaseIterable {
    case available
    case almostSoldOut
    
    var title: String {
        switch self {
        case .available:
            return "예약가능"
        case .almostSoldOut:
            return "매진임박"
        }
    }
    
    var textColor: UIColor {
        switch self {
        case .available:
            return .gray400
        case .almostSoldOut:
            return .pointRed
        }
    }
    
}

enum SeatType: String, CaseIterable {
    case normal = "NORMAL"
    case premium = "PREMIUM"
    
    var title: String {
        switch self {
        case .normal: 
            return "일반"
        case .premium: 
            return "특"
        }
    }
}
