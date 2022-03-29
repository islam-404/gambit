//
//  Router.swift
//  gambit
//
//  Created by islam on 12.03.2022.
//

import UIKit


protocol RouterMain {
    var navigationController: UINavigationController? { get set }
    var assemblyBuilder: AsselderBilderProtocol? { get set }
}

protocol RouterProtocol: RouterMain {
    func initialViewController()
//    func favouriteViewController()
    func showDetail(food: Food?)
}

class Router: RouterProtocol {
    var assemblyBuilder: AsselderBilderProtocol?
    var navigationController: UINavigationController?
    
    init(navigationController: UINavigationController, assemblyBuilder: AsselderBilderProtocol) {
        self.navigationController = navigationController
        self.assemblyBuilder = assemblyBuilder
    }
    
    func initialViewController() {
        if let navigationController = navigationController {
            guard let mainViewController = assemblyBuilder?.createMainScrene(router: self) else { return }
            navigationController.viewControllers = [mainViewController]
        }
    }
    
//    func favouriteViewController() {
//        if let navigationController = navigationController {
//            guard let mainViewController = assemblyBuilder?.createFavouriteScrene(router: self) else { return }
//            navigationController.viewControllers = [mainViewController]
//        }
//    }
    
    func showDetail(food: Food?) {
        if let navigationController = navigationController {
            guard let detailViewController = assemblyBuilder?.createDetailScrene(food: food, router: self ) else { return }
            navigationController.pushViewController(detailViewController, animated: true)
        }
    }
}
