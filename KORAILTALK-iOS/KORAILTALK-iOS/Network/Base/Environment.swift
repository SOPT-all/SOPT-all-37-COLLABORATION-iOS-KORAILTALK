//
//  Environment.swift
//  KORAILTALK-iOS
//
//  Created by sun on 11/23/25.
//

import Foundation

enum Environment {
  static let baseURL: String = Bundle.main.infoDictionary?["BASE_URL"] as! String
}
