//
//  FoodTableViewCell.swift
//  gambit
//
//  Created by islam on 12.03.2022.
//

import UIKit
import SDWebImage

protocol MainTableDelegate: AnyObject {
    func countFood(plusMinus: Bool, count: Int, id: String) -> Int
    func receiveDataFood(id: String) -> Dictionary<String, Int>?
}

class FoodTableViewCell: UITableViewCell {
    
    @IBOutlet weak var foodImage: UIImageView!
    @IBOutlet weak var foodName: UILabel!
    @IBOutlet weak var foodPrice: UILabel!
    @IBOutlet weak var foodCount: UILabel!
    @IBOutlet weak var foodButtonInc: UIButton!
    @IBOutlet weak var foodButtonDec: UIButton!
    @IBOutlet weak var activityIndicatorCell: UIActivityIndicatorView!
    
    private var id = 0
    weak var delegate: MainTableDelegate?
    
    //MARK: Установка значении для ячейки в "FoodTableViewCell: UITableViewCell"
    public func setupCell(_ food: Food, delegate: MainTableDelegate){
        self.delegate = delegate
        self.id = food.id ?? 0
        //MARK: Запрос в вьюконтроллер количетво сохр товаров. или надо было сразу в презентер?
        let receiveData = self.delegate?.receiveDataFood(id: String(id))
        foodCount.text = "\(receiveData!["count"] ?? 0)"
        
        foodPrice.widthAnchor.constraint(equalToConstant: 63).isActive = true
        foodPrice.heightAnchor.constraint(equalToConstant: 32).isActive = true
        //        foodPrice.layer.rasterizationScale = 22
        foodPrice.font = UIFont.systemFont(ofSize: 14, weight: UIFont.Weight.bold)
        foodPrice.layer.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.04).cgColor
        foodPrice.layer.cornerRadius = 8
        
        foodImage.sd_setImage(with: URL(string: food.image ?? ""))
        foodPrice.text = "\(String(describing: food.price ?? 0)) ₽"
        
        foodName.font = UIFont.systemFont(ofSize: 18)
        foodName.text = food.name
    }
    
    
    @IBAction func pressedButtonInc(_ sender: UIButton) {
        let count = Int(foodCount.text!) ?? 0
        let countResponse = delegate?.countFood(plusMinus: true, count: count, id: String(self.id)) ?? 0
        foodCount.text = String(countResponse)
    }
    
    @IBAction func pressedButtonDec(_ sender: UIButton) {
        let count = Int(foodCount.text!) ?? 0
        let countResponse = delegate?.countFood(plusMinus: false, count: count, id: String(self.id)) ?? 0
        foodCount.text = String(countResponse)
    }
}
