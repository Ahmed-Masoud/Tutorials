//
//  BaseResponse.swift
//  NetworkLayer
//
//  Created by Ahmed masoud on 6/29/20.
//  Copyright © 2020 Ahmed Masoud. All rights reserved.
//

import Foundation


class BaseResponse<T: Codable>: Codable {
    var status: String?
    var data: T?
    
    enum CodingKeys: String, CodingKey {
        case status = "status"
        case data = "data"
    }
}
