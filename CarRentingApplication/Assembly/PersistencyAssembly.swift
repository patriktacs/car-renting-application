//
//  PersistencyAssembly.swift
//  CarRentingApplication
//
//  Created by Ács Patrik on 2019. 10. 20..
//  Copyright © 2019. Ács Patrik Tamás. All rights reserved.
//

import Foundation
import Swinject
import SwinjectAutoregistration

class PersistencyAssembly: Assembly {
    func assemble(container: Container) {
        container.autoregister(PersistingManager.self, initializer: PersistencyManager.init).inObjectScope(.container)
        container.autoregister(SessioningManager.self, initializer: SessionManager.init).inObjectScope(.container)
    }
}
