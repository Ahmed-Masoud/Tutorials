//
//  UserModel.swift
//  NetworkLayer
//
//  Created by Ahmed masoud on 5/21/20.
//  Copyright © 2020 Ahmed Masoud. All rights reserved.
//

import Foundation

class UserModel: Codable {
    var name: String?
    var salary: String?
    
    enum CodingKeys: String, CodingKey {
        case name = "employee_name"
        case salary = "employee_salary"
    }
}
