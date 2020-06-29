//
//  UsersNetworking.swift
//  NetworkLayer
//
//  Created by Ahmed masoud on 5/21/20.
//  Copyright © 2020 Ahmed Masoud. All rights reserved.
//

import Foundation
import Alamofire

enum UsersNetworking {
    case getUsers
    case createUser(name: String, job: String)
}

extension UsersNetworking: TargetType {
    var baseURL: String {
        switch self {
        case .getUsers:
            return "http://dummy.restapiexample.com/api/v1"
        default:
            return "https://reqres.in/api"
        }
    }
    
    var path: String {
        switch self {
        case .getUsers:
            return "/employees"
        case .createUser:
            return "/users"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .getUsers:
            return .get
        case .createUser:
            return .post
        }
    }
    
    var task: Task {
        switch self {
        case .getUsers:
            return .requestPlain
        case .createUser(let name, let job):
            return .requestParameters(parameters: ["name": name, "job": job], encoding: JSONEncoding.default)
        }
    }
    
    var headers: [String : String]? {
        switch self {
        default:
            return [:]
        }
    }
}
