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
    case ktx = "KTX"
    case ktxSancheon = "KTX-S"
    case ktxCheongryong = "KTX-C"
    case itxSaemaeul = "ITX-N"
    case itxMaeum = "ITX-M"
    case mugunghwa = "FLOWER"

    
    var title: String {
        switch self {
        case .all:
            return "전체"
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
