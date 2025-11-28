//
//  TrainSchedule.swift
//  KORAILTALK-iOS
//
//  Created by 어재선 on 11/26/25.
//

import Foundation

struct TrainSchedule {
    let trainId: Int
    let type: TrainNameType
    let trailNumber: String
    let startAt: String
    let arriveAt: String
    let duration: Int
    let normalSeatStatus: SeatStatus?
    let premiumSeatStatus: SeatStatus?
    let normalSeatPrice: Int?
    let premiumSeatPrice:Int?
    var formattedDuration: String {
        let hours = duration / 60
        let minutes = duration % 60
        return String(format: "%d시간 %02d분", hours, minutes)
    }
}
