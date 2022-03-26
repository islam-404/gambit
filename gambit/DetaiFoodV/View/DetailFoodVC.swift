//
//  DetailFoodVC.swift
//  gambit
//
//  Created by islam on 22.03.2022.
//

import UIKit
import Alamofire

class DetailFoodVC: UIViewController {
    
    @IBOutlet weak var foodName: UILabel!
    @IBOutlet weak var foodImage: UIImageView!
    @IBOutlet weak var foodCount: UILabel!
    @IBOutlet weak var foodPrice: UILabel!
    @IBOutlet weak var isFavoriteOutlet: UIButton!
    @IBOutlet weak var foodDescription: UILabel!
    @IBOutlet weak var foodWeight: UILabel!
    @IBOutlet weak var foodCalories: UILabel!
    @IBOutlet weak var foodProtein: UILabel!
    @IBOutlet weak var foodFat: UILabel!
    @IBOutlet weak var foodCarbohydrates: UILabel!
    @IBOutlet weak var ButtonDec: UIButton!
    @IBOutlet weak var ButtonInc: UIButton!
    
    
    var presenter: MainViewPresenterProtocol?
    var food: Food?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setFood(food: food)
    }

    func setFood(food: Food?) {
        foodName.text = food?.name
        let receiveData = presenter?.receiveData(id: "\(food?.id ?? 0)")
        foodCount.text = "\(receiveData!["count"] ?? 0)"
        
        foodPrice.widthAnchor.constraint(equalToConstant: 63).isActive = true
        foodPrice.heightAnchor.constraint(equalToConstant: 32).isActive = true
        foodPrice.font = UIFont.systemFont(ofSize: 14, weight: UIFont.Weight.bold)
        foodPrice.layer.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.04).cgColor
        foodPrice.layer.cornerRadius = 8
        
        ButtonDec.widthAnchor.constraint(equalToConstant: 32).isActive = true
        ButtonDec.heightAnchor.constraint(equalToConstant: 32).isActive = true
        ButtonDec.layer.backgroundColor = UIColor(red: 0.892, green: 0.071, blue: 0.563, alpha: 1).cgColor
        ButtonDec.layer.cornerRadius = 8
        
        ButtonInc.widthAnchor.constraint(equalToConstant: 32).isActive = true
        ButtonInc.heightAnchor.constraint(equalToConstant: 32).isActive = true
        ButtonInc.layer.backgroundColor = UIColor(red: 0.892, green: 0.071, blue: 0.563, alpha: 1).cgColor
        ButtonInc.layer.cornerRadius = 8
        
        
        foodPrice.text = "\(food?.price ?? 0) ₽"
        
        foodImage.sd_setImage(with: URL(string: food?.image ?? ""))
        foodDescription.text = "\(food?.description ?? "")\(food?.description ?? "")\(food?.description ?? "")\(food?.description ?? "")\(food?.description ?? "")\(food?.description ?? "")\(food?.description ?? "")\(food?.description ?? "")\(food?.description ?? "")\(food?.description ?? "")\(food?.description ?? "")\(food?.description ?? "")\(food?.description ?? "")\(food?.description ?? "")\(food?.description ?? "") end"
        foodWeight.text = "\(food?.nutritionFacts?.weight ?? 0)"
        foodCalories.text = "\(food?.nutritionFacts?.calories ?? 0)"
        foodProtein.text = "\(food?.nutritionFacts?.protein ?? 0)"
        foodFat.text = "\(food?.nutritionFacts?.fat ?? 0)"
        foodCarbohydrates.text = "\(food?.nutritionFacts?.carbohydrates ?? 0)"
        
        
        let nameImg = presenter?.setImgBtn(idFood: food?.id ?? 0) ?? "heart"
        if nameImg != "heart" {
            isFavoriteOutlet.setImage(UIImage(systemName: nameImg)?.sd_tintedImage(with: .red), for: .normal)
        } else {
            isFavoriteOutlet.setImage(UIImage(systemName: nameImg), for: .normal)
        }
    }
    
    @IBAction func isFavoriteAction(_ sender: UIButton) {
        print("ewqrwrw \(presenter!.getFavouriteHidden(idFood: food?.id ?? 0))")
        presenter?.setFavouriteHidden(idFood: food?.id ?? 0)
        let nameImg = presenter?.setImgBtn(idFood: food?.id ?? 0) ?? "heart"
        if nameImg != "heart" {
            sender.setImage(UIImage(systemName: nameImg)?.sd_tintedImage(with: .red), for: .normal)
        } else {
            sender.setImage(UIImage(systemName: nameImg), for: .normal)
        }
    }
    
    @IBAction func pressedButtonInc(_ sender: UIButton) {
        let count = Int(foodCount.text!) ?? 0
//        presenter?.foods?.count
        let countResponse = presenter?.plusMinus(plusMinus: true, count: count, id: String(food?.id ?? 0)) ?? 0
        foodCount.text = String(countResponse)
    }
    
    @IBAction func pressedButtonDec(_ sender: UIButton) {
        let count = Int(foodCount.text!) ?? 0
        let countResponse = presenter?.plusMinus(plusMinus: false, count: count, id: String(food?.id ?? 0)) ?? 0
        foodCount.text = String(countResponse)
    }
    
}




//extension DetailFoodVC: DetailFoodViewProtocol {
//    func setFood(food: Food?) {
//        foodImage.sd_setImage(with: URL(string: food?.image ?? ""))
//        foodDescription.text = "\(food?.description ?? "")"
//        foodWeight.text = "\(food?.nutritionFacts?.weight ?? 0)"
//        foodCalories.text = "\(food?.nutritionFacts?.calories ?? 0)"
//        foodProtein.text = "\(food?.nutritionFacts?.protein ?? 0)"
//        foodFat.text = "\(food?.nutritionFacts?.fat ?? 0)"
//        foodCarbohydrates.text = "\(food?.nutritionFacts?.carbohydrates ?? 0)"
//    }
//}
