//
//  VeteranVerificationResponseDTO.swift
//  KORAILTALK-iOS
//
//  Created by sumin Kong on 11/26/25.
//

import Foundation

struct VeteranVerification {
    let verified: Bool
}

struct VeteranVerificationResponseDTO: ResponseModelType {
    let verified: Bool
}

extension VeteranVerificationResponseDTO {
    func toDomain() -> VeteranVerification {
        VeteranVerification(verified: self.verified)
    }
}
