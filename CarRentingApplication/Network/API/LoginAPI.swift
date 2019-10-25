//
//  LoginAPI.swift
//  CarRentingApplication
//
//  Created by Ács Patrik on 2019. 10. 20..
//  Copyright © 2019. Ács Patrik Tamás. All rights reserved.
//

import Foundation
import Moya

enum LoginAPI {
    case login(token: String)
}

extension LoginAPI: TargetType {
    var baseURL: URL {
        switch self {
        case .login:
            return URL(string: "https://penzfeldobas.herokuapp.com")!
        }
    }
    
    var path: String {
        switch self {
        case .login:
            return "/login/customer"
        }
        
    }
    
    var method: Moya.Method {
        switch self {
        case .login:
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
        case .login(let token):
            return ["Authorization": "Basic " + token]
        }
        
    }
    
    
}
