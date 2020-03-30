//
//  ViewController.swift
//  Codable
//
//  Created by Ahmed masoud on 3/30/20.
//  Copyright © 2020 Ahmed Masoud. All rights reserved.
//

import UIKit
import Alamofire

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchData(url: "https://jsonplaceholder.typicode.com/users", responseClass: [UserModel].self) { (response) in
            switch response {
            case .success(let users):
                guard let users = users else { return }
                for user in users {
                    print("name -> \(user.name)")
                }
            case .failure(_):
                print("ERROR")
            }
        }
        
    }
    
    func fetchData<T: Decodable>(url: String, responseClass: T.Type , completion:@escaping (Result<T?, NSError>) -> Void) {
        AF.request(url, method: .get, parameters: [:], headers: [:]).responseJSON { (response) in
            guard let statusCode = response.response?.statusCode else { return }
            if statusCode == 200 { // Success
                guard let jsonResponse = try? response.result.get() else { return }
                guard let theJSONData = try? JSONSerialization.data(withJSONObject: jsonResponse, options: []) else { return }
                guard let responseObj = try? JSONDecoder().decode(T.self, from: theJSONData) else { return }
                completion(.success(responseObj))
            }
        }
    }
}
