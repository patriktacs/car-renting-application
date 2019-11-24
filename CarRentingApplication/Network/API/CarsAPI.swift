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
    case getCarRents(carId: String, token: String)
    case getStations(token: String)
    case postRent(startDate: String, endDate: String, startStationId: Int, endStationId: Int, carId: String, token: String)
}

extension CarsAPI: TargetType {
    var baseURL: URL {
        return URL(string: "http://ec2-3-14-28-216.us-east-2.compute.amazonaws.com")!
    }
    
    var path: String {
        switch self {
        case .getCars:
            return "/cars"
        case .getCarRents(let carId, token: _):
            return "/cars/" + carId + "/rents"
        case .getStations(token: _):
            return "/stations"
        case .postRent(startDate: _, endDate: _, startStationId: _, endStationId: _, let carId, token: _):
            return "/cars/" + carId + "/reserve"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .getCars:
            return .get
        case .getCarRents:
            return .get
        case .getStations(token: _):
            return .get
        case .postRent:
            return .post
        }
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var task: Task {
        switch self {
        case .postRent(let startDate, let endDate, let startStationId, let endStationId, carId: _, token: _):
            return .requestParameters(parameters:
                ["StartDate": startDate,
                 "EndDate": endDate,
                 "StartStationId": startStationId,
                 "EndStationId": endStationId],
                encoding: URLEncoding.default)
        default:
            return .requestPlain
        }
    }
    
    var headers: [String : String]? {
        switch self {
        case .getCars(let token):
            return ["Authorization": "Basic " + token]
        case .getCarRents(carId: _ , let token):
            return ["Authorization": "Basic " + token]
        case .getStations(let token):
            return ["Authorization": "Basic " + token]
        case .postRent(startDate: _, endDate: _, startStationId: _, endStationId: _, carId: _, let token):
            return ["Authorization": "Basic " + token]
        }
    }
    
    
}
