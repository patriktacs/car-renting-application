//
//  ProfileImageUploadViewModel.swift
//  CarRentingApplication
//
//  Created by Ács Patrik on 2019. 11. 03..
//  Copyright © 2019. Ács Patrik Tamás. All rights reserved.
//

import Foundation
import UIKit
import RxSwift
import Moya

protocol ProfileImageUploadViewModelType {
    
    func setImage(image: UIImage)
    func register() -> Single<Response>
    func cancelRegistration()
}

class ProfileImageUploadViewModel: ProfileImageUploadViewModelType {
    
    var registerInteractor: RegistratingInteractor!
    
    init(registerInteractor: RegistratingInteractor) {
        self.registerInteractor = registerInteractor
    }
    
    func setImage(image: UIImage) {
        registerInteractor.setProfileImage(image: image)
    }
    
    func register() -> Single<Response> {
        registerInteractor.register()
    }
    
    func cancelRegistration() {
        registerInteractor.cancelRegistration()
    }
}
