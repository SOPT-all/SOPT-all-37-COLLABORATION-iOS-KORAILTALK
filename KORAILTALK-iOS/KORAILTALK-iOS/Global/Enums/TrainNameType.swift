//
//  TrainNameType.swift
//  KORAILTALK-iOS
//
//  Created by 어재선 on 11/20/25.
//

import UIKit


enum TrainNameType: String, CaseIterable {
    case ktx = "KTX"
    case ktxSancheon = "KTX-S"
    case ktxCheongryong = "KTX-C"
    case itxSaemaeul = "ITX-N"
    case itxMaeum = "ITX-M"
    case mugunghwa = "FLOWER"
    
    var title: String {
        switch self {
        case .ktx:
            return "KTX"
        case .ktxSancheon:
            return "KTX-산천"
        case .ktxCheongryong:
            return "KTX-청룡"
        case .itxSaemaeul:
            return "ITX-새마을"
        case .itxMaeum:
            return "ITX-마음"
        case .mugunghwa:
            return "무궁화호"
        }
    }
    
    var backgroundColor: UIColor {
        switch self {
        case .ktx, .ktxSancheon, .ktxCheongryong:
            return .primary700
        case .itxSaemaeul, .itxMaeum:
            return .secondaryM400
        case .mugunghwa:
            return .pointOrange
        }
    }
    
    func backgroundColor(isDisabled: Bool) -> UIColor {
        if isDisabled {
            return .gray200
        } else {
            return self.backgroundColor
        }
    }
    
    // 서버 값 → Enum 변환
    init(rawValue: String) {
        switch rawValue {
        case "KTX":
            self = .ktx
        case "KTX-S":
            self = .ktxSancheon
        case "KTX-C":
            self = .ktxCheongryong
        case "ITX-N":
            self = .itxSaemaeul
        case "ITX-M":
            self = .itxMaeum
        case "FLOWER":
            self = .mugunghwa
        default:
            self = .ktx
        }
    }
}
