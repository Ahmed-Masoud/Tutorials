//
//  UsersAPI.swift
//  NetworkLayer
//
//  Created by Ahmed masoud on 5/21/20.
//  Copyright © 2020 Ahmed Masoud. All rights reserved.
//

import Foundation

protocol UsersAPIProtocol {
    func getUsers(completion: @escaping (Result<UsersResponse?, NSError>) -> Void)
}


class UsersAPI: BaseAPI<UsersNetworking>, UsersAPIProtocol {
    
    //MARK:- Requests
    
    func getUsers(completion: @escaping (Result<UsersResponse?, NSError>) -> Void) {
        self.fetchData(target: .getUsers, responseClass: UsersResponse.self) { (result) in
            completion(result)
        }
    }
}
