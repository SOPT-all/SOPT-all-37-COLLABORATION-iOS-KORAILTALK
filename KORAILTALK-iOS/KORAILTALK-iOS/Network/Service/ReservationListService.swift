//
//  ReservationListService.swift
//  KORAILTALK-iOS
//
//  Created by 어재선 on 11/27/25.
//

import Foundation

protocol ReservationListServiceProtocol {
    func getReservationList() async throws -> TrainSearchResult
}

final class ReservationListService: BaseService<ReservationListTargetType>, ReservationListServiceProtocol {

    func getReservationList() async throws -> TrainSearchResult {
        let baseResponse: BaseResponseBody<TrainSearchResponseDTO> =
        try await request(with: .fetchReservationTypeKTX)

        guard let dto = baseResponse.data else {
            throw NetworkError.responseError
        }
        return dto.toDomain()
    }
}
