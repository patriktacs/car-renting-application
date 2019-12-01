//
//  CarRentListViewModel.swift
//  CarRentingApplication
//
//  Created by Ács Patrik on 2019. 11. 23..
//  Copyright © 2019. Ács Patrik Tamás. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

protocol CarRentListViewModelType {
    
    var rentsRefreshRelay: BehaviorRelay<Void> { get }
    var rentItems: Observable<[RentsTableViewCellItemViewModel]> { get }
    
    var carName: String { get }
}

class CarRentListViewModel: CarRentListViewModelType {
    
    var rentsRefreshRelay: BehaviorRelay<Void> {
        return carsInteractor.rentsRefreshRelay
    }
    var rentItems: Observable<[RentsTableViewCellItemViewModel]>
    
    var carName: String
    
    var carsInteractor: CarInteractor!
    
    init(carsInteractor: CarInteractor) {
        self.carsInteractor = carsInteractor
        
        self.rentItems = carsInteractor.getRents().map { rents -> [RentsTableViewCellItemViewModel] in
                var itemViewModels: [RentsTableViewCellItemViewModel] = []

                for rent in rents {
                    itemViewModels.append(RentsTableViewCellItemViewModel(rent: rent))
                }
                
                return itemViewModels
        }
        
        self.carName = (carsInteractor.currentCar.brand ?? "") + " " + (carsInteractor.currentCar.model ?? "")
    }
}
