//
//  CancelReservationService.swift
//  KORAILTALK-iOS
//
//  Created by sun on 11/26/25.
//

import Foundation

protocol CancelReservationServiceProtocol {
    func cancelReservation(reservationId: Int) async throws
}

final class CancelReservationService: BaseService<CancelReservationTargetType>, CancelReservationServiceProtocol {

    func cancelReservation(reservationId: Int) async throws {
        let _: BaseResponseBody<CancelReservationResponseDTO> =
            try await request(with: .cancelReservation(reservationId: reservationId))
    }
}
