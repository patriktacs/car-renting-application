//
//  RentsAPI.swift
//  CarRentingApplication
//
//  Created by Ács Patrik on 2019. 11. 24..
//  Copyright © 2019. Ács Patrik Tamás. All rights reserved.
//

import Foundation
import Moya

enum RentsAPI {
    case getRents(token: String)
}

extension RentsAPI: TargetType {
    var baseURL: URL {
        return URL(string: "http://ec2-3-14-28-216.us-east-2.compute.amazonaws.com")!
    }
    
    var path: String {
        switch self {
        case .getRents:
            return "/rents"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .getRents:
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
        case .getRents(let token):
            return ["Authorization": "Basic " + token]
        }
    }
}
