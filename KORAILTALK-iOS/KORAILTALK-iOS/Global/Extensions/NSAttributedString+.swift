//
//  NSAttributedString+.swift
//  KORAILTALK-iOS
//
//  Created by sun on 11/20/25.
//

import UIKit

extension NSAttributedString {
    static func pretendardString(
        _ text: String,
        style: UIFont.Pretendard,
        alignment: NSTextAlignment? = nil,
        isSingleLine: Bool = false
    ) -> NSAttributedString {
        let font = style.font
        let paragraph = NSMutableParagraphStyle()
        
        if let alignment {
            paragraph.alignment = alignment
        }

        if !isSingleLine {
            let lineHeight = font.pointSize * (style.lineHeightPercent / 100.0)
            paragraph.minimumLineHeight = lineHeight
            paragraph.maximumLineHeight = lineHeight
        }

        let kern = (style.letterSpacingPercent / 100.0) * font.pointSize

        return NSAttributedString(
            string: text,
            attributes: [
                .font: font,
                .kern: kern,
                .paragraphStyle: paragraph
            ]
        )
    }
}
