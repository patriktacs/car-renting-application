//
//  DrivingLicenseFrontUploadViewModel.swift
//  CarRentingApplication
//
//  Created by Ács Patrik on 2019. 11. 03..
//  Copyright © 2019. Ács Patrik Tamás. All rights reserved.
//

import Foundation
import UIKit

protocol DrivingLicenseFrontUploadViewModelType {
    
    func setImage(image: UIImage)
}

class DrivingLicenseFrontUploadViewModel: DrivingLicenseFrontUploadViewModelType {
    
    var registerInteractor: RegistratingInteractor!
    
    init(registerInteractor: RegistratingInteractor) {
        self.registerInteractor = registerInteractor
    }
    
    func setImage(image: UIImage) {
        registerInteractor.setDrivingLicenceFrontImage(image: image)
    }
}

