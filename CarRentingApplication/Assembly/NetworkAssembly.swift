//
//  NetworkAssembly.swift
//  CarRentingApplication
//
//  Created by Ács Patrik on 2019. 10. 18..
//  Copyright © 2019. Ács Patrik Tamás. All rights reserved.
//

import Foundation
import Swinject
import SwinjectAutoregistration

class NetworkAssembly: Assembly {
    func assemble(container: Container) {
        container.autoregister(NetworkingConfig.self, initializer: NetworkConfig.init).inObjectScope(.container)
        container.autoregister(NetworkingManager.self, initializer: NetworkManager.init).inObjectScope(.container)
    }
}
