//
//  Int+Discount.swift
//  KORAILTALK-iOS
//
//  Created by sun on 11/27/25.
//

extension Int {
    
    func discount(by percent: Int) -> Int {
        return Int(Double(self) * Double(percent) / 100.0)
    }
    
    func discountedPrice(by percent: Int) -> Int {
        return self - discount(by: percent)
    }
}
