//
//  CarsAPI.swift
//  CarRentingApplication
//
//  Created by Ács Patrik on 2019. 11. 10..
//  Copyright © 2019. Ács Patrik Tamás. All rights reserved.
//

import Foundation
import Moya

enum CarsAPI {
    case getCars(token: String)
}

extension CarsAPI: TargetType {
    var baseURL: URL {
        switch self {
        case .getCars:
            return URL(string: "http://ec2-3-14-28-216.us-east-2.compute.amazonaws.com")!
        }
    }
    
    var path: String {
        switch self {
        case .getCars:
            return "/cars"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .getCars:
            return .get
        }
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var task: Task {
        return .requestPlain
    }
    
    var headers: [String : String]? {
        switch self {
        case .getCars(let token):
            return ["Authorization": "Basic " + token]
        }
    }
    
    
}
