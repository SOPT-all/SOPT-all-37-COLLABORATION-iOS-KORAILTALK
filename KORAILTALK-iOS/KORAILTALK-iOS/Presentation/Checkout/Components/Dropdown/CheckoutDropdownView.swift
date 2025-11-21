//
//  CheckoutDropdownView.swift
//  KORAILTALK-iOS
//
//  Created by sun on 11/19/25.
//

import UIKit

import SnapKit
import Then

final class CheckoutDropdownView: UIView {

    // MARK: - UI

    private let containerView = UIView().then {
        $0.backgroundColor = .mainWhite
        $0.layer.cornerRadius = 8
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor.gray200.cgColor
        $0.clipsToBounds = true
    }
    
    private let headerContainerView = UIView()
    
    private let titleLabel = UILabel().then {
        $0.font = .body1_r_16
        $0.textColor = .gray400
    }
    
    private let arrowImageView = UIImageView().then {
        $0.image = UIImage.up
        $0.tintColor = .gray400
        $0.contentMode = .scaleAspectFit
    }
    
    private let headerSeparatorView = UIView().then {
        $0.backgroundColor = .gray200
    }
    
    private let tableView = UITableView().then {
        $0.isScrollEnabled = false
        $0.separatorStyle = .singleLine
        $0.rowHeight = 40
        $0.isHidden = true
    }
    
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
        setupUI()
        setupTableView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
        setupTableView()
    }

    // MARK: - UI Setup
    
    private func setupUI() {
        addSubview(containerView)
        containerView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        containerView.addSubview(headerContainerView)
        headerContainerView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.height.equalTo(40)
        }
        
        let headerStackView = UIStackView(arrangedSubviews: [titleLabel, arrowImageView]).then {
            $0.axis = .horizontal
            $0.alignment = .center
            $0.spacing = 4
            $0.isUserInteractionEnabled = true
            $0.addGestureRecognizer(tapGestureRecognizer)
        }
        
        headerContainerView.addSubview(headerStackView)
        headerStackView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(12)
            $0.centerY.equalToSuperview()
        }
        
        containerView.addSubview(headerSeparatorView)
        headerSeparatorView.snp.makeConstraints {
            $0.top.equalTo(headerContainerView.snp.bottom)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(1)
        }
        
        containerView.addSubview(tableView)
        tableView.snp.makeConstraints {
            $0.top.equalTo(headerSeparatorView.snp.bottom)
            $0.leading.trailing.equalToSuperview()
            tableViewHeightConstraint = $0.height.equalTo(0).constraint
            $0.bottom.equalToSuperview()
        }
    }

    // MARK: - Table Setup
    
    private func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(
            CheckoutDropdownOptionCell.self,
            forCellReuseIdentifier: CheckoutDropdownOptionCell.reuseIdentifier
        )
        
        tableView.separatorInset = .zero
        tableView.layoutMargins = .zero
        tableView.cellLayoutMarginsFollowReadableWidth = false
    }

    // MARK: - Public
    
    func configure(placeholder: String, items: [String]) {
        placeholderText = placeholder
        self.items = items
        selectedIndex = nil
        titleLabel.text = placeholderText
        titleLabel.textColor = .gray400
    }
    
    func setExpanded(_ expanded: Bool) {
        isExpanded = expanded
        arrowImageView.setRotation(expanded: expanded)
        updateTableVisibility(animated: true)
    }

    // MARK: - Private
    
    @objc
    private func didTapHeader() {
        setExpanded(true)
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
            layoutIfNeeded()
        }
    }
}

// MARK: - UITableViewDataSource

extension CheckoutDropdownView: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {
        items.count
    }
    
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: CheckoutDropdownOptionCell.reuseIdentifier,
            for: indexPath
        ) as? CheckoutDropdownOptionCell else {
            return UITableViewCell()
        }
        
        let isSelected = (indexPath.row == selectedIndex)
        
        cell.configure(text: items[indexPath.row], isSelected: isSelected)
        return cell
    }
}

// MARK: - UITableViewDelegate

extension CheckoutDropdownView: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView,
                   didSelectRowAt indexPath: IndexPath) {
        selectedIndex = indexPath.row
        tableView.reloadData()
        
        let value = items[indexPath.row]
        onSelect?(value)
    }
}
