//
//  ReservationDropdownView.swift
//  KORAILTALK-iOS
//
//  Created by 어재선 on 11/24/25.
//

import UIKit

import SnapKit
import Then

final class ReservationDropdownView: UIView {

    // MARK: - UI

    private let containerView = UIView()
    private let headerContainerView = UIView()
    
    private let titleLabel = UILabel()
    private let arrowImageView = UIImageView()
    private let headerStackView = UIStackView()
    
    private let headerSeparatorView = UIView()
    private let tableView = UITableView()
    
    private var tableViewHeightConstraint: Constraint?
    
    
    
    // MARK: - Properties
    
    private(set) var isExpanded: Bool = false
    private(set) var selectedIndex: Int?
    private var placeholderText: String = ""
    
    var items: [String] = [] {
        didSet { tableView.reloadData() }
    }
    
    var onSelect: ((String) -> Void)?
    
    private lazy var tapGestureRecognizer = UITapGestureRecognizer(
        target: self,
        action: #selector(didTapHeader)
    )

    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUI()
        setSytle()
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setUI()
        setSytle()
        setLayout()
    }

    // MARK: - SetUI
    
    private func setUI() {
        addSubview(containerView)
        containerView.addSubview(headerContainerView)
        headerContainerView.addSubview(headerStackView)
        containerView.addSubview(headerSeparatorView)
        containerView.addSubview(tableView)
    }
    
    // MARK: - SetStyle
    
    private func setSytle() {
        containerView.do {
                $0.backgroundColor = .mainWhite
                $0.layer.cornerRadius = 4
                $0.layer.borderWidth = 1
                $0.layer.borderColor = UIColor.gray200.cgColor
                $0.clipsToBounds = true
        }
        
        titleLabel.do {
            $0.font = .body1_r_16
            $0.textColor = .gray500
        }
        
        arrowImageView.do {
            $0.image = UIImage.filldown
            $0.tintColor = .gray500
            $0.contentMode = .scaleAspectFit
        }
        
        headerSeparatorView.do {
            $0.backgroundColor = .gray100
        }
        
        
        tableView.do {
            $0.isScrollEnabled = false
            $0.separatorStyle = .singleLine
            $0.rowHeight = 40
            $0.isHidden = true
            $0.dataSource = self
            $0.delegate = self
            $0.register(ReservationDropdownCell.self, forCellReuseIdentifier: ReservationDropdownCell.reuseIdentifier)
            $0.layoutMargins = .zero
            $0.cellLayoutMarginsFollowReadableWidth = false
            $0.separatorInset = UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 8)
            $0.separatorColor = .gray100
        }
        
        headerStackView.do {
            $0.addArrangedSubviews(titleLabel, arrowImageView)
            $0.axis = .horizontal
            $0.alignment = .center
            $0.spacing = 4
            $0.isUserInteractionEnabled = true
            $0.addGestureRecognizer(tapGestureRecognizer)
        }
    }
    
    // MARK: - SetLayout
    
    private func setLayout() {
        
        containerView.snp.makeConstraints {
            $0.leading.top.trailing.equalToSuperview()
        }
        
        headerStackView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(12)
            $0.centerY.equalToSuperview()
        }
        
        headerSeparatorView.snp.makeConstraints {
            $0.top.equalTo(headerContainerView.snp.bottom)
            $0.leading.trailing.equalToSuperview().inset(8)
            $0.height.equalTo(1)
        }
        
        headerContainerView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.height.equalTo(40)
        }
        
        tableView.snp.makeConstraints {
            $0.top.equalTo(headerSeparatorView.snp.bottom)
            $0.leading.trailing.equalToSuperview()
            tableViewHeightConstraint = $0.height.equalTo(0).constraint
            $0.bottom.equalToSuperview()
        }
    }

    // MARK: - Public
    
    func configure(placeholder: String, items: [String]) {
        placeholderText = placeholder
        self.items = items
        selectedIndex = nil
        titleLabel.text = placeholderText
        titleLabel.textColor = .gray500
    }
    
    func setExpanded(_ expanded: Bool) {
        isExpanded = expanded
        arrowImageView.setRotation(expanded: expanded)
        updateTableVisibility(animated: true)
    }

    // MARK: - Private
    
    @objc
    private func didTapHeader() {
        isExpanded.toggle()
        setExpanded(isExpanded)
        selectedIndex = nil
        tableView.reloadData()
    }
    
    private func updateTableVisibility(animated: Bool) {
        let height = isExpanded ? CGFloat(items.count) * tableView.rowHeight : 0
        
        tableView.isHidden = !isExpanded
        tableViewHeightConstraint?.update(offset: height)
        
        if animated {
            UIView.animate(withDuration: 0.25) {
                self.layoutIfNeeded()
            }
        } else {
            self.layoutIfNeeded()
            
        }
    }
}

// MARK: - UITableViewDataSource

extension ReservationDropdownView: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {
        items.count
    }
    
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: ReservationDropdownCell.reuseIdentifier,
            for: indexPath
        ) as? ReservationDropdownCell else {
            return UITableViewCell()
        }
        
        let isSelected = (indexPath.row == selectedIndex)
        
        cell.configure(text: items[indexPath.row], isSelected: isSelected)
        return cell
    }
}

// MARK: - UITableViewDelegate

extension ReservationDropdownView: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView,
                   didSelectRowAt indexPath: IndexPath) {
        selectedIndex = indexPath.row
        tableView.reloadData()
        
        let value = items[indexPath.row]
        onSelect?(value)
    }
}


