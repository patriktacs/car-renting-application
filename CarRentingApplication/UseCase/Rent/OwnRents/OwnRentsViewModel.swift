//
//  OwnRentsViewModel.swift
//  CarRentingApplication
//
//  Created by Ács Patrik on 2019. 11. 24..
//  Copyright © 2019. Ács Patrik Tamás. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

protocol OwnRentsViewModelType {
    
    var ownRentsRefreshRelay: BehaviorRelay<Void> { get }
    var ownRentItems: Observable<[OwnRentsTableViewCellItemViewModel]> { get }
    
    var rents: Observable<[Rent]> { get }
    
    func logout()
    func setCurrentRent(rent: Rent)
}

class OwnRentsViewModel: OwnRentsViewModelType {
    
    var ownRentsRefreshRelay: BehaviorRelay<Void> {
        return rentsInteractor.ownRentsRefreshRelay
    }
    var ownRentItems: Observable<[OwnRentsTableViewCellItemViewModel]>
    
    var rents: Observable<[Rent]> {
        return rentsInteractor.ownRents
    }
    
    var rentsInteractor: RentingInteractor!
    var sessionManager: SessioningManager!
    
    init(rentsInteractor: RentingInteractor, sessionManager: SessioningManager) {
        self.rentsInteractor = rentsInteractor
        self.sessionManager = sessionManager
        
        self.ownRentItems = rentsInteractor.ownRents
            .map {
                var ownRentItems: [OwnRentsTableViewCellItemViewModel] = []
                
                for rent in $0 {
                    ownRentItems.append(OwnRentsTableViewCellItemViewModel(rent: rent))
                }
                
                return ownRentItems
        }
    }
    
    func logout() {
        self.sessionManager.killSession()
    }
    
    func setCurrentRent(rent: Rent) {
        rentsInteractor.currentRent = rent
    }
}
