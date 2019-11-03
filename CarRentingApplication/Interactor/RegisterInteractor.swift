//
//  RegisterInteractor.swift
//  CarRentingApplication
//
//  Created by Ács Patrik on 2019. 11. 03..
//  Copyright © 2019. Ács Patrik Tamás. All rights reserved.
//

import Foundation
import RxCocoa

protocol RegistratingInteractor {
    
    var emailRelay: BehaviorRelay<String?> { get }
    var passwordRelay: BehaviorRelay<String?> { get }
    var firstNameRelay: BehaviorRelay<String?> { get }
    var lastNameRelay: BehaviorRelay<String?> { get }
    var phoneNumberRelay: BehaviorRelay<String?> { get }
    var drivingLicenseNumberRelay: BehaviorRelay<String?> { get }
    var drivingLicenseExpirationRelay: BehaviorRelay<String?> { get }
    
    func cancelRegistration()
}

class RegisterInteractor: RegistratingInteractor {
    
    var emailRelay = BehaviorRelay<String?>(value: "")
    var passwordRelay = BehaviorRelay<String?>(value: "")
    var firstNameRelay = BehaviorRelay<String?>(value: "")
    var lastNameRelay = BehaviorRelay<String?>(value: "")
    var phoneNumberRelay = BehaviorRelay<String?>(value: "")
    var drivingLicenseNumberRelay = BehaviorRelay<String?>(value: "")
    var drivingLicenseExpirationRelay = BehaviorRelay<String?>(value: "")
    
    func cancelRegistration() {
        emailRelay.accept("")
        passwordRelay.accept("")
        firstNameRelay.accept("")
        lastNameRelay.accept("")
        phoneNumberRelay.accept("")
        drivingLicenseNumberRelay.accept("")
        drivingLicenseExpirationRelay.accept("")
    }
}
