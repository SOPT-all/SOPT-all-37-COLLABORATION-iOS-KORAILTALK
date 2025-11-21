//
//  UILabel+.swift
//  KORAILTALK-iOS
//
//  Created by sun on 11/21/25.
//

import UIKit

extension UILabel {
    func setAttributedText(
        _ text: String,
        lineHeightMultiple: CGFloat,
        kern: CGFloat
    ) {
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = lineHeightMultiple

        let attributed = NSMutableAttributedString(
            string: text,
            attributes: [
                .kern: kern,
                .paragraphStyle: paragraphStyle
            ]
        )
        attributed.addAttribute(.font, value: font as Any, range: NSRange(location: 0, length: attributed.length))
        attributed.addAttribute(.foregroundColor, value: textColor as Any, range: NSRange(location: 0, length: attributed.length))

        self.attributedText = attributed
    }
}
