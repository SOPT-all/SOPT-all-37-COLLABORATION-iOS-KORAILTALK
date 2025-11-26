//
//  TrainReservationService.swift
//  KORAILTALK-iOS
//
//  Created by sun on 11/25/25.
//

import Foundation

protocol TrainReservationServiceProtocol {
    func getTrainReservation(trainId: Int, seatType: SeatType) async throws -> TrainReservation
}

final class TrainReservationService: BaseService<TrainReservationTargetType>, TrainReservationServiceProtocol {

    func getTrainReservation(trainId: Int, seatType: SeatType) async throws -> TrainReservation {
        let baseResponse: BaseResponseBody<TrainReservationResponseDTO> =
            try await request(with: .fetchTrainReservation(trainId: trainId, seatType: seatType))

        let dto = baseResponse.data

        return dto.toDomain()
    }
}
