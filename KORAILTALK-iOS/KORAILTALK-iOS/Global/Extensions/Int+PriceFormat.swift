//
//  Int+PriceFormat.swift
//  KORAILTALK-iOS
//
//  Created by sun on 11/21/25.
//

import Foundation

private extension Formatter {
    static let price: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        return formatter
    }()
}

extension Int {
    var formattedPrice: String {
        let absolute = abs(self)
        let number = NSNumber(value: absolute)
        let text = Formatter.price.string(from: number) ?? "\(absolute)"
        let sign = self < 0 ? "-" : ""
        return sign + text + "원"
    }
}
