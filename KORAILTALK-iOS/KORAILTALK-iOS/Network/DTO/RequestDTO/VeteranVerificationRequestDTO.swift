//
//  VeteranVerificationRequestDTO.swift
//  KORAILTALK-iOS
//
//  Created by sumin Kong on 11/26/25.
//

import Foundation

struct VeteranVerificationRequestDTO: Codable {
    let nationalId: String
    let password: String
    let birthdate: String
}
