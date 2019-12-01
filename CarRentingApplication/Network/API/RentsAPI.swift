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
    case postStartRent(token: String, rentId: String)
    case postCancelRent(token: String, rentId: String)
    case postStopRent(token: String, rentId: String)
}

extension RentsAPI: TargetType {
    var baseURL: URL {
        return URL(string: "http://ec2-3-14-28-216.us-east-2.compute.amazonaws.com")!
    }
    
    var path: String {
        switch self {
        case .getRents:
            return "/rents"
        case .postStartRent(token: _, let rentId):
            return "/rents/" + rentId + "/start"
        case .postCancelRent(token: _, let rentId):
            return "/rents/" + rentId + "/cancel"
        case .postStopRent(token: _, let rentId):
            return "/rents/" + rentId + "/stop"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .getRents:
            return .get
        case .postStartRent, .postCancelRent, .postStopRent:
            return .post
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
        case .postStartRent(let token, rentId: _), .postCancelRent(let token, rentId: _), .postStopRent(let token, rentId: _):
            return ["Authorization": "Basic " + token]
        }
    }
}
