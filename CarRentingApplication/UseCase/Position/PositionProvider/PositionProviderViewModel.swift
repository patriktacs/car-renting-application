//
//  PositionProviderViewModel.swift
//  CarRentingApplication
//
//  Created by Ács Patrik on 2019. 12. 01..
//  Copyright © 2019. Ács Patrik Tamás. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import Moya

protocol PositionProviderViewModelType {
    
    var longitudeRelay: BehaviorRelay<Double> { get }
    var latitudeRelay: BehaviorRelay<Double> { get }
    
    func sendPosition() -> Single<Response>
}

class PositionProviderViewModel: PositionProviderViewModelType {
    
    var longitudeRelay = BehaviorRelay<Double>(value: 0.0)
    var latitudeRelay = BehaviorRelay<Double>(value: 0.0)
    
    var positionInteractor: PositioningInteractor!
    
    init(positionInteractor: PositioningInteractor) {
        self.positionInteractor = positionInteractor
    }
    
    func sendPosition() -> Single<Response> {
        return self.positionInteractor.sendPosition(latitude: self.latitudeRelay.value, longitude: self.longitudeRelay.value)
    }
}
