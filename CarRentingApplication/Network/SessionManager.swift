//
//  SessionManager.swift
//  CarRentingApplication
//
//  Created by Ács Patrik on 2019. 10. 20..
//  Copyright © 2019. Ács Patrik Tamás. All rights reserved.
//

import Foundation
import Moya
import RxSwift
import RxCocoa

protocol SessioningManager {
    var usernameRelay: BehaviorRelay<String?> { get }
    var passwordRelay: BehaviorRelay<String?> { get }
    
    var username: String { get }
    var password: String { get }
    var sessionStatus: Bool { get }
    
    func killSession()
    func login() -> Single<Response>
}

class SessionManager: SessioningManager {
    var usernameRelay: BehaviorRelay<String?> = BehaviorRelay<String?>(value: "")
    var passwordRelay: BehaviorRelay<String?> = BehaviorRelay<String?>(value: "")
    
    private let usernameKey = "username"
    var username: String {
        return persistencyManager.getString(forKey: usernameKey)
    }
    
    private let passwordKey = "password"
    var password: String {
        return persistencyManager.getString(forKey: passwordKey)
    }
    
    private let sessionStatusKey = "sessionStatus"
    var sessionStatus: Bool {
        return persistencyManager.getBool(forKey: sessionStatusKey)
    }
    
    let networkManager: NetworkingManager!
    let persistencyManager: PersistingManager!
    
    init(networkManager: NetworkingManager, persistencyManager: PersistingManager) {
        self.networkManager = networkManager
        self.persistencyManager = persistencyManager
    }
    
    func setupSession() {
        persistencyManager.setData(set: usernameRelay.value, forKey: usernameKey)
        persistencyManager.setData(set: passwordRelay.value, forKey: passwordKey)
        persistencyManager.setData(set: true, forKey: sessionStatusKey)
    }
    
    func killSession() {
        persistencyManager.removeData(forKey: usernameKey)
        persistencyManager.removeData(forKey: passwordKey)
        persistencyManager.removeData(forKey: sessionStatusKey)
    }
    
    func login() -> Single<Response> {
        return networkManager.provider.rx.request(MultiTarget(LoginAPI.login(username: (usernameRelay.value ?? ""), password: (passwordRelay.value ?? ""))))
            .do(onSuccess: { _ in
                self.setupSession()
            })
    }
}
