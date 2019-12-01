//
//  PositionAPI.swift
//  CarRentingApplication
//
//  Created by Ács Patrik on 2019. 12. 01..
//  Copyright © 2019. Ács Patrik Tamás. All rights reserved.
//

import Foundation
import Moya

enum PositionAPI {
    case postPosition(token: String, latitude: Double, longitude: Double)
}

extension PositionAPI: TargetType {
    var baseURL: URL {
        return URL(string: "http://ec2-3-14-28-216.us-east-2.compute.amazonaws.com")!
    }
    
    var path: String {
        return "/positions/submit"
    }
    
    var method: Moya.Method {
        return .post
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var task: Task {
        switch self {
        case .postPosition(token: _, let latitude, let longitude):
            return .requestParameters(parameters:
                ["latitude": latitude,
                 "longitude": longitude],
                encoding: URLEncoding.default)
        }
    }
    
    var headers: [String : String]? {
        switch self {
        case .postPosition(let token, latitude: _, longitude: _):
            return ["Authorization": "Basic " + token]
        }
        
    }
}
