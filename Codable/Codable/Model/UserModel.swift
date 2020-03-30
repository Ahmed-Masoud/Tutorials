//
//  UserModel.swift
//  Codable
//
//  Created by Ahmed masoud on 3/30/20.
//  Copyright © 2020 Ahmed Masoud. All rights reserved.
//

import Foundation

class UserModel: Decodable {
    //MARK:- Properties
    var id: Int?
    var name: String?
    var email: String?
    var userName: String?
    var company: CompanyModel?
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case email
        case userName = "username"
        case company
    }
}
