//
//  LoginViewModel.swift
//  CarRentingApplication
//
//  Created by Ács Patrik on 2019. 10. 20..
//  Copyright © 2019. Ács Patrik Tamás. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import Moya

protocol LoginViewModelType {
    var usernameRelay: BehaviorRelay<String?> { get }
    var passwordRelay: BehaviorRelay<String?> { get }
    
    func killSession()
    func login() -> Single<Response>
}

class LoginViewModel: LoginViewModelType {
    var usernameRelay: BehaviorRelay<String?> {
        return sessionManager.usernameRelay
    }
    
    var passwordRelay: BehaviorRelay<String?> {
        return sessionManager.passwordRelay
    }
    
    var sessionManager: SessioningManager!
    
    init(sessionManager: SessioningManager) {
        self.sessionManager = sessionManager
    }
    
    func killSession() {
        sessionManager.killSession()
    }
    
    func login() -> Single<Response> {
        return sessionManager.login()
    }
}
