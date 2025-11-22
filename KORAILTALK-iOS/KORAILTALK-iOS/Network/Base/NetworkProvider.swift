//
//  NetworkProvider.swift
//  KORAILTALK-iOS
//
//  Created by sun on 11/23/25.
//

import Foundation

struct NetworkProvider<Target: TargetType> {
    func makeRequest(_ target: Target) throws -> URLRequest {
        
        // MARK: - URL Path
        
        let path = target.baseURL + target.path
        guard var urlComponents = URLComponents(string: path) else {
            throw NetworkError.invalidURLComponents
        }
        
        // MARK: - Task
        
        var body: Data?
        var url: URL?
        
        let task = target.task
        switch task {
        case .requestPlain:
            url = urlComponents.url
            
        case .requestParameters(let parameters, let encoding):
            switch encoding {
            case .queryString:
                let queryItemArray = parameters.map {
                    URLQueryItem(name: $0.key, value: $0.value as? String)
                }
                urlComponents.queryItems = queryItemArray
                url = urlComponents.url
            }
            
        case .requestJSONEncodable(encodable: let encodable):
            url = urlComponents.url
            do {
                let JSONEncoder = JSONEncoder()
                let requestBody = try JSONEncoder.encode(encodable)
                body = requestBody
            } catch {
                throw NetworkError.requestEncodingError
            }
        }
        
        guard let url else {
            throw NetworkError.invalidURLString
        }
        
        // MARK: - HTTP Method
        
        var request = URLRequest(url: url)
        request.httpMethod = target.method.rawValue
        request.httpBody = body
        
        // MARK: - Header
        
        if let headerField = target.headers.keyValue {
            headerField.forEach { key, value in
                request.addValue(value, forHTTPHeaderField: key)
            }
        }
        
        return request
    }
}
