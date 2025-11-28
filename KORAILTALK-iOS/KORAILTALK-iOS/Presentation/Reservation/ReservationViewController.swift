//
//  ReservationViewController.swift
//  KORAILTALK-iOS
//
//  Created by 어재선 on 11/26/25.
//

import UIKit

import SnapKit
import Then

final class ReservationViewController: BaseViewController, ReservationInfoViewDeletegate {

    
    
    //MARK: - UI
    
    private let navBar = NavigationBar(style: .trainLookup)
    private let navBarBackgroundView = UIView()
    private let reservationInfoView = ReservationInfoView()
    private let tagStackView = UIStackView()
    private let tagScrollView = UIScrollView()
    
    private let seatDropdown = ReservationDropdownView()
    private let serviceDropdown = ReservationDropdownView()
    private let dropdownStackView = UIStackView()
    private let resultLabel = UILabel()
    
    private let reservationListView = ReservationListView()
    private let emptyLabel = UILabel()
    
    private var dimmedView: UIView?
    private var reservationModalView: ReservationModal?
    
    private enum SeatFilter: String {
        case all
        case normal
        case premium
    }
    
    private var selectedTag: TrainTagType = .all
    private var allSchedules: [TrainSchedule] = []
    private var seatFilter: SeatFilter = .all {
        didSet {
            getResrvationOptinList()
        }
    }
    private let reservationService: ReservationListService = ReservationListService()
    
    
    private var origin: String = "서울"
    private var destination: String = "부산"
    
    //MARK: - SetView
    
    override func setView() {
        getReservationListAll()
        createButtons()
        setUI()
        setStyle()
        setLayout()
        reservationInfoView.configure(origin: origin, destination: destination)
        updateTagSelection()
        applyFilter()
    }
    
    //MARK: - SetUI
    
    private func setUI() {
        view.backgroundColor = .gray100
        view.addSubviews(
            navBarBackgroundView,
            navBar,
            reservationListView,
            reservationInfoView,
            tagScrollView,
            dropdownStackView,
            resultLabel,
            emptyLabel
        )
        tagScrollView.addSubview(tagStackView)
    }
    
    //MARK: - SetStyle
    
    private func setStyle() {
        navBarBackgroundView.backgroundColor = .primary700
        reservationInfoView.backgroundColor = .mainWhite
        reservationInfoView.delegate = self
        
        tagStackView.do {
            $0.axis = .horizontal
            $0.spacing = 8
            $0.distribution = .fillProportionally
            $0.alignment = .center
        }
        
        tagScrollView.do {
            $0.showsHorizontalScrollIndicator = false
            $0.backgroundColor = .mainWhite
        }
        
        seatDropdown.configure(placeholder: "전체", items: ["일반실", "특실"])
        serviceDropdown.configure(placeholder: "직통", items: ["환승"])
        
        dropdownStackView.do {
            $0.addArrangedSubviews(seatDropdown, serviceDropdown)
            $0.axis = .horizontal
            $0.spacing = 8
        }
        
        resultLabel.do {
            $0.font = .cap1_m_12
            $0.textColor = .mainBlack
            $0.textAlignment = .center
        }
        
        emptyLabel.do {
            $0.textAlignment = .center
            $0.textColor = .gray500
            $0.font = .body1_r_16
            
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.lineHeightMultiple = 1.09
            
            let attrText = NSMutableAttributedString(
                string: "예약 가능한 기차가 없어요...",
                attributes: [
                    .kern: -0.24,
                    .paragraphStyle: paragraphStyle
                ]
            )
            $0.attributedText = attrText
            $0.isHidden = true
        }
    }
    
    //MARK: - SetLayout
    
    private func setLayout() {
        navBarBackgroundView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.bottom.equalTo(navBar.snp.top)
        }
        
        navBar.snp.makeConstraints {
            $0.top.equalToSuperview().offset(50)
            $0.leading.trailing.equalToSuperview()
        }
        
        reservationInfoView.snp.makeConstraints {
            $0.top.equalTo(navBar.snp.bottom)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalTo(tagScrollView.snp.top)
        }
        
        tagScrollView.snp.makeConstraints {
            $0.top.equalTo(reservationInfoView.snp.bottom)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(52)
        }
        
        tagStackView.snp.makeConstraints {
            $0.top.bottom.equalToSuperview()
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.centerY.equalToSuperview()
        }
        
        seatDropdown.snp.makeConstraints{
            $0.width.equalTo(94)
        }
        
        dropdownStackView.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(16)
            $0.top.equalTo(tagScrollView.snp.bottom).offset(16)
            $0.trailing.lessThanOrEqualTo(resultLabel.snp.leading)
            $0.bottom.equalToSuperview()
        }
        
        resultLabel.snp.makeConstraints {
            $0.top.equalTo(seatDropdown).offset(10)
            $0.trailing.equalToSuperview().inset(16)
        }
        
        reservationListView.snp.makeConstraints {
            $0.top.equalTo(resultLabel.snp.bottom).offset(26)
            $0.leading.trailing.bottom.equalToSuperview()
        }
        
        emptyLabel.snp.makeConstraints {
            $0.centerX.equalTo(reservationListView)
            $0.centerY.equalTo(reservationListView)
        }
    }
    
    //MARK: - SetDelegate
    
    override func setDelegate() {
        reservationListView.onSelectSchedule = { [weak self] schedule in
            self?.showReservationModal(with: schedule)
        }
    }
    
    //MARK: - SetAddTarget
    
    override func setAddTarget() {
        navBar.onTapBack = { [weak self] in
            self?.navigationController?.popViewController(animated: true)
        }
        
        navBar.onTapReload = { [weak self] in
            self?.reloadTrainList()
        }
        
        seatDropdown.onSelect = { [weak self] value in
            guard let self = self else { return }
            switch value {
            case "일반실":
                self.seatFilter = .normal
            case "특실":
                self.seatFilter = .premium
            default:
                self.seatFilter = .all
            }
            self.applyFilter()
        }
        
        serviceDropdown.onSelect = { [weak self] _ in
            self?.applyFilter()
        }
    }
    
    //MARK: - Public
    func didTabCheckBox() {
        getResrvationOptinList()
    }
    
    func configure(origin: String, destination: String) {
        self.origin = origin
        self.destination = destination
        reservationInfoView.configure(origin: origin, destination: destination)
    }
    
    //MARK: - Private
    
    private func createButtons() {
        TrainTagType.allCases.forEach { type in
            let button = TrainTagButton(type: type)
            button.addTarget(self, action: #selector(didTapTag(_:)), for: .touchUpInside)
            tagStackView.addArrangedSubview(button)
        }
    }
    
    @objc private func didTapTag(_ sender: TrainTagButton) {
        selectedTag = sender.type
        getResrvationOptinList()
        updateTagSelection()
        applyFilter()
    }
    
    private func updateTagSelection() {
        for case let button as TrainTagButton in tagStackView.arrangedSubviews {
            button.isSelected = (button.type == selectedTag)
        }
    }
    
    private func applyFilter() {
        let filtered = allSchedules

        reservationListView.setTrainSchedule(filtered)
        resultLabel.text = "결과(\(filtered.count))"
        
        reservationListView.isHidden = filtered.isEmpty
        emptyLabel.isHidden = !filtered.isEmpty
    }
    
    private func resetFiltersAndList() {
        tagStackView.arrangedSubviews.forEach {
            tagStackView.removeArrangedSubview($0)
            $0.removeFromSuperview()
        }
        selectedTag = .all
        seatFilter = .all
        createButtons()
        updateTagSelection()
        
        seatDropdown.configure(placeholder: "전체", items: ["일반실", "특실"])
        serviceDropdown.configure(placeholder: "직통", items: ["환승"])
        
        tagScrollView.setContentOffset(.zero, animated: false)
        
        getReservationListAll()
    }
    
    private func reloadTrainList() {
        UIView.animate(withDuration: 0.15, animations: {
            self.reservationListView.alpha = 0.0
        }, completion: { _ in
            self.resetFiltersAndList()
            
            UIView.animate(withDuration: 0.2) {
                self.reservationListView.alpha = 1.0
            }
        })
    }
    
    private func showReservationModal(with schedule: TrainSchedule) {
        dismissReservationModal()
        
        let dimmedView = UIView()
        dimmedView.backgroundColor = UIColor.black.withAlphaComponent(0.4)
        view.addSubview(dimmedView)
        dimmedView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        let timeText = "\(schedule.startAt) - \(schedule.arriveAt)"
        var normalPrice = ""
        var premiumPrice = ""
        if let normalSeatPrice = schedule.normalSeatPrice {
            normalPrice = String(describing: normalSeatPrice)
        }
        
        if let premiumSeatPrice = schedule.premiumSeatPrice {
            premiumPrice = String(describing:premiumSeatPrice)
        }
        let modal = ReservationModal(
            time: timeText,
            trainNameType: schedule.type,
            trainNumber: schedule.trailNumber,
            generalPrice: normalPrice,
            specialPrice: premiumPrice
        )
        
        modal.onTapReserve = { [weak self] in
            guard let self = self else { return }
            let checkoutVC = CheckoutViewController(
                trainId: 1,
                seatType: .normal
            )
            self.navigationController?.pushViewController(checkoutVC, animated: true)
        }
        
        dimmedView.addSubview(modal)
        modal.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(didTapDimmedView))
        dimmedView.addGestureRecognizer(tap)
        
        modal.layoutIfNeeded()
        modal.transform = CGAffineTransform(translationX: 0, y: 300)
        dimmedView.alpha = 0
        
        UIView.animate(withDuration: 0.25,
                       delay: 0,
                       usingSpringWithDamping: 0.9,
                       initialSpringVelocity: 0.8,
                       options: [.curveEaseOut],
                       animations: {
            dimmedView.alpha = 1
            modal.transform = .identity
        }, completion: nil)
        
        self.dimmedView = dimmedView
        self.reservationModalView = modal
    }
    
    @objc private func didTapDimmedView() {
        dismissReservationModal()
    }
    
    private func dismissReservationModal() {
        guard let dimmedView = dimmedView,
              let modal = reservationModalView else { return }
        
        UIView.animate(withDuration: 0.2,
                       animations: {
            dimmedView.alpha = 0
            modal.transform = CGAffineTransform(translationX: 0, y: 300)
        }, completion: { _ in
            dimmedView.removeFromSuperview()
        })
        
        self.dimmedView = nil
        self.reservationModalView = nil
    }
    
    private func seatText(from status: SeatStatus?) -> String {
        guard let status = status else {
            return "매진"
        }
        return status.title
    }
    
    // MARK: - Network
    
    private func getReservationListAll() {
        Task {
            do {
                let schedules = try await reservationService.getReservationList(origin: origin, destination: destination)
                await MainActor.run {
                    allSchedules = schedules.trainList
                    applyFilter()
                }
            } catch {
                print("RservationViewContrller - all 불러오기 실패")
            }
        }
    }
    
    private func getResrvationOptinList() {
        Task {
            do {
                
                if selectedTag == .ktx {
                    let ktxSchedules = try await reservationService.getReservationList(
                        origin: origin,
                        destination: destination,
                        trainType: "KTX",
                        seatType: seatFilter == .all ? nil : seatFilter.rawValue,
                        isBookAvailable: reservationInfoView.getCheckBoxState(),
                        cursor: nil
                    )
                    
                    let ktxSancheonSchedules = try await reservationService.getReservationList(
                        origin: origin,
                        destination: destination,
                        trainType: "KTX-S",
                        seatType: seatFilter == .all ? nil : seatFilter.rawValue,
                        isBookAvailable: reservationInfoView.getCheckBoxState(),
                        cursor: nil
                    )
                    
                    let ktxCheongryongSchedules = try await reservationService.getReservationList(
                        origin: origin,
                        destination: destination,
                        trainType: "KTX-C",
                        seatType: seatFilter == .all ? nil : seatFilter.rawValue,
                        isBookAvailable: reservationInfoView.getCheckBoxState(),
                        cursor: nil
                    )
                    await MainActor.run {
                        allSchedules = ktxSchedules.trainList + ktxSancheonSchedules.trainList + ktxCheongryongSchedules.trainList
                        allSchedules = allSchedules.sorted {
                            $0.startAt < $1.startAt
                        }
                        applyFilter()
                    }
                } else if selectedTag == .itxMaeumSeamaeul {
                    let itxMeaumSchedules = try await reservationService.getReservationList(
                        origin: origin,
                        destination: destination,
                        trainType: "ITX-M",
                        seatType: seatFilter == .all ? nil : seatFilter.rawValue,
                        isBookAvailable: reservationInfoView.getCheckBoxState(),
                        cursor: nil
                    )
                    
                    let itxSeamaeulSchedules = try await reservationService.getReservationList(
                        origin: origin,
                        destination: destination,
                        trainType: "ITX-N",
                        seatType: seatFilter == .all ? nil : seatFilter.rawValue,
                        isBookAvailable: reservationInfoView.getCheckBoxState(),
                        cursor: nil
                    )
                    await MainActor.run {
                        allSchedules = itxMeaumSchedules.trainList + itxSeamaeulSchedules.trainList
                        allSchedules = allSchedules.sorted {
                            $0.startAt < $1.startAt
                        }
                        applyFilter()
                    }
                } else {
                    let schedules = try await reservationService.getReservationList(
                        origin: origin,
                        destination: destination,
                        trainType: selectedTag == .all ? nil :  selectedTag.rawValue,
                        seatType: seatFilter == .all ? nil : seatFilter.rawValue,
                        isBookAvailable: reservationInfoView.getCheckBoxState(),
                        cursor: nil
                    )
                    await MainActor.run {
                        allSchedules = schedules.trainList
                        applyFilter()
                    }
                }
            } catch {
                allSchedules = []
                applyFilter()
                print("RservationViewContrller - option  불러오기 실패")
            }
            
        }
        
    }
}

