//
//  TravelPassViewController.swift
//  KORAILTALK-iOS
//
//  Created by 한현서 on 11/20/25.
//

import UIKit

import SnapKit
import Then

final class TravelPassViewController: UIViewController {

    // MARK: - UI

    private let dateTrainInfoView = DateTrainInfoView()
    private let routeInfoView = RouteInfoView()

    // MARK: - Service

    private let trainService: TrainReservationServiceProtocol = TrainReservationService()

    private let trainId: Int = 1
    private let seatType: SeatType = .premium
 
    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .mainWhite
        setupLayout()
        fetchTrainReservation()
    }

    // MARK: - Layout

    private func setupLayout() {
        view.addSubview(dateTrainInfoView)
        view.addSubview(routeInfoView)

        dateTrainInfoView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(40)
            $0.centerX.equalToSuperview()
        }

        routeInfoView.snp.makeConstraints {
            $0.top.equalTo(dateTrainInfoView.snp.bottom).offset(24)
            $0.centerX.equalToSuperview()
        }
    }

    // MARK: - API 연결

    private func fetchTrainReservation() {
        Task {
            do {
                let reservation = try await trainService.getTrainReservation(
                    trainId: trainId,
                    seatType: seatType
                )

                await MainActor.run {
                    self.configure(with: reservation)
                }
            } catch {
                print("❌ 열차 예약 조회 실패:", error.localizedDescription)
            }
        }
    }

    // MARK: - UI Binding

    private func configure(with reservation: TrainReservation) {
        let info = reservation.trainInfo

        let seatTypeText: String
        switch info.seatType {
        case .normal:
            seatTypeText = "일반실"
        case .premium:
            seatTypeText = "특실"
        }

        dateTrainInfoView.configure(
            dateText: "2025년 10월 31일 (금)",
            trainInfoText: "\(info.type) \(info.trainNumber) · \(seatTypeText)"
        )

        routeInfoView.configure(
            departureCity: info.origin,
            departureTime: info.startAt,
            arrivalCity: info.destination,
            arrivalTime: info.arriveAt
        )
    }
}
