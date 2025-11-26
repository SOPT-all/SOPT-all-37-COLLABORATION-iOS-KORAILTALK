//
//  CancelReservationTargetType.swift
//  KORAILTALK-iOS
//
//  Created by sun on 11/26/25.
//

import Foundation

enum CancelReservationTargetType: TargetType {
    case cancelReservation(reservationId: Int)
    
    var baseURL: String {
        Environment.baseURL
    }
    
    var path: String {
        switch self {
        case .cancelReservation(let reservationId):
            return "/reservations/\(reservationId)"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .cancelReservation:
            return .delete
        }
    }
    
    var task: NetworkTask {
        switch self {
        case .cancelReservation:
            return .requestPlain
        }
    }
    
    var headers: HeaderField {
        .contentTypeJSON
    }
}
