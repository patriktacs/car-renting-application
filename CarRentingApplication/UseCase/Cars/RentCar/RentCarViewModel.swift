//
//  RentCarViewModel.swift
//  CarRentingApplication
//
//  Created by Ács Patrik on 2019. 11. 24..
//  Copyright © 2019. Ács Patrik Tamás. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

import Moya

protocol RentCarViewModelType {
    
    var stations: Observable<[Station]> { get }
    var stationNames: Observable<[String]> { get }
    
    var startDateRelay: BehaviorRelay<String?> { get }
    var endDateRelay: BehaviorRelay<String?> { get }
    
    func setStartStation(station: Station)
    func setEndStation(station: Station)
    func rent() -> Single<Response>
}

class RentCarViewModel: RentCarViewModelType {
    
    var carsInteractor: CarInteractor!
    
    var stations: Observable<[Station]> {
        return carsInteractor.stations
    }
    var stationNames: Observable<[String]>
    
    var startDateRelay: BehaviorRelay<String?> {
        return carsInteractor.startDateRelay
    }
    
    var endDateRelay: BehaviorRelay<String?> {
        return carsInteractor.endDateRelay
    }
    
    init(carsInteractor: CarInteractor) {
        self.carsInteractor = carsInteractor
        
        self.stationNames = carsInteractor.stations.map {
            var stationNames: [String] = []
            
            for station in $0 {
                stationNames.append(station.name ?? "")
            }
            
            return stationNames
        }
    }
    
    func setStartStation(station: Station) {
        carsInteractor.startStation = station
    }
    
    func setEndStation(station: Station) {
        carsInteractor.endStation = station
    }
    
    func rent() -> Single<Response> {
        carsInteractor.rent()
    }
}
