//
//  Router.swift
//  gambit
//
//  Created by islam on 12.03.2022.
//

import UIKit


protocol RouterMain {
    var navigationController: [UINavigationController]! { get set }
    var assemblyBuilder: AsselderBilderProtocol! { get set }
}

protocol RouterProtocol: RouterMain {
    func initialViewController() -> UIViewController
    func favouriteViewController() -> UIViewController
    func showDetail(food: Food?, indexVC: Int)
}

class Router: RouterProtocol {
    var assemblyBuilder: AsselderBilderProtocol!
    var navigationController: [UINavigationController]!
    
    init(navigationController: [UINavigationController], assemblyBuilder: AsselderBilderProtocol) {
        self.navigationController = navigationController
        self.assemblyBuilder = assemblyBuilder
    }
    
    func initialViewController() -> UIViewController {
        let mainViewController = assemblyBuilder.createMainScrene(router: self)
        return mainViewController
    }
    
    func favouriteViewController() -> UIViewController {
        let mainViewController = assemblyBuilder.createFavouriteScrene(router: self)
        return mainViewController
    }
    
    func showDetail(food: Food?, indexVC: Int) {
        let detailViewController = assemblyBuilder.createDetailScrene(food: food, router: self )
        navigationController[indexVC].pushViewController(detailViewController, animated: true)    }
}
