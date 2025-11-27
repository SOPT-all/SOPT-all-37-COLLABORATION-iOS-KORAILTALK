//
//  CheckoutDropdownBottomSheetViewController.swift
//  KORAILTALK-iOS
//
//  Created by sun on 11/27/25.
//

import UIKit

import SnapKit
import Then

final class CheckoutDropdownBottomSheetViewController: BaseViewController {
    
    // MARK: - UI
    
    private let dimmedView = UIView().then {
        $0.backgroundColor = UIColor.black.withAlphaComponent(0.4)
        $0.alpha = 0
    }
    
    private let containerView = UIView().then {
        $0.backgroundColor = .mainWhite
        $0.layer.cornerRadius = 16
        $0.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        $0.clipsToBounds = true
    }
    
    private let grabberView = UIView().then {
        $0.backgroundColor = UIColor.gray300
        $0.layer.cornerRadius = 2
        $0.clipsToBounds = true
    }
    
    private let contentView = UIView()
    private let dropdownView = CheckoutDropdownView()
    
    
    // MARK: - Properties
    
    private let placeholder: String
    private let items: [String]
    
    var onSelect: ((String) -> Void)?
    
    private var containerBottomConstraint: Constraint?
    private var didExpandOnce = false
    
    
    // MARK: - Init
    
    init(placeholder: String, items: [String]) {
        self.placeholder = placeholder
        self.items = items
        super.init(nibName: nil, bundle: nil)
        
        modalPresentationStyle = .overFullScreen
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupDropdown()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        if !didExpandOnce {
            didExpandOnce = true
            dropdownView.setExpanded(true)
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        presentSheetAnimated()
    }
    
    
    // MARK: - Setup
    
    private func setupUI() {
        view.backgroundColor = .clear
        
        view.addSubview(dimmedView)
        dimmedView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        view.addSubview(containerView)
        containerView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
            containerBottomConstraint = $0.bottom
                .equalTo(view.snp.bottom)
                .offset(300)
                .constraint
            $0.top.greaterThanOrEqualTo(view.safeAreaLayoutGuide.snp.top).offset(40)
        }
        
        containerView.addSubview(grabberView)
        grabberView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(8)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(48)
            $0.height.equalTo(4)
        }
        
        containerView.addSubview(contentView)
        contentView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(grabberView.snp.bottom).offset(20)
            $0.width.equalTo(343)
            $0.height.greaterThanOrEqualTo(164)
            $0.bottom.equalToSuperview().inset(24)
        }
        
        contentView.addSubview(dropdownView)
        dropdownView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(didTapDimmed))
        dimmedView.addGestureRecognizer(tap)
    }
    
    private func setupDropdown() {
        dropdownView.configure(placeholder: placeholder, items: items)
        
        dropdownView.onSelect = { [weak self] value in
            self?.dismissSheetAnimated {
                self?.onSelect?(value)
            }
        }
    }
    
    
    // MARK: - Animations
    
    private func presentSheetAnimated() {
        containerBottomConstraint?.update(offset: 0)
        
        UIView.animate(withDuration: 0.25,
                       delay: 0,
                       options: [.curveEaseOut],
                       animations: {
            self.view.layoutIfNeeded()
            self.dimmedView.alpha = 1
        })
    }
    
    private func dismissSheetAnimated(completion: (() -> Void)? = nil) {
        containerBottomConstraint?.update(offset: 300)
        
        UIView.animate(withDuration: 0.25,
                       delay: 0,
                       options: [.curveEaseIn],
                       animations: {
            self.view.layoutIfNeeded()
            self.dimmedView.alpha = 0
        }, completion: { _ in
            self.dismiss(animated: false, completion: completion)
        })
    }
    
    
    // MARK: - Actions
    
    @objc
    private func didTapDimmed() {
        dismissSheetAnimated()
    }
}
