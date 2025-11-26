//
//  ReuseIdentifiable.swift
//  KORAILTALK-iOS
//
//  Created by 어재선 on 11/26/25.
//

import Foundation

protocol ReuseIdentifiable {
    static var reuseIdentifier: String { get }
}

extension ReuseIdentifiable {
    static var reuseIdentifier: String { String(describing: Self.self) }
}

