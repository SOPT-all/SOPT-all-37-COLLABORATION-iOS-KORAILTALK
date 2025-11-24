//
//  BaseService.swift
//  KORAILTALK-iOS
//
//  Created by sun on 11/23/25.
//

import Foundation

class BaseService<Target: TargetType> {
    private let provider: NetworkProvider<Target>
    private let urlSession: URLSession
    private let decoder: JSONDecoder

    init(
        provider: NetworkProvider<Target> = NetworkProvider<Target>(),
        urlSession: URLSession = .shared,
        decoder: JSONDecoder = JSONDecoder()
    ) {
        self.provider = provider
        self.urlSession = urlSession
        self.decoder = decoder
    }

    func request<T: ResponseModelType>(with target: Target) async throws -> BaseResponseBody<T> {
        // 1. URLRequest 생성
        let urlRequest = try provider.makeRequest(target)
        
        // 2. 요청 로그 출력
        NetworkLogger.logRequest(urlRequest, target: target)
        
        do {
            // 3. 실제 네트워크 요청 수행
            let (data, response) = try await urlSession.data(for: urlRequest)
            
            // 4. 응답 로그 출력
            NetworkLogger.logResponse(data: data, response: response, target: target)
            
            // 5. HTTP 응답 형식 확인
            guard let httpResponse = response as? HTTPURLResponse else {
                throw NetworkError.responseError
            }
            
            // 6. 상태 코드에 따른 예외 처리
            let statusCode = httpResponse.statusCode
            
            guard 200..<300 ~= statusCode else {
                switch statusCode {
                case 404:
                    throw NetworkError.notFoundError
                case 500:
                    throw NetworkError.internalServerError
                default:
                    throw NetworkError.responseError
                }
            }
            
            // 7. JSON 디코딩
            do {
                return try decoder.decode(BaseResponseBody<T>.self, from: data)
            } catch {
                // 디코딩 에러 로그 남기기 (어디서 깨졌는지 확인용)
                NetworkLogger.logError(error)
                throw NetworkError.responseDecodingError
            }
            
        } catch {
            // 8. 네트워크/기타 에러 로깅 후 전파
            NetworkLogger.logError(error)
            throw error
        }
    }
}
