//
//  MainViewController.swift
//  gambit
//
//  Created by islam on 12.03.2022.
//

import UIKit

class MainViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    var presenter: MainViewPresenterProtocol!
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "GAMBIT"
        tableView.register(UINib(nibName: "FoodTableViewCell", bundle: nil), forCellReuseIdentifier: "Cell")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
}
//MARK: - Работа с таблицей
extension MainViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.foods?.count ?? 0
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as? FoodTableViewCell else { return UITableViewCell() }
        let food = presenter.foods?[indexPath.row] ?? Food(id: nil, name: "failure", image: "", price: nil, description: "", nutritionFacts: nil)
        cell.setupCell(food, delegate: self)
        cell.layer.masksToBounds = false
        cell.layer.cornerRadius = 8
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let swipeFavourite = UIContextualAction(style: .normal, title: .none) { [weak self] (action, view, succes) in
            guard let self = self else { return }
            let food = self.presenter.foods?[indexPath.row]
            let idFood = food?.id ?? 0
            self.presenter.setFavouriteHidden(idFood: idFood)
            succes(true)
        }
        
        
        let food = self.presenter.foods?[indexPath.row]
        let condition = food?.id ?? 0
        var logo: UIImage!
        if self.presenter.getFavouriteHidden(idFood: condition) {
            logo = UIImage(systemName: "heart.fill")?.sd_tintedImage(with: .red)
        } else {
            logo = UIImage(systemName: "heart")
        }
        swipeFavourite.image = logo
        swipeFavourite.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.04)
//        swipeFavourite.image.
        let conf = UISwipeActionsConfiguration(actions: [swipeFavourite])
//        conf.
        conf.performsFirstActionWithFullSwipe = false
        return conf
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let food = presenter.foods?[indexPath.row]
        presenter.tapOnTheFood(food: food)
    }
}


//MARK: - Реализация протоколов ответ от сервера
extension MainViewController: MainProtocol {
    func succes() {
        tableView.reloadData()
        activityIndicator.stopAnimating()
        activityIndicator.isHidden = true
    }
    
    func failure() {
        print("что-то пошло не так")
        activityIndicator.stopAnimating()
        activityIndicator.isHidden = true
    }
    
    
}

//MARK: - Реализация протоколов получение колличества и его изменения
extension MainViewController: MainTableDelegate {
    func receiveDataFood(id: String) -> Dictionary<String, Int>? {
        let data = presenter.receiveData(id: id)
        return data
    }
    
    func countFood(plusMinus: Bool, count: Int, id: String) -> Int {
        let count = presenter.plusMinus(plusMinus: plusMinus, count: count, id: id)
        return count
    }
}
