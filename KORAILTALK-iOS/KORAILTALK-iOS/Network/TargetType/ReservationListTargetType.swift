//
//  ReservationListTargetType.swift
//  KORAILTALK-iOS
//
//  Created by 어재선 on 11/27/25.
//

import Foundation

enum ReservationListTargetType: TargetType {
    case fetchReservationTypeKTX
    
    var baseURL: String {
        return Environment.baseURL
    }
    
    var path: String {
        switch self {
        case .fetchReservationTypeKTX:
            return "/api/v1/trains?origin=서울&destination=부산&trainType=KTX"
        }
        
    }
    
    var method: HTTPMethod {
        switch self {
            case .fetchReservationTypeKTX:
            return .get
        }
        
    }
        
    
    var task: NetworkTask {
        switch self {
        case .fetchReservationTypeKTX:
            return .requestPlain
        }
    }
    
    
    var headers: HeaderField {
        return .contentTypeJSON
    }
    
    
}
