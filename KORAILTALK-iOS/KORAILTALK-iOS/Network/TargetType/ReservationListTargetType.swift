//
//  ReservationListTargetType.swift
//  KORAILTALK-iOS
//
//  Created by 어재선 on 11/27/25.
//

import Foundation

enum ReservationListTargetType: TargetType {
    case fetchReservation(
        origin: String,
        destination: String,
        trainType: String?,
        seatType: String?,
        isBookAvailable: Bool?,
        cursor: String? 
    )
    
    var baseURL: String {
        return Environment.baseURL
    }
    
    var path: String {
        switch self {
        case let .fetchReservation(origin, destination, trainType, seatType, isBookAvailable, cursor):
            var path = "/api/v1/trains?origin=\(origin)&destination=\(destination)"
            
            if let trainType {
                path += "&trainType=\(trainType)"
            }
            if let seatType {
                path += "&seatType=\(seatType)"
            }
            if let isBookAvailable {
                path += "&isBookAvailable=\(isBookAvailable)"
            }
            if let cursor {
                path += "&cursor=\(cursor)"
            }
            
            return path
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .fetchReservation:
            return .get
        }
    }
    
    var task: NetworkTask {
        switch self {
        case .fetchReservation:
            return .requestPlain
        }
    }
    
    var headers: HeaderField {
        switch self {
        case .fetchReservation:
            return .contentTypeJSON
        }
    }
}
