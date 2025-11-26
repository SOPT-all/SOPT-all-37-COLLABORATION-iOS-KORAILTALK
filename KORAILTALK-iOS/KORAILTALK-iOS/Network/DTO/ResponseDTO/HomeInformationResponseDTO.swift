//
//  HomeInformationResponseDTO.swift
//  KORAILTALK-iOS
//
//  Created by 한현서 on 11/27/25.
//

import Foundation

struct HomeInformation {
    let origin: String
    let destination: String
}

struct HomeInformationResponseDTO : ResponseModelType{
    let origin: String
    let destination: String
}

extension HomeInformationResponseDTO {
    func toDomain() -> HomeInformation {
        return HomeInformation(
            origin: origin,
            destination: destination
        )
    }
}
