//
//  BaseResponseBody.swift
//  KORAILTALK-iOS
//
//  Created by sun on 11/23/25.
//

import Foundation

struct BaseResponseBody<T: ResponseModelType>: ResponseModelType {
    let code: Int
    let message: String
    let data: T?
}
