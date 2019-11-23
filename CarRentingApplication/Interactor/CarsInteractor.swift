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
    
    var rentsRefreshRelay: BehaviorRelay<Void> { get }
    var rents: Observable<[Rent]> { get }
    
    var currentCar: Car { get set }
}

class CarsInteractor: CarInteractor {
    
    var carsRefreshRelay = BehaviorRelay<Void>(value: ())
    var cars: Observable<[Car]>
    
    var rentsRefreshRelay = BehaviorRelay<Void>(value: ())
    var rents: Observable<[Rent]>
    
    var currentCar: Car = Car()
    
    var networkManager: NetworkingManager!
    var sessionManager: SessioningManager!
    
    init(networkManager: NetworkingManager, sessionManager: SessioningManager) {
        self.networkManager = networkManager
        self.sessionManager = sessionManager
        
        self.cars = carsRefreshRelay.flatMapLatest({ _ -> Single<[Car]> in
            return networkManager.provider.requestDecoded(CarsAPI.getCars(token: sessionManager.token))
        }).share(replay: 1, scope: .forever)
        
        let car = currentCar
        self.rents = carsRefreshRelay.flatMapLatest({ _ -> Single<[Rent]> in
            return networkManager.provider.requestDecoded(CarsAPI.getCarRents(carId: String(car.cardId ?? 0), token: sessionManager.token))
        }).share(replay: 1, scope: .forever)
    }
}
