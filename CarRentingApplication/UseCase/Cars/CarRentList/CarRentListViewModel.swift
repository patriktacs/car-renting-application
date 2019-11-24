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
}

class CarRentListViewModel: CarRentListViewModelType {
    
    var rentsRefreshRelay: BehaviorRelay<Void> {
        return carsInteractor.rentsRefreshRelay
    }
    var rentItems: Observable<[RentsTableViewCellItemViewModel]>
    
    var carsInteractor: CarInteractor!
    
    init(carsInteractor: CarInteractor) {
        self.carsInteractor = carsInteractor
        
        self.rentItems = carsInteractor.getRents().map { rents -> [RentsTableViewCellItemViewModel] in
                var itemViewModels: [RentsTableViewCellItemViewModel] = []

                for rent in rents {
                    if rent.state == "RESERVED" {
                        itemViewModels.append(RentsTableViewCellItemViewModel(rent: rent))
                    }
                }
                
                return itemViewModels
        }
    }
}
