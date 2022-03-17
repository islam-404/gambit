//
//  ModulBilder.swift
//  gambit
//
//  Created by islam on 12.03.2022.
//

import UIKit

protocol AsselderBilderProtocol {
    func createMainScrene(router: RouterProtocol) -> UIViewController
//    func createDetailScrene(food: Food?, router: RouterProtocol) -> UIViewController
}

class AssedlerScreneBilder: AsselderBilderProtocol {
    func createMainScrene(router: RouterProtocol) -> UIViewController {
        let view = MainViewController()
        let base = Base()
        let presenter = MainPresenter(view: view, router: router, base: base)
        view.presenter = presenter
        
        return view
    }
    
//    func createDetailScrene(food: Food?, router: RouterProtocol) -> UIViewController {
//        return UIViewController()
//    }
    
    
}
