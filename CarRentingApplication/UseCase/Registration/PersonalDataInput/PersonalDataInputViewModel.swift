//
//  PersonalDataInputViewModel.swift
//  CarRentingApplication
//
//  Created by Ács Patrik on 2019. 11. 03..
//  Copyright © 2019. Ács Patrik Tamás. All rights reserved.
//

import Foundation
import RxCocoa

protocol PersonalDataInputViewModelType {
    
    var firstNameRelay: BehaviorRelay<String?> { get }
    var lastNameRelay: BehaviorRelay<String?> { get }
    var phoneNumberRelay: BehaviorRelay<String?> { get }
    
    func cancelRegistration()
}

class PersonalDataInputViewModel: PersonalDataInputViewModelType {
    
    var firstNameRelay: BehaviorRelay<String?> {
        return registerInteractor.firstNameRelay
    }
    var lastNameRelay: BehaviorRelay<String?> {
        return registerInteractor.lastNameRelay
    }
    var phoneNumberRelay: BehaviorRelay<String?> {
        return registerInteractor.phoneNumberRelay
    }
    
    var registerInteractor: RegistratingInteractor!
    
    init(registerInteractor: RegistratingInteractor) {
        self.registerInteractor = registerInteractor
    }
    
    func cancelRegistration() {
        registerInteractor.cancelRegistration()
    }
}
