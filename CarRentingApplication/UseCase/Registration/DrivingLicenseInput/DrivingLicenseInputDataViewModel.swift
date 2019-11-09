//
//  DrivingLicenseInputDataViewModel.swift
//  CarRentingApplication
//
//  Created by Ács Patrik on 2019. 11. 03..
//  Copyright © 2019. Ács Patrik Tamás. All rights reserved.
//

import Foundation
import RxCocoa

protocol DrivingLicenseInputDataViewModelType {
    var drivingLicenseNumberRelay: BehaviorRelay<String?> { get }
    var drivingLicenseExpirationRelay: BehaviorRelay<String?> { get }
    
    func cancelRegistration()
}

class DrivingLicenseInputDataViewModel: DrivingLicenseInputDataViewModelType {
    
    var drivingLicenseNumberRelay: BehaviorRelay<String?> {
        return registerInteractor.drivingLicenseNumberRelay
    }
    var drivingLicenseExpirationRelay: BehaviorRelay<String?> {
        return registerInteractor.drivingLicenseExpirationRelay
    }
    
    var registerInteractor: RegistratingInteractor!
    
    init(registerInteractor: RegistratingInteractor) {
        self.registerInteractor = registerInteractor
    }
    
    func cancelRegistration() {
            registerInteractor.cancelRegistration()
    }
}
