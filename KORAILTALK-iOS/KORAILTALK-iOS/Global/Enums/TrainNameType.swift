//
//  TrainNameType.swift
//  KORAILTALK-iOS
//
//  Created by 어재선 on 11/20/25.
//

import UIKit

enum TrainNameType: String, CaseIterable {
    case ktx
    case srt
    case itxSaemaeul
    case itxMaeum
    case mugunghwa
    
    var title: String {
        switch self {
        case .ktx:
            return "KTX"
        case .srt:
            return "SRT"
        case .itxSaemaeul:
            return "ITX-새마을"
        case .itxMaeum:
            return "ITX-마음"
        case .mugunghwa:
            return "무궁화"
        }
    }
    
    var backgroundColor: UIColor {
        switch self {
        case .ktx:
            return .primary700
        case .srt:
            return .secondaryP400
        case .itxSaemaeul, .itxMaeum:
            return .secondaryM400
        case .mugunghwa:
            return .piontOrange
            
        }
    }
    
    func backgroundColor(isDisabled: Bool) -> UIColor {
        if isDisabled {
            return .gray200
        } else {
            return self.backgroundColor
        }
    }
}

