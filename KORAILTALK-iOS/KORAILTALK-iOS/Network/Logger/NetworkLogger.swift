//
//  NetworkLogger.swift
//  KORAILTALK-iOS
//
//  Created by sun on 11/23/25.
//

import Foundation

enum NetworkLogger {
    
    static func logRequest(_ request: URLRequest, target: TargetType) {
        guard let url = request.url?.absoluteString else {
            print("--> 유효하지 않은 요청")
            return
        }
        
        let method = request.httpMethod ?? "메소드값이 nil입니다."
        var log = """
        ----------------------------------------------------
        1️⃣[\(method)] \(url)
        ----------------------------------------------------
        2️⃣API: \(target)
        """
        
        if let headers = request.allHTTPHeaderFields, !headers.isEmpty {
            log.append("\nheader: \(headers)")
        }
        
        if let body = request.httpBody,
           let bodyString = String(data: body, encoding: .utf8) {
            log.append("\n\(bodyString)")
        }
        
        log.append("\n------------------- END \(method) -------------------")
        print(log)
    }
    
    static func logResponse(data: Data, response: URLResponse, target: TargetType) {
        guard let httpResponse = response as? HTTPURLResponse else { return }
        let url = httpResponse.url?.absoluteString ?? "nil"
        let statusCode = httpResponse.statusCode
        
        var log = """
        ------------------- Response가 도착했습니다. -------------------
        3️⃣[\(statusCode)] \(url)
        API: \(target)
        Status Code: [\(statusCode)]
        URL: \(url)
        response:
        """
        
        if let body = String(data: data, encoding: .utf8) {
            log.append("\n4️⃣\(body)")
        }
        
        log.append("\n------------------- END HTTP -------------------")
        print(log)
    }
    
    static func logError(_ error: Error) {
        let log = """
        ❌ 네트워크 오류 발생
        <-- \(error.localizedDescription)
        <-- END HTTP
        """
        print(log)
    }
}
