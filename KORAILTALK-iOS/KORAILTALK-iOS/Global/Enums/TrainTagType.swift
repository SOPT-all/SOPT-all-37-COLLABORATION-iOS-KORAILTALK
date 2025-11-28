//
//  TrainTagType.swift
//  KORAILTALK-iOS
//
//  Created by 어재선 on 11/19/25.
//

import UIKit

struct TrainTagTypeStyle {
    let backgroundColor: UIColor
    let titleColor: UIColor
    let borderColor: UIColor?
}

enum TrainTagType: String, CaseIterable {
    case all
    case srt = "SRT"
    case ktx = "KTX"
    case itxMaeumSeamaeul = "ITX"
    case mugunghwa = "FLOWER"

    
    var title: String {
        switch self {
        case .all:
            return "전체"
        case .ktx:
            return "KTX"
        case .srt:
            return "SRT"
        case .itxMaeumSeamaeul:
            return "ITX-마음/새마을"
        case .mugunghwa:
            return "무궁화"
        }
    }
    
    func style(isSelected: Bool) -> TrainTagTypeStyle {
        if isSelected {
            return TrainTagTypeStyle(
                backgroundColor: .mainBlack,
                titleColor: .mainWhite,
                borderColor: nil
            )
        } else {
            return TrainTagTypeStyle(
                backgroundColor: .mainWhite,
                titleColor: .mainBlack,
                borderColor: .gray200
            )
        }
    }
}

extension TrainTagType {
    static func from(apiType: String) -> TrainTagType {
        switch apiType {
        case "KTX":
            return .ktx
        case "KTX-S":
            return .ktx
        case "KTX-C":
            return .ktx
        case "SRT":
            return .srt
        case "ITX_S":
            return .itxMaeumSeamaeul
        case "ITX_M":
            return .itxMaeumSeamaeul
        case "FLOWER":
            return .mugunghwa
        default:
            return .all
        }
    }
}

extension TrainTagType {
    var queryTrainType: String? {
        switch self {
        case .all:
            return nil
        default:
            return self.rawValue
        }
    }
}
