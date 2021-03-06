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
        
        container.autoregister(AccountDataInputViewModelType.self, initializer: AccountDataInputViewModel.init)
        container.storyboardInitCompleted(AccountDataInputViewController.self, initCompleted: { r,c in
            c.viewModel = r.resolve(AccountDataInputViewModelType.self)!
        })
        
        container.autoregister(PersonalDataInputViewModelType.self, initializer: PersonalDataInputViewModel.init)
        container.storyboardInitCompleted(PersonalDataInputViewController.self, initCompleted: { r,c in
            c.viewModel = r.resolve(PersonalDataInputViewModelType.self)!
        })
        
        container.autoregister(DrivingLicenseInputDataViewModelType.self, initializer: DrivingLicenseInputDataViewModel.init)
        container.storyboardInitCompleted(DrivingLicenseInputDataViewController.self, initCompleted: { r,c in
            c.viewModel = r.resolve(DrivingLicenseInputDataViewModelType.self)!
        })
        
        container.autoregister(DrivingLicenseFrontUploadViewModelType.self, initializer: DrivingLicenseFrontUploadViewModel.init)
        container.storyboardInitCompleted(DrivingLicenseFrontUploadViewController.self, initCompleted: { r,c in
            c.viewModel = r.resolve(DrivingLicenseFrontUploadViewModelType.self)!
        })
        
        container.autoregister(DrivingLicenseBackUploadViewModelType.self, initializer: DrivingLicenseBackUploadViewModel.init)
        container.storyboardInitCompleted(DrivingLicenseBackUploadViewController.self, initCompleted: { r,c in
            c.viewModel = r.resolve(DrivingLicenseBackUploadViewModelType.self)!
        })
        
        container.autoregister(ProfileImageUploadViewModelType.self, initializer: ProfileImageUploadViewModel.init)
        container.storyboardInitCompleted(ProfileImageUploadViewController.self, initCompleted: { r,c in
            c.viewModel = r.resolve(ProfileImageUploadViewModelType.self)!
        })
        
        container.autoregister(CarListViewModelType.self, initializer: CarListViewModel.init)
        container.storyboardInitCompleted(CarListViewController.self, initCompleted: { r,c in
            c.viewModel = r.resolve(CarListViewModelType.self)!
        })
        
        container.autoregister(CarDetailsViewModelType.self, initializer: CarDetailsViewModel.init)
        container.storyboardInitCompleted(CarDetailsViewController.self, initCompleted: { r,c in
            c.viewModel = r.resolve(CarDetailsViewModelType.self)!
        })
        
        container.autoregister(CarRentListViewModelType.self, initializer: CarRentListViewModel.init)
        container.storyboardInitCompleted(CarRentListViewController.self, initCompleted: { r,c in
            c.viewModel = r.resolve(CarRentListViewModelType.self)!
        })
        
        container.autoregister(RentCarViewModelType.self, initializer: RentCarViewModel.init)
        container.storyboardInitCompleted(RentCarViewController.self, initCompleted: { r,c in
            c.viewModel = r.resolve(RentCarViewModelType.self)!
        })
        
        container.autoregister(OwnRentsViewModelType.self, initializer: OwnRentsViewModel.init)
        container.storyboardInitCompleted(OwnRentsViewController.self, initCompleted: { r,c in
            c.viewModel = r.resolve(OwnRentsViewModelType.self)!
        })
        
        container.autoregister(OwnRentDetailsViewModelType.self, initializer: OwnRentDetailsViewModel.init)
        container.storyboardInitCompleted(OwnRentDetailsViewController.self, initCompleted: { r,c in
            c.viewModel = r.resolve(OwnRentDetailsViewModelType.self)!
        })
        
        container.autoregister(PositionProviderViewModelType.self, initializer: PositionProviderViewModel.init)
        container.storyboardInitCompleted(PositionProviderViewController.self, initCompleted: { r,c in
            c.viewModel = r.resolve(PositionProviderViewModelType.self)!
        })
        
        container.autoregister(OwnRentImageUploadViewModelType.self, initializer: OwnRentImageUploadViewModel.init)
        container.storyboardInitCompleted(OwnRentImageUploadViewController.self, initCompleted: { r,c in
            c.viewModel = r.resolve(OwnRentImageUploadViewModelType.self)!
        })
        
        container.autoregister(OwnRentImagesViewModelType.self, initializer: OwnRentImagesViewModel.init)
        container.storyboardInitCompleted(OwnRentImagesViewController.self, initCompleted: { r,c in
            c.viewModel = r.resolve(OwnRentImagesViewModelType.self)!
        })
    }
}
