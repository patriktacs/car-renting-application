//
//  InteractorAssembly.swift
//  CarRentingApplication
//
//  Created by Ács Patrik on 2019. 10. 18..
//  Copyright © 2019. Ács Patrik Tamás. All rights reserved.
//

import Foundation
import Swinject

class InteractorAssembly: Assembly {
    
    func assemble(container: Container) {
        container.autoregister(RegistratingInteractor.self, initializer: RegisterInteractor.init).inObjectScope(.container)
        container.autoregister(CarInteractor.self, initializer: CarsInteractor.init).inObjectScope(.container)
        container.autoregister(RentingInteractor.self, initializer: RentsInteractor.init).inObjectScope(.container)
    }
}
