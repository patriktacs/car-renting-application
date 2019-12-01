//
//  CarListViewModel.swift
//  CarRentingApplication
//
//  Created by Ács Patrik on 2019. 11. 10..
//  Copyright © 2019. Ács Patrik Tamás. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

protocol CarListViewModelType {
    
    var carsRefreshRelay: BehaviorRelay<Void> { get }
    var carItems: Observable<[CarsTableViewCellItemViewModel]> { get }
    var cars: Observable<[Car]> { get }
    
    var iLNRelay: PublishRelay<Void> { get }
    var isLocationNeeded: Observable<Bool> { get }
    
    func logout()
    func setCurrentCar(car: Car)
}

class CarListViewModel: CarListViewModelType {
    
    var carsRefreshRelay: BehaviorRelay<Void> {
        return carsInteractor.carsRefreshRelay
    }
    var carItems: Observable<[CarsTableViewCellItemViewModel]>
    
    var cars: Observable<[Car]> {
        return carsInteractor.cars
    }
    
    var iLNRelay: PublishRelay<Void> {
        return carsInteractor.ownRentsRefreshRelay
    }
    var isLocationNeeded: Observable<Bool>
    
    var sessionManager: SessioningManager!
    var carsInteractor: CarInteractor!
    
    init(sessionManager: SessioningManager, carsInteractor: CarInteractor) {
        self.sessionManager = sessionManager
        self.carsInteractor = carsInteractor
        
        self.carItems = carsInteractor.cars.map {
            var itemViewModels: [CarsTableViewCellItemViewModel] = []
            
            for car in $0 {
                let itemViewModel = CarsTableViewCellItemViewModel(car: car)
                itemViewModels.append(itemViewModel)
            }
            
            return itemViewModels
        }
        
        self.isLocationNeeded = carsInteractor.ownRents
            .map { rents in
                var needed = false
                
                for rent in rents {
                    if (rent.positionReportRequested ?? false) {
                        needed = true
                    }
                }
                
                return needed
        }
    }
    
    func logout() {
        sessionManager.killSession()
    }
    
    func setCurrentCar(car: Car) {
        carsInteractor.currentCar = car
    }
}
