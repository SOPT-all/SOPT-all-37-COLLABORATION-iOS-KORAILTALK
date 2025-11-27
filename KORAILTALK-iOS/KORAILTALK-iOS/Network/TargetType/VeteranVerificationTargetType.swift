//
//  VeteranVerificationTargetType.swift
//  KORAILTALK-iOS
//
//  Created by sumin Kong on 11/26/25.
//

import Foundation

enum VeteranVerificationTargetType {
    case postVeteranVerification(nationalId: String, password: String, birthdate: String)
}
extension VeteranVerificationTargetType: TargetType {
    var baseURL: String {
        Environment.baseURL
    }

    var path: String {
        switch self {
        case .postVeteranVerification:
            return "/api/v1/national/verify"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .postVeteranVerification:
            return .post
        }
    }

    var task: NetworkTask {
        switch self {
        case let .postVeteranVerification(nationalId,password,birthdate):
            let body = VeteranVerificationRequestDTO(nationalId: nationalId, password: password, birthdate: birthdate)
            return .requestJSONEncodable(encodable: body)
        }
    }

    var headers: HeaderField {
        .contentTypeJSON
    }
}
