//
//  Food.swift
//  gambit
//
//  Created by islam on 12.03.2022.
//

import Foundation

struct Food: Decodable {
    let id: Int?
    let name: String
    let image: String?
    let price: Int?
    let description: String?
    let nutritionFacts: NutritionFacts?
    var isFavourite: Int? = 0
}

struct NutritionFacts: Decodable {
    let weight: Int?
    let calories: Double?
    let protein: Double?
    let fat: Double?
    let carbohydrates: Double?
}
