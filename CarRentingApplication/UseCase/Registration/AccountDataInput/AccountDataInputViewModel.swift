//
//  AccountDataInputViewModel.swift
//  CarRentingApplication
//
//  Created by Ács Patrik on 2019. 10. 25..
//  Copyright © 2019. Ács Patrik Tamás. All rights reserved.
//

import Foundation
import RxCocoa

protocol AccountDataInputViewModelType {
    
    var emailRelay: BehaviorRelay<String?> { get }
    var passwordRelay: BehaviorRelay<String?> { get }
    
    func cancelRegistration()
}

class AccountDataInputViewModel: AccountDataInputViewModelType {
    
    var emailRelay: BehaviorRelay<String?> {
        return registerInteractor.emailRelay
    }
    var passwordRelay: BehaviorRelay<String?> {
        return registerInteractor.passwordRelay
    }
    
    var registerInteractor: RegistratingInteractor!
    
    init(registerInteractor: RegistratingInteractor) {
        self.registerInteractor = registerInteractor
    }
    
    func cancelRegistration() {
        registerInteractor.cancelRegistration()
    }
}
