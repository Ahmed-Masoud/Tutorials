//
//  ViewController.swift
//  NetworkLayer
//
//  Created by Ahmed masoud on 3/30/20.
//  Copyright © 2020 Ahmed Masoud. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let api: UsersAPIProtocol = UsersAPI()
        api.getUsers { (result) in
            switch result {
            case .success(let response):
                let users = response?.data
                for user in users ?? [] {
                    print("\(user.firstName) \(user.lastName)")
                }
            case .failure(let error):
                print(error.userInfo[NSLocalizedDescriptionKey] as? String)
            }
        }
    }


}

