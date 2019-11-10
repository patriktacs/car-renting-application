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
    var cars: Observable<[CarsTableViewCellItemViewModel]> { get }
    
    func logout()
}

class CarListViewModel: CarListViewModelType {
    
    var carsRefreshRelay: BehaviorRelay<Void> {
        return carsInteractor.carsRefreshRelay
    }
    var cars: Observable<[CarsTableViewCellItemViewModel]>
    
    var sessionManager: SessioningManager!
    var carsInteractor: CarInteractor!
    
    init(sessionManager: SessioningManager, carsInteractor: CarInteractor) {
        self.sessionManager = sessionManager
        self.carsInteractor = carsInteractor
        
        self.cars = carsInteractor.cars.map {
            var itemViewModels: [CarsTableViewCellItemViewModel] = []
            
            for car in $0 {
                let itemViewModel = CarsTableViewCellItemViewModel(car: car)
                itemViewModels.append(itemViewModel)
            }
            
            return itemViewModels
        }
    }
    
    func logout() {
        sessionManager.killSession()
    }
}
