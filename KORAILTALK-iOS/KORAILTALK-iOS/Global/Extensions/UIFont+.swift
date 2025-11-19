//
//  UIFont+.swift
//
//
//  Created by 한현서 on 11/17/25.
//

import UIKit

enum PretendardWeight: String {
    case regular = "Regular"
    case medium = "Medium"
    case semibold = "SemiBold"

    var systemWeight: UIFont.Weight {
        switch self {
        case .regular:  return .regular
        case .medium:   return .medium
        case .semibold: return .semibold
        }
    }
}

extension UIFont {
    static func pretendard(_ weight: PretendardWeight = .regular, size: CGFloat) -> UIFont {
        let name = "Pretendard-\(weight.rawValue)"
        if let custom = UIFont(name: name, size: size) {
            return custom
        }
        return .systemFont(ofSize: size, weight: weight.systemWeight)
    }

    enum Pretendard {
        case head1_m_30
        case head2_m_20
        case head3_sb_18
        case head4_m_18
        case head5_r_18
        
        case sub1_m_17
        case sub2_r_17
        case sub3_m_16
        
        case body1_r_16
        case body2_m_15
        case body3_r_15
        case body4_m_14
        case body5_r_13
        
        case cap1_m_12
        case cap2_r_12

        var weight: PretendardWeight {
            switch self {
            case .head1_m_30, .head2_m_20, .head4_m_18:
                return .medium
            case .head3_sb_18:
                return .semibold
            case .head5_r_18:
                return .regular
            case .sub1_m_17, .sub3_m_16:
                return .medium
            case .sub2_r_17:
                return .regular
            case .body1_r_16, .body3_r_15, .body5_r_13:
                return .regular
            case .body2_m_15, .body4_m_14:
                return .medium
            case .cap1_m_12:
                return .medium
            case .cap2_r_12:
                return .regular
            }
        }

        var size: CGFloat {
            switch self {
            case .head1_m_30:   return 30
            case .head2_m_20:   return 20
            case .head3_sb_18, .head4_m_18, .head5_r_18:  return 18
            case .sub1_m_17, .sub2_r_17:    return 17
            case .sub3_m_16:    return 16
            case .body1_r_16:   return 16
            case .body2_m_15, .body3_r_15:  return 15
            case .body4_m_14:   return 14
            case .body5_r_13:   return 13
            case .cap1_m_12, .cap2_r_12:    return 12
            }
        }

        var font: UIFont {
            .pretendard(weight, size: size)
        }

        var letterSpacingPercent: CGFloat {
            return -1.5
        }

        var lineHeightPercent: CGFloat {
            return 130
        }
    }

    static var head1_m_30: UIFont { Pretendard.head1_m_30.font }
    static var head2_m_20: UIFont { Pretendard.head2_m_20.font }
    static var head3_sb_18: UIFont { Pretendard.head3_sb_18.font }
    static var head4_m_18: UIFont { Pretendard.head4_m_18.font }
    static var head5_r_18: UIFont { Pretendard.head5_r_18.font }
    
    static var sub1_m_17: UIFont { Pretendard.sub1_m_17.font }
    static var sub2_r_17: UIFont { Pretendard.sub2_r_17.font }
    static var sub3_m_16: UIFont { Pretendard.sub3_m_16.font }
    
    static var body1_r_16: UIFont { Pretendard.body1_r_16.font }
    static var body2_m_15: UIFont { Pretendard.body2_m_15.font }
    static var body3_r_15: UIFont { Pretendard.body3_r_15.font }
    static var body4_m_14: UIFont { Pretendard.body4_m_14.font }
    static var body5_r_13: UIFont { Pretendard.body5_r_13.font }
    
    static var cap1_m_12: UIFont { Pretendard.cap1_m_12.font }
    static var cap2_r_12: UIFont { Pretendard.cap2_r_12.font }
}
