//
//  NetworkLayer.swift
//  gambit
//
//  Created by islam on 12.03.2022.
//

import UIKit
import Foundation
import Alamofire

class  NetworkService {
    static let shared = NetworkService()
    private init() {}
    public func getTheFood(complition: @escaping([Food]?) -> Void) {
        let url = "https://api.gambit-app.ru/category/39?page=1"
        AF.request(url).responseDecodable(of: [Food].self) { (response) in
            complition(response.value)
        }
    }
}
