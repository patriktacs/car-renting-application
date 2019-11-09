//
//  DrivingLicenseBackUploadViewModel.swift
//  CarRentingApplication
//
//  Created by Ács Patrik on 2019. 11. 03..
//  Copyright © 2019. Ács Patrik Tamás. All rights reserved.
//

import Foundation
import UIKit

protocol DrivingLicenseBackUploadViewModelType {
    
    func setImage(image: UIImage)
    func cancelRegistration()
}

class DrivingLicenseBackUploadViewModel: DrivingLicenseBackUploadViewModelType {
    
    var registerInteractor: RegistratingInteractor!
    
    init(registerInteractor: RegistratingInteractor) {
        self.registerInteractor = registerInteractor
    }
    
    func setImage(image: UIImage) {
        registerInteractor.setDrivingLicenceBackImage(image: image)
    }
    
    func cancelRegistration() {
        registerInteractor.cancelRegistration()
    }
}
