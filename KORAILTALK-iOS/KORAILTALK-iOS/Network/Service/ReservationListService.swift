//
//  ReservationListService.swift
//  KORAILTALK-iOS
//
//  Created by 어재선 on 11/27/25.
//

import Foundation

protocol ReservationListServiceProtocol {
    func getReservationList(
        origin: String,
        destination: String,
        trainType: String?,
        seatType: String?,
        isBookAvailable: Bool?,
        cursor: String?
    ) async throws -> TrainSearchResult
}

final class ReservationListService: BaseService<ReservationListTargetType>, ReservationListServiceProtocol {

    func getReservationList(
        origin: String,
        destination: String,
        trainType: String? = nil,
        seatType: String? = nil,
        isBookAvailable: Bool? = nil,
        cursor: String? = nil
    ) async throws -> TrainSearchResult {
        let baseResponse: BaseResponseBody<TrainSearchResponseDTO> =
        try await request(
            with: .fetchReservation(
                origin: origin,
                destination: destination,
                trainType: trainType,
                seatType: seatType,
                isBookAvailable: isBookAvailable,
                cursor: "2025-12-01T14:00"
            )
        )

        guard let dto = baseResponse.data else {
            throw NetworkError.responseError
        }
        return dto.toDomain()
    }
}
