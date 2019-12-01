//
//  PositionInteractor.swift
//  CarRentingApplication
//
//  Created by Ács Patrik on 2019. 12. 01..
//  Copyright © 2019. Ács Patrik Tamás. All rights reserved.
//

import Foundation
import RxSwift
import Moya

protocol PositioningInteractor {
    
    func sendPosition(latitude: Double, longitude: Double) -> Single<Response>
}

class PositionInteractor: PositioningInteractor {
    
    var networkManager: NetworkingManager!
    var sessionManager: SessioningManager!
    
    init(networkManager: NetworkingManager, sessionManager: SessioningManager) {
        self.networkManager = networkManager
        self.sessionManager = sessionManager
    }
    
    func sendPosition(latitude: Double, longitude: Double) -> Single<Response> {
        return self.networkManager.provider.rx.request(MultiTarget(PositionAPI.postPosition(token: self.sessionManager.token, latitude: latitude, longitude: longitude)))
        .filterSuccessfulStatusCodes()
    }
}
