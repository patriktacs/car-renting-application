//
//  OwnRentDetailsViewModel.swift
//  CarRentingApplication
//
//  Created by Ács Patrik on 2019. 12. 01..
//  Copyright © 2019. Ács Patrik Tamás. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import Moya

protocol OwnRentDetailsViewModelType {
    
    var dataRefreshRelay: BehaviorRelay<Void> { get }
    var data: Observable<RentData> { get }
    
    var startDate: Date { get }
    
    func startRent() -> Single<Response>
    func cancelRent() -> Single<Response>
    func stopRent() -> Single<Response>
    func setRentStatusToStarted()
    func setRentStatusToStopped()
}

class OwnRentDetailsViewModel: OwnRentDetailsViewModelType {
    
    var dataRefreshRelay = BehaviorRelay<Void>(value: ())
    var data: Observable<RentData>
    
    var startDate: Date
    
    var rentsInteractor: RentingInteractor!
    
    init(rentsInteractor: RentingInteractor) {
        self.rentsInteractor = rentsInteractor
        
        self.data = dataRefreshRelay
            .flatMapLatest({ _ -> Observable<RentData> in
                return Observable.just(RentData(rent: rentsInteractor.currentRent))
            }).share(replay: 1, scope: .forever)
        
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "yyyy-MM-dd'T'HH:mm"
        
        self.startDate = dateFormatterGet.date(from: rentsInteractor.currentRent.plannedStartTime ?? "") ?? Date()
    }
    
    func startRent() -> Single<Response> {
        return rentsInteractor.startRent()
    }
    
    func cancelRent() -> Single<Response> {
        return rentsInteractor.cancelRent()
    }
    
    func stopRent() -> Single<Response> {
        return rentsInteractor.stopRent()
    }
    
    func setRentStatusToStarted() {
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "yyyy-MM-dd'T'HH:mm"
        
        self.rentsInteractor.currentRent.state = "RENTED"
        self.rentsInteractor.currentRent.actualStartTime = dateFormatterGet.string(from: Date())
    }
    
    func setRentStatusToStopped() {
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "yyyy-MM-dd'T'HH:mm"
        
        self.rentsInteractor.currentRent.state = "UNCLOSED"
        self.rentsInteractor.currentRent.actualEndTime = dateFormatterGet.string(from: Date())
    }
}
