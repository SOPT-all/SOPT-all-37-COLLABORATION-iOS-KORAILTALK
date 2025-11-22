//
//  NetworkError.swift
//  KORAILTALK-iOS
//
//  Created by sun on 11/23/25.
//

import Foundation

enum NetworkError: Error, CustomStringConvertible {
    case invalidURLComponents
    case invalidURLString
    case requestEncodingError
    case responseDecodingError
    case responseError
    case notFoundError
    case internalServerError

    var description: String {
        switch self {
        case .invalidURLComponents:
            return "URL 구성을 만들 수 없습니다."
        case .invalidURLString:
            return "잘못된 URL입니다."
        case .requestEncodingError:
            return "요청 인코딩에 실패했습니다."
        case .responseDecodingError:
            return "응답 디코딩에 실패했습니다."
        case .responseError:
            return "서버로부터 에러 응답을 받았습니다."
        case .notFoundError:
            return "요청한 리소스를 찾을 수 없습니다. (404)"
        case .internalServerError:
            return "서버 내부 오류입니다. (500)"
        }
    }
}
