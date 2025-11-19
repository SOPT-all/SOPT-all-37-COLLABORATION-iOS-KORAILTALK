//
//  AppFactory.swift
//  KORAILTALK-iOS
//
//  Created by 한현서 on 11/20/25.
//

import Foundation
import UIKit

final class AppFactory: ViewControllerFactory {

    func makeHomeViewController() -> UIViewController {
        return HomeViewController()
    }

    func makeDiscountViewController() -> UIViewController {
        return DiscountViewController()
    }

    func makeTravelPassViewController() -> UIViewController {
        return TravelPassViewController()
    }

    func makeShoppingTicketViewController() -> UIViewController {
        return ShoppingTicketViewController()
    }
}
