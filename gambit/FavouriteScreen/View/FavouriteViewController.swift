//
//  FavouriteViewController.swift
//  gambit
//
//  Created by islam on 27.03.2022.
//

import UIKit

class FavouriteViewController: UIViewController {
    

    @IBOutlet weak var modalWindow: UIView!
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    var presenter: MainViewPresenterProtocol!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UINib(nibName: "FoodTableViewCell", bundle: nil), forCellReuseIdentifier: "Cell")
        self.title = "Избранное"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }


}

extension FavouriteViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let response: Array<Int>? = presenter.receiveListFavourite()
        if response?.count == 0 {
            modalWindow.isHidden = false
        } else {
            modalWindow.isHidden = true
        }
        return response?.count ?? 0
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as? FoodTableViewCell else { return UITableViewCell() }
        let foods = presenter.foods
        var food: Food?
        let response = presenter.receiveListFavourite()
        foods?.forEach({
            if $0.id == response[indexPath.row] {
                food = $0
            }
        })
        cell.setupCell(food ?? Food(id: nil, name: "failure", image: "", price: nil, description: "", nutritionFacts: nil), delegate: self)
        cell.layer.masksToBounds = false
        cell.layer.cornerRadius = 8
        return cell
    }
    
 
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let foods = presenter.foods
        var food: Food?
        let response = presenter.receiveListFavourite()
        foods?.forEach({
            if $0.id == response[indexPath.row] {
                food = $0
            }
        })
        presenter.tapOnTheFood(food: food)
    }
}

extension FavouriteViewController: MainProtocol, MainTableDelegate {
 
    func countFood(plusMinus: Bool, count: Int, id: String) -> Int {
        return 1
    }
    
    func receiveDataFood(id: String) -> Dictionary<String, Int>? {
        return ["csc": 1]
    }
    
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
