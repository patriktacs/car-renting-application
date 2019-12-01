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
import Moya

protocol RentingInteractor {
    
    var ownRentsRefreshRelay: BehaviorRelay<Void> { get }
    var ownRents: Observable<[Rent]> { get }
    
    var rentsRefreshRelay: PublishRelay<Void> { get }
    var rents: Observable<[Rent]> { get }
    
    var currentRent: Rent { get set }
    
    func startRent() -> Single<Response>
    func cancelRent() -> Single<Response>
    func stopRent() -> Single<Response>
}

class RentsInteractor: RentingInteractor {
    
    var ownRentsRefreshRelay = BehaviorRelay<Void>(value: ())
    var ownRents: Observable<[Rent]>
    
    var rentsRefreshRelay = PublishRelay<Void>()
    var rents: Observable<[Rent]>
    
    var currentRent = Rent()
    
    var sessionManager: SessioningManager!
    var networkManager: NetworkingManager!
    
    init(sessionManager: SessioningManager, networkManager: NetworkingManager) {
        self.networkManager = networkManager
        self.sessionManager = sessionManager
        
        self.ownRents = ownRentsRefreshRelay.flatMapLatest({ _ -> Single<[Rent]> in
            return networkManager.provider.requestDecoded(RentsAPI.getRents(token: sessionManager.token))
        }).share(replay: 1, scope: .forever)
        
        self.rents = rentsRefreshRelay.flatMapLatest({ _ -> Single<[Rent]> in
            return networkManager.provider.requestDecoded(RentsAPI.getRents(token: sessionManager.token))
        }).share(replay: 1, scope: .forever)
    }
    
    func startRent() -> Single<Response> {
        return self.networkManager.provider.rx.request(MultiTarget(RentsAPI.postStartRent(token: sessionManager.token, rentId: String(currentRent.rentId ?? 0))))
        .filterSuccessfulStatusCodes()
    }
    
    func cancelRent() -> Single<Response> {
        return self.networkManager.provider.rx.request(MultiTarget(RentsAPI.postCancelRent(token: sessionManager.token, rentId: String(currentRent.rentId ?? 0))))
        .filterSuccessfulStatusCodes()
    }
    
    func stopRent() -> Single<Response> {
        return self.networkManager.provider.rx.request(MultiTarget(RentsAPI.postStopRent(token: sessionManager.token, rentId: String(currentRent.rentId ?? 0))))
        .filterSuccessfulStatusCodes()
    }
}
