//
//  HomeInformationService.swift
//  KORAILTALK-iOS
//
//  Created by 한현서 on 11/27/25.
//

import Foundation

protocol HomeInformationServiceProtocol {
    func getHomeInformation() async throws -> HomeInformation
}

final class HomeInformationService: BaseService<HomeInformationTargetType>, HomeInformationServiceProtocol {
    
    func getHomeInformation() async throws -> HomeInformation {
        let baseResponse: BaseResponseBody<HomeInformationResponseDTO> = try await request(with: .getHomeInformation)
        guard let dto = baseResponse.data else {
            throw NetworkError.responseError
        }
        
        return dto.toDomain()
    }
}
