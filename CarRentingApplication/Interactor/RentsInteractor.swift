//
//  RentsInteractor.swift
//  CarRentingApplication
//
//  Created by Ács Patrik on 2019. 11. 24..
//  Copyright © 2019. Ács Patrik Tamás. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

protocol RentingInteractor {
    
    var ownRentsRefreshRelay: BehaviorRelay<Void> { get }
    var ownRents: Observable<[Rent]> { get }
}

class RentsInteractor: RentingInteractor {
    
    var ownRentsRefreshRelay = BehaviorRelay<Void>(value: ())
    var ownRents: Observable<[Rent]>
    
    var sessionManager: SessioningManager!
    var networkManager: NetworkingManager!
    
    init(sessionManager: SessioningManager, networkManager: NetworkingManager) {
        self.networkManager = networkManager
        self.sessionManager = sessionManager
        
        self.ownRents = ownRentsRefreshRelay.flatMapLatest({ _ -> Single<[Rent]> in
            return networkManager.provider.requestDecoded(RentsAPI.getRents(token: sessionManager.token))
        }).share(replay: 1, scope: .forever)
    }
}
