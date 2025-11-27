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
    case soldOut
    
    var title: String {
        switch self {
        case .available:
            return "예약가능"
        case .almostSoldOut:
            return "매진임박"
        case .soldOut:
            return "매진"
        }
    }
    
    var textColor: UIColor {
        switch self {
        case .available:
            return .gray400
        case .almostSoldOut:
            return .pointOrange
        case .soldOut:
            return .pointRed
        }
    }
    
    init(serverValue: String) {
        switch serverValue {
        case "예약가능":
            self = .available
        case "매진임박":
            self = .almostSoldOut
        case "매진" :
            self = .soldOut
        default:
            self = .soldOut
        }
    }
}

enum SeatType: String, CaseIterable {
    case normal
    case premium
    
    var title: String {
        switch self {
        case .normal:
            return "일반"
        case .premium:
            return "특"
        }
    }
}
