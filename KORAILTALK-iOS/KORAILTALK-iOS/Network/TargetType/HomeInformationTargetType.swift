//
//  HomeInformationTargetType.swift
//  KORAILTALK-iOS
//
//  Created by 한현서 on 11/27/25.
//

import Foundation

enum HomeInformationTargetType: TargetType {
    case getHomeInformation
    
    var baseURL: String {
        return Environment.baseURL
    }
    
    var path: String {
        switch self {
        case .getHomeInformation:
            return "/api/v1/trains/home"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .getHomeInformation:
            return .get
        }
    }
    
    var task: NetworkTask {
        switch self {
        case .getHomeInformation:
            return .requestPlain
        }
    }
    
    var headers: HeaderField {
        switch self {
        case .getHomeInformation:
            return .contentTypeJSON
        }
    }
}
