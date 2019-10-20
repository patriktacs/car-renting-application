//
//  ViewAssembly.swift
//  CarRentingApplication
//
//  Created by Ács Patrik on 2019. 10. 18..
//  Copyright © 2019. Ács Patrik Tamás. All rights reserved.
//

import Foundation
import SwinjectAutoregistration
import Swinject

class ViewAssembly: Assembly {
    func assemble(container: Container) {
        container.autoregister(LoginViewModelType.self, initializer: LoginViewModel.init)
        container.storyboardInitCompleted(LoginViewController.self, initCompleted: { r,c in
            c.viewModel = r.resolve(LoginViewModelType.self)!
        })
    }
}
