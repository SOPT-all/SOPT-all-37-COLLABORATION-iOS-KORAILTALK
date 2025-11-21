//
//  TabBarController.swift
//  KORAILTALK-iOS
//
//  Created by 한현서 on 11/19/25.
//

import UIKit
import SnapKit
import Then

public final class TabBarController: UITabBarController {
    
    // MARK: - Dependencies
    
    private let factory: ViewControllerFactory
    
    // MARK: - Init
    
    public init(factory: ViewControllerFactory) {
        self.factory = factory
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
     
    // MARK: - LifeCycle
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        delegate = self
        setupTabBarAppearance()
        setupViewControllers()
    }
    
    // MARK: - Setup
    
    private func setupViewControllers() {
        let homeVC = makeTabItem(
            viewController: factory.makeHomeViewController(),
            title: "홈",
            selectedImageName: "home",
            unselectedImageName: "home"
        )
        
        let discountVC = makeTabItem(
            viewController: factory.makeDiscountViewController(),
            title: "할인",
            selectedImageName: "sale",
            unselectedImageName: "sale"
        )
        
        let travelPassVC = makeTabItem(
            viewController: factory.makeTravelPassViewController(),
            title: "여행상품 패스",
            selectedImageName: "product",
            unselectedImageName: "product"
        )
        
        let shoppingTicketVC = makeTabItem(
            viewController: factory.makeShoppingTicketViewController(),
            title: "상품티켓",
            selectedImageName: "ticket",
            unselectedImageName: "ticket"
        )
        
        viewControllers = [homeVC, discountVC, travelPassVC, shoppingTicketVC]
    }
    
    private func setupTabBarAppearance() {
        let appearance = UITabBarAppearance()
        appearance.backgroundColor = .mainWhite
        appearance.shadowColor = .gray200
        
        let itemAppearance = UITabBarItemAppearance()
        
        itemAppearance.normal.titleTextAttributes = [
            .font: UIFont.cap2_r_12,
            .foregroundColor: UIColor.gray200
        ]
        itemAppearance.normal.iconColor = .gray200
        
        itemAppearance.selected.titleTextAttributes = [
            .font: UIFont.cap2_r_12,
            .foregroundColor: UIColor.mainBlack
        ]
        itemAppearance.selected.iconColor = .mainBlack
        
        appearance.stackedLayoutAppearance = itemAppearance
        
        tabBar.standardAppearance = appearance
        if #available(iOS 15.0, *) {
            tabBar.scrollEdgeAppearance = appearance
        }
        
        tabBar.tintColor = .mainBlack
        tabBar.unselectedItemTintColor = .gray200
    }
    
    private func makeTabItem(
        viewController: UIViewController,
        title: String,
        selectedImageName: String,
        unselectedImageName: String
    ) -> UIViewController {
        let nav = UINavigationController(rootViewController: viewController)
        
        let unselectedImage = UIImage(named: unselectedImageName)?
            .withRenderingMode(.alwaysTemplate)

        let selectedImage = UIImage(named: selectedImageName)?
            .withRenderingMode(.alwaysTemplate)

        nav.tabBarItem = UITabBarItem(
            title: title,
            image: unselectedImage,
            selectedImage: selectedImage
        )
        
        return nav
    }
}

// MARK: - UITabBarControllerDelegate

extension TabBarController: UITabBarControllerDelegate {
    
    private static var lastSelectedIndex: Int = 0
    
    public func tabBarController(
        _ tabBarController: UITabBarController,
        didSelect viewController: UIViewController
    ) {
        let isReSelected = (TabBarController.lastSelectedIndex == tabBarController.selectedIndex)
        
        if isReSelected {
            if let nav = viewController as? UINavigationController {
                nav.popToRootViewController(animated: true)
            }
        }
        
        TabBarController.lastSelectedIndex = tabBarController.selectedIndex
    }
}

// MARK: - ViewControllerFactory Protocol
public protocol ViewControllerFactory {
    func makeHomeViewController() -> UIViewController
    func makeDiscountViewController() -> UIViewController
    func makeTravelPassViewController() -> UIViewController
    func makeShoppingTicketViewController() -> UIViewController
}
