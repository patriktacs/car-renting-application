//
//  NetworkConfig.swift
//  CarRentingApplication
//
//  Created by Ács Patrik on 2019. 10. 20..
//  Copyright © 2019. Ács Patrik Tamás. All rights reserved.
//

import Foundation
import Moya

protocol NetworkingConfig {
    var authHeaderName: String { get }
    var authHeaderType: String { get }
    
    var timeoutIntervalForRequest: TimeInterval { get }
}

class NetworkConfig: NetworkingConfig {
    var authHeaderName = "Authorization"
    var authHeaderType = "Bearer"
    
    let timeoutIntervalForRequest: TimeInterval = 5
}
