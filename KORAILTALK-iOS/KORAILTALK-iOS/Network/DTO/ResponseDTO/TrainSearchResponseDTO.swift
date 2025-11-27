//
//  TrainSearchResponseDTO.swift
//  KORAILTALK-iOS
//
//  Created by 어재선 on 11/27/25.
//

import Foundation
import UIKit

// MARK: - DTO

struct TrainSearchResponseDTO: ResponseModelType {
    let origin: String
    let destination: String
    let totalTrains: Int
    let nextCursor: String
    let trainList: [TrainDTO]
}

struct TrainDTO: Decodable {
    let type: String
    let trainNumber: String
    let startAt: String
    let arriveAt: String
    let duration: Int
    let normalSeatStatus: String
    let premiumSeatStatus: String
    
    enum CodingKeys: String, CodingKey {
        case type
        case trainNumber = "trailNumber"
        case startAt
        case arriveAt
        case duration
        case normalSeatStatus
        case premiumSeatStatus
    }
}

struct TrainSearchResult {
    let origin: String
    let destination: String
    let totalTrains: Int
    let nextCursor: String
    let trainList: [TrainSchedule]
}

extension TrainSearchResponseDTO {
    func toDomain() -> TrainSearchResult {
        TrainSearchResult(
            origin: origin,
            destination: destination,
            totalTrains: totalTrains,
            nextCursor: nextCursor,
            trainList: trainList.map { $0.toDomain() }
        )
    }
}

extension TrainDTO {
    func toDomain() -> TrainSchedule {
        TrainSchedule(
            type: TrainNameType(rawValue: type),
            trailNumber: trainNumber,
            startAt: startAt,
            arriveAt: arriveAt,
            duration: duration,
            normalSeatStatus: SeatStatus(serverValue: normalSeatStatus),
            premiumSeatStatus: SeatStatus(serverValue: premiumSeatStatus)
        )
    }
}
