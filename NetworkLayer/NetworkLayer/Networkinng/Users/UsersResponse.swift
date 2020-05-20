//
//  UsersResponse.swift
//  NetworkLayer
//
//  Created by Ahmed masoud on 5/21/20.
//  Copyright © 2020 Ahmed Masoud. All rights reserved.
//

import Foundation

class UsersResponse: Codable {
    var data: [UserModel]?
    
    enum CodingKeys: String, CodingKey {
        case data = "data"
    }
}
