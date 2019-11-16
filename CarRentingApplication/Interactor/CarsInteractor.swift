//
//  CarsInteractor.swift
//  CarRentingApplication
//
//  Created by Ács Patrik on 2019. 11. 10..
//  Copyright © 2019. Ács Patrik Tamás. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

protocol CarInteractor {
    
    var carsRefreshRelay: BehaviorRelay<Void> { get }
    var cars: Observable<[Car]> { get }
    var currentCar: Car { get set }
}

class CarsInteractor: CarInteractor {
    
    var carsRefreshRelay = BehaviorRelay<Void>(value:())
    var cars: Observable<[Car]>
    
    var currentCar: Car = Car()
    
    var networkManager: NetworkingManager!
    var sessionManager: SessioningManager!
    
    init(networkManager: NetworkingManager, sessionManager: SessioningManager) {
        self.networkManager = networkManager
        self.sessionManager = sessionManager
        
        self.cars = carsRefreshRelay.flatMapLatest({ _ -> Single<[Car]> in
            return networkManager.provider.requestDecoded(CarsAPI.getCars(token: sessionManager.token))
        }).share(replay: 1, scope: .forever)
    }
}
