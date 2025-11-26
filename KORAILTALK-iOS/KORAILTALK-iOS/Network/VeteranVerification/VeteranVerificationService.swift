//
//  VeteranVerificationService.swift
//  KORAILTALK-iOS
//
//  Created by sumin Kong on 11/26/25.
//

import Foundation

protocol VeteranVerificationServiceProtocol {
    func verifyVeteran(nationalId: String, password: String, birthdate: String) async throws -> VeteranVerification
}

final class VeteranVerificationService: BaseService<VeteranVerificationTargetType>, VeteranVerificationServiceProtocol {
    
    func verifyVeteran(nationalId: String, password: String, birthdate: String) async throws -> VeteranVerification {
        let baseResponse: BaseResponseBody<VeteranVerificationResponseDTO> =
            try await request(with: .postVeteranVerification(nationalId: nationalId, password: password, birthdate: birthdate))
        guard let dto = baseResponse.data else {
            throw NetworkError.responseError
        }
        return dto.toDomain()
    }
}
