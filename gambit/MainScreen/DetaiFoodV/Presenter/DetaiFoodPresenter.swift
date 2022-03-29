////
////  DetaiFoodPresenter.swift
////  gambit
////
////  Created by islam on 22.03.2022.
////
//
//import Foundation
//protocol DetailFoodViewProtocol: AnyObject {
//    func setFood(food: Food?)
//}
//
//protocol DetailFoodViewPresenterProtocol: AnyObject {
//    init(view: DetailFoodViewProtocol, router: RouterProtocol, food: Food?)
//    func setFood()
//}
//
//class DetailFoodPresenter: DetailFoodViewPresenterProtocol {
//    
//    weak var view: DetailFoodViewProtocol?
//    var router: RouterProtocol?
//    var food: Food?
//    
//    required init(view: DetailFoodViewProtocol, router: RouterProtocol, food: Food?) {
//        self.view = view
//        self.router = router
//        self.food = food
//    }
//    
//    func setFood() {
//        self.view?.setFood(food: food)
//    }
//    
//}
