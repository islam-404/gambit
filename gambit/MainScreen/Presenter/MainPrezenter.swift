//
//  MainPrezenter.swift
//  gambit
//
//  Created by islam on 12.03.2022.
//

import Foundation
//MARK: - Протоколы которые срабатывают в случае успеха или неудачи
protocol MainProtocol: AnyObject {
    func succes()
    func failure()
}

//MARK: - Протоколы для MainViewController
protocol MainViewPresenterProtocol: AnyObject {
    init(view: MainProtocol, router: RouterProtocol, base: SaveCardProtocol)
    func getFoods()
    func plusMinus(plusMinus: Bool, count: Int, id: String) -> Int
    func receiveData(id: String)  -> Dictionary<String, Int>
    func setFavouriteHidden(idFood: Int)
    func getFavouriteHidden(idFood: Int) -> Bool
    var foods: [Food]? { get set }
}

//MARK: - Протоколы для сохранения и получения из юзерДефаулт в презентере
protocol SaveCardProtocol: AnyObject {
    func saveCount(id: String, countDish: Int)
    func saveFavourite(id: Int, favouriteCondition: Int)
    func requestData(id: String) -> Dictionary<String, Int>
}


class MainPresenter: MainViewPresenterProtocol {
    
    var base: SaveCardProtocol?
    weak var view: MainProtocol?
    var foods: [Food]?
    var router: RouterProtocol?
    
    required init(view: MainProtocol, router: RouterProtocol, base: SaveCardProtocol) {
        self.view = view
        self.router = router
        self.base = base

        router.navigationController?.navigationBar.prefersLargeTitles = true
        router.navigationController?.navigationItem.largeTitleDisplayMode = .always
        getFoods()
    }
    
    //MARK: - Получение из ссылки списка блюд
    func getFoods() {
        NetworkService.shared.getTheFood { [weak self] foods in
            guard let self = self else { return }
            if !(foods?.isEmpty ?? false) {
                self.foods = foods
                self.view?.succes()
            } else {
                self.view?.failure()
                print("пусто")
            }
            
        }
    }
    
    
    //MARK: - Увеличение и уменьшение количества блюда
    func plusMinus(plusMinus: Bool, count: Int, id: String) -> Int {
        var count = count
        if (plusMinus) {
            count = count + 1
        } else {
            count = count - 1
        }
        
        //MARK: Сохнанение количества в юзерДефаулт в презентере
        base?.saveCount(id: id, countDish: count)
        return count
    }
    
    
    //MARK: - Получение количества из юзерДефаулт в презентере
    func receiveData(id: String) -> Dictionary<String, Int> {
        return base?.requestData(id: id) ?? ["notData": 404] // вроде никогда так не подставится ["hegfgd": 999]
    }
    
    
    //MARK: - Запись состояния кнопки "избранное"
    func setFavouriteHidden(idFood: Int) {
        let foodFavouriteCondition = getFavouriteHidden(idFood: idFood)
        if foodFavouriteCondition {
            base?.saveFavourite(id: idFood, favouriteCondition: 0)
        } else {
            base?.saveFavourite(id: idFood, favouriteCondition: 1)
        }
    }
    
    
    //MARK: - Получение остояния кнопки "избранное"
    func getFavouriteHidden(idFood: Int) -> Bool {
        let itemFood = receiveData(id: String(idFood))
        print(itemFood)
        let itemFoodFavouriteCondition = itemFood["isFavourite"] ?? 0
        if itemFoodFavouriteCondition == 1 {
            return true
        }
            return false
    }
    
    
}
