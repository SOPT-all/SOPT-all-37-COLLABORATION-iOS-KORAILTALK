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

        let dto = baseResponse.data

        return dto.toDomain()
    }
}
