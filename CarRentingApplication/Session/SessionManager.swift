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
    
    var token: String { get }
    var sessionStatus: Bool { get }
    
    func killSession()
    func login() -> Single<Response>
}

class SessionManager: SessioningManager {
    var usernameRelay: BehaviorRelay<String?> = BehaviorRelay<String?>(value: "")
    var passwordRelay: BehaviorRelay<String?> = BehaviorRelay<String?>(value: "")
    
    private let tokenKey = "32d7f64f3efd831c2f5df9c7c192bfc9"
    var token: String {
        return persistencyManager.getString(forKey: tokenKey)
    }
    
    private let sessionStatusKey = "5f78214f2d13384246b264637b11a82d"
    var sessionStatus: Bool {
        return persistencyManager.getBool(forKey: sessionStatusKey)
    }
    
    let networkManager: NetworkingManager!
    let persistencyManager: PersistingManager!
    
    init(networkManager: NetworkingManager, persistencyManager: PersistingManager) {
        self.networkManager = networkManager
        self.persistencyManager = persistencyManager
    }
    
    func setupSession(token: String) {
        persistencyManager.setData(set: token, forKey: tokenKey)
        persistencyManager.setData(set: true, forKey: sessionStatusKey)
    }
    
    func killSession() {
        persistencyManager.removeData(forKey: tokenKey)
        persistencyManager.setData(set: false, forKey: sessionStatusKey)
    }
    
    func login() -> Single<Response> {
        let token = Data(((usernameRelay.value ?? "") + ":" + (passwordRelay.value ?? "")).utf8).base64EncodedString()
        return networkManager.provider.rx.request(MultiTarget(LoginAPI.login(token: token)))
            .filterSuccessfulStatusCodes()
            .do(onSuccess: { _ in
                self.setupSession(token: token)
            }, onError: { _ in
                self.passwordRelay.accept("")
                self.killSession()
            })
    }
}
