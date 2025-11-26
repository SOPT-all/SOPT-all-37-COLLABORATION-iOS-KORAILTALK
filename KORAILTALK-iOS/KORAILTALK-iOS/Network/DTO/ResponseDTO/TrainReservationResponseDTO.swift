//
//  TrainReservationResponseDTO.swift
//  KORAILTALK-iOS
//
//  Created by sun on 11/25/25.
//

import Foundation

struct TrainReservationResponseDTO: ResponseModelType {
    let trainInfo: TrainInfoDTO
    let coupons: [CouponDTO]
}

// MARK: - 하위 DTO

struct TrainInfoDTO: Decodable {
    let origin: String
    let destination: String
    let startAt: String
    let arriveAt: String
    let type: String
    let trainNumber: String
    let seatType: String
    let price: Int
    let reservationId: Int
}

struct CouponDTO: Decodable {
    let name: String
    let discountRate: Int
}

struct TrainReservation {
    let trainInfo: TrainInfo
    let coupons: [Coupon]
}

struct TrainInfo {
    let origin: String
    let destination: String
    let startAt: String
    let arriveAt: String
    let type: String
    let trainNumber: String
    let seatType: SeatType
    let price: Int
    let reservationId: Int
}

struct Coupon {
    let name: String
    let discountRate: Int
}


extension TrainReservationResponseDTO {
    func toDomain() -> TrainReservation {
        TrainReservation(
            trainInfo: trainInfo.toDomain(),
            coupons: coupons.map { $0.toDomain() }
        )
    }
}

extension TrainInfoDTO {
    func toDomain() -> TrainInfo {
        TrainInfo(
            origin: origin,
            destination: destination,
            startAt: startAt,
            arriveAt: arriveAt,
            type: type,
            trainNumber: trainNumber,
            seatType: SeatType(rawValue: seatType) ?? .normal,
            price: price,
            reservationId: reservationId
        )
    }
}

extension CouponDTO {
    func toDomain() -> Coupon {
        Coupon(
            name: name,
            discountRate: discountRate
        )
    }
}
