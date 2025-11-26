//
//  TrainReservationTargetType.swift
//  KORAILTALK-iOS
//
//  Created by sun on 11/25/25.
//

import Foundation

enum TrainReservationTargetType: TargetType {
    case fetchTrainReservation(trainId: Int, seatType: SeatType)
    
    var baseURL: String {
        Environment.baseURL
    }
    
    var path: String {
        switch self {
        case .fetchTrainReservation(let trainId, _):
            return "/trains/\(trainId)/reservation"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .fetchTrainReservation:
            return .post
        }
    }
    
    var task: NetworkTask {
        switch self {
        case .fetchTrainReservation(_, let seatType):
            let body = TrainReservationRequestDTO(seatType: seatType.rawValue)
            return .requestJSONEncodable(encodable: body)
        }
    }
    
    var headers: HeaderField {
        .contentTypeJSON
    }
}
