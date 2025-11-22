//
//  ServiceMenuModel.swift
//  KORAILTALK-iOS
//
//  Created by 한현서 on 11/22/25.
//

import UIKit

struct ServiceMenuModel {
    let title: String
    let serviceImage: UIImage?
    
    static let mockData: [ServiceMenuModel] = [
        ServiceMenuModel(
            title: "길안내",
            serviceImage: UIImage(named: "location")
        ),
        ServiceMenuModel(
            title: "열차위치",
            serviceImage: UIImage(named: "navigation")
        ),
        ServiceMenuModel(
            title: "주차",
            serviceImage: UIImage(named: "parking")
        ),
        ServiceMenuModel(
            title: "공항버스",
            serviceImage: UIImage(named: "bus")
        ),
        ServiceMenuModel(
            title: "렌터카",
            serviceImage: UIImage(named: "car")
        ),
        ServiceMenuModel(
            title: "카셰어링",
            serviceImage: UIImage(named: "car-rent")
        ),
        ServiceMenuModel(
            title: "짐배송",
            serviceImage: UIImage(named: "luggage1")
        ),
        ServiceMenuModel(
            title: "카페&빵",
            serviceImage: UIImage(named: "bread")
        ),
        ServiceMenuModel(
            title: "레저이용권",
            serviceImage: UIImage(named: "ticket1")
        ),
        ServiceMenuModel(
            title: "관광택시",
            serviceImage: UIImage(named: "taxi")
        ),
    ]
}
