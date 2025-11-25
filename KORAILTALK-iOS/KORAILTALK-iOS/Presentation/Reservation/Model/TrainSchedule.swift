//
//  TrainSchedule.swift
//  KORAILTALK-iOS
//
//  Created by 어재선 on 11/26/25.
//

import Foundation

struct TrainSchedule {
    let type: TrainNameType
    let trailNumber: String
    let startAt: String
    let arriveAt: String
    let duration: Int
    let normalSeatStatus: SeatStatus?
    let premiumSeatStatus: SeatStatus?
    
    var formattedDuration: String {
        let hours = duration / 60
        let minutes = duration % 60
        return String(format: "%d시간 %02d분", hours, minutes)
    }
}

extension TrainSchedule {
    static let mockData: [TrainSchedule] = [
        TrainSchedule(
            type: .ktx,
            trailNumber: "001",
            startAt: "05:13",
            arriveAt: "07:58",
            duration: 165,
            normalSeatStatus: .available,
            premiumSeatStatus: .available
        ),
        TrainSchedule(
            type: .srt,
            trailNumber: "123",
            startAt: "06:00",
            arriveAt: "08:32",
            duration: 152,
            normalSeatStatus: .almostSoldOut,
            premiumSeatStatus: .available
        ),
        TrainSchedule(
            type: .ktx,
            trailNumber: "005",
            startAt: "07:15",
            arriveAt: "09:48",
            duration: 153,
            normalSeatStatus: .available,
            premiumSeatStatus: nil
        ),
        TrainSchedule(
            type: .itxSaemaeul,
            trailNumber: "201",
            startAt: "08:30",
            arriveAt: "12:15",
            duration: 225,
            normalSeatStatus: .almostSoldOut,
            premiumSeatStatus: nil
        ),
        TrainSchedule(
            type: .srt,
            trailNumber: "125",
            startAt: "09:00",
            arriveAt: "11:24",
            duration: 144,
            normalSeatStatus: .available,
            premiumSeatStatus: .almostSoldOut
        ),
        TrainSchedule(
            type: .itxMaeum,
            trailNumber: "301",
            startAt: "10:20",
            arriveAt: "14:35",
            duration: 255,
            normalSeatStatus: .available,
            premiumSeatStatus: nil
        ),
        TrainSchedule(
            type: .mugunghwa,
            trailNumber: "401",
            startAt: "11:45",
            arriveAt: "17:20",
            duration: 335,
            normalSeatStatus: .available,
            premiumSeatStatus: nil
        ),
        TrainSchedule(
            type: .ktx,
            trailNumber: "015",
            startAt: "13:00",
            arriveAt: "15:42",
            duration: 162,
            normalSeatStatus: .almostSoldOut,
            premiumSeatStatus: .available
        ),
        TrainSchedule(
            type: .srt,
            trailNumber: "127",
            startAt: "14:30",
            arriveAt: "16:58",
            duration: 148,
            normalSeatStatus: .available,
            premiumSeatStatus: .available
        ),
        TrainSchedule(
            type: .ktx,
            trailNumber: "021",
            startAt: "16:15",
            arriveAt: "18:50",
            duration: 155,
            normalSeatStatus: .available,
            premiumSeatStatus: .almostSoldOut
        ),
        TrainSchedule(
            type: .ktx,
            trailNumber: "021",
            startAt: "17:15",
            arriveAt: "19:50",
            duration: 155,
            normalSeatStatus: nil,
            premiumSeatStatus: nil
        )
    ]
}

// 사용 예시
let schedules = TrainSchedule.mockData
