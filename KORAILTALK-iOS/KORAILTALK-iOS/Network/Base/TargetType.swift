//
//  TargetType.swift
//  KORAILTALK-iOS
//
//  Created by sun on 11/23/25.
//

import Foundation

public protocol TargetType {
    var baseURL: String { get }
    var path: String { get }
    var method: HTTPMethod { get }
    var sampleData: Data { get }
    var task: NetworkTask { get }
    var headers: HeaderField { get }
}

public extension TargetType {
    var sampleData: Data { Data() }
}

// MARK: - HTTP Method

public enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case patch = "PATCH"
    case delete = "DELETE"
}

// MARK: - Network Task

public enum NetworkTask {
    case requestPlain
    case requestParameters(parameters: [String : Any], encoding: ParameterEncoding)
    case requestJSONEncodable(encodable: Encodable)
}

// MARK: - Parameter Encoding

public enum ParameterEncoding {
    case queryString
}

// MARK: - Header Field

public enum HeaderField {
    case contentTypeJSON
    case userId(Int)
    
    var keyValue: [String: String]? {
        switch self {
        case .contentTypeJSON:
            return ["Content-Type": "application/json"]
        case .userId(let id):
            return ["Content-Type": "application/json", "userId": String(id)]
        }
    }
}
