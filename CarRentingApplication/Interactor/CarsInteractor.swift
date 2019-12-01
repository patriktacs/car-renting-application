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
import Moya

protocol CarInteractor {
    
    var carsRefreshRelay: BehaviorRelay<Void> { get }
    var cars: Observable<[Car]> { get }
    
    var rentsRefreshRelay: BehaviorRelay<Void> { get }
    
    var stations: Observable<[Station]> { get }
    
    var currentCar: Car { get set }
    var startStation: Station { get set }
    var endStation: Station { get set }
    
    var startDateRelay: BehaviorRelay<String?> { get }
    var endDateRelay: BehaviorRelay<String?> { get }
    
    func getRents() -> Observable<[Rent]>
    func rent() -> Single<Response>
}

class CarsInteractor: CarInteractor {
    
    var carsRefreshRelay = BehaviorRelay<Void>(value: ())
    var cars: Observable<[Car]>
    
    var rentsRefreshRelay = BehaviorRelay<Void>(value: ())
    
    var stations: Observable<[Station]>
    
    var currentCar: Car = Car()
    var startStation: Station = Station()
    var endStation: Station = Station()
    
    var startDateRelay = BehaviorRelay<String?>(value: "")
    var endDateRelay = BehaviorRelay<String?>(value: "")
    
    var networkManager: NetworkingManager!
    var sessionManager: SessioningManager!
    
    init(networkManager: NetworkingManager, sessionManager: SessioningManager) {
        self.networkManager = networkManager
        self.sessionManager = sessionManager
        
        self.cars = carsRefreshRelay.flatMapLatest({ _ -> Single<[Car]> in
            return networkManager.provider.requestDecoded(CarsAPI.getCars(token: sessionManager.token))
        }).share(replay: 1, scope: .forever)
        
        self.stations = networkManager.provider.requestDecoded(CarsAPI.getStations(token: sessionManager.token)).asObservable()
    }
    
    func getRents() -> Observable<[Rent]> {
        return rentsRefreshRelay.flatMapLatest({ _ -> Single<[Rent]> in
            return self.networkManager.provider.requestDecoded(CarsAPI.getCarRents(carId: String(self.currentCar.carId ?? 1), token: self.sessionManager.token))
        }).share(replay: 1, scope: .forever)
    }
    
    func rent() -> Single<Response> {
        return self.networkManager.provider.rx.request(MultiTarget(CarsAPI.postRent(startDate: startDateRelay.value ?? "", endDate: endDateRelay.value ?? "", startStationId: startStation.stationId ?? 0, endStationId: endStation.stationId ?? 0, carId: String(currentCar.carId ?? 1), token: sessionManager.token )))
            .filterSuccessfulStatusCodes()
    }
}
