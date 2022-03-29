//
//  File.swift
//  gambit
//
//  Created by islam on 15.03.2022.
//

import Foundation
//MARK: Работа с юзерДефаулт
class Base: SaveCardProtocol {
    let defaults = UserDefaults.standard
    
    //MARK: - Запись количества блюд
    func saveCount(id: String, countDish: Int) {
        let chekToFood = requestData(id: id)
        let foodIsFavourite = chekToFood["isFavourite"] ?? 0
        let item = ["count": countDish, "isFavourite": foodIsFavourite]
        defaults.set(item, forKey: id)
    }
    
    //MARK: - Запись состояния кнопки избранное
    func saveFavourite(id: Int, favouriteCondition: Int) {
        saveListIsFavorite(id: id, favouriteCondition: favouriteCondition)
        let id = String(id)
        let chekToFood = requestData(id: id)
        let countDish = chekToFood["count"] ?? 0
        let item = ["count": countDish, "isFavourite": favouriteCondition]
        defaults.set(item, forKey: id)
    }
    //MARK: - Сохранение списка избранных
    func saveListIsFavorite(id: Int, favouriteCondition: Int){
        var response = requestListIsFavorite()
        if favouriteCondition == 1 {
            response.append(id)
            defaults.set(response, forKey: "listIsFavourite")
        } else {
            print(" qwe \(response)  id \(id)")
            var respons = [Int]()
            response.forEach({
                    if ($0 / id) != 1 {
                        respons.append($0)
                    }
                })
            print(" itog \(respons)")
            defaults.set(respons, forKey: "listIsFavourite")
        }
    }
    
    //MARK: Получение с юзерДефаулт количества и состояние кнопки лайка
    func requestData(id: String) -> Dictionary<String, Int> {
        let response = defaults.object(forKey: id) as? Dictionary<String, Int> ?? ["count": 0, "isFavourite": 0]
        return response
    }
    
    //MARK: Получение с юзерДефаулт списка избранных
    func requestListIsFavorite() -> Array<Int> {
        let response = defaults.array(forKey: "listIsFavourite")
        print("список \(response as? Array<Int> ?? [])")
        return response as? Array<Int> ?? [Int]()
    }
}

