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
        //MARK: Получаем состояние кнопки
        let foodIsFavourite = chekToFood["isFavourite"] ?? 0
        //MARK: Сохраняем новое количество
        let item = ["count": countDish, "isFavourite": foodIsFavourite]
        defaults.set(item, forKey: id)
    }
    
    //MARK: - Запись состояния кнопки избранное
    func saveFavourite(id: Int, favouriteCondition: Int) {
        let id = String(id)
        let chekToFood = requestData(id: id)
        //MARK: Получаем количество блюд
        let countDish = chekToFood["count"] ?? 0
        //MARK: Сохраняем новое состояние кнопки избранное
        let item = ["count": countDish, "isFavourite": favouriteCondition]
        defaults.set(item, forKey: id)
    }
    
    //MARK: Получение с юзерДефаулт
    func requestData(id: String) -> Dictionary<String, Int> {
        let response = defaults.object(forKey: id) as? Dictionary<String, Int> ?? ["count": 0, "isFavourite": 0]
        return response
    }
}

