//
//  String+VeteranNumber.swift
//  KORAILTALK-iOS
//
//  Created by sumin Kong on 11/25/25.
//

import Foundation

extension String {
    var isValidVeteranNumber: Bool {
        let regex = "^\\d{2}-\\d{6}$"
        return NSPredicate(format: "SELF MATCHES %@", regex)
            .evaluate(with: self)
    }
}
