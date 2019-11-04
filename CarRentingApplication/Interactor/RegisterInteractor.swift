//
//  RegisterInteractor.swift
//  CarRentingApplication
//
//  Created by Ács Patrik on 2019. 11. 03..
//  Copyright © 2019. Ács Patrik Tamás. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import Moya

protocol RegistratingInteractor {
    
    var emailRelay: BehaviorRelay<String?> { get }
    var passwordRelay: BehaviorRelay<String?> { get }
    var firstNameRelay: BehaviorRelay<String?> { get }
    var lastNameRelay: BehaviorRelay<String?> { get }
    var phoneNumberRelay: BehaviorRelay<String?> { get }
    var drivingLicenseNumberRelay: BehaviorRelay<String?> { get }
    var drivingLicenseExpirationRelay: BehaviorRelay<String?> { get }
    
    func setDrivingLicenceFrontImage(image: UIImage)
    func setDrivingLicenceBackImage(image: UIImage)
    func setProfileImage(image: UIImage)
    func cancelRegistration()
    func register() -> Single<Response>
}

class RegisterInteractor: RegistratingInteractor {
    
    var emailRelay = BehaviorRelay<String?>(value: "")
    var passwordRelay = BehaviorRelay<String?>(value: "")
    var firstNameRelay = BehaviorRelay<String?>(value: "")
    var lastNameRelay = BehaviorRelay<String?>(value: "")
    var phoneNumberRelay = BehaviorRelay<String?>(value: "")
    var drivingLicenseNumberRelay = BehaviorRelay<String?>(value: "")
    var drivingLicenseExpirationRelay = BehaviorRelay<String?>(value: "")
    
    var drivingLicenseFrontImage: UIImage!
    var drivingLicenseBackImage: UIImage!
    var profileImage: UIImage!
    
    var networkManager: NetworkingManager!
    
    init(networkManager: NetworkingManager) {
        self.networkManager = networkManager
    }
    
    func setDrivingLicenceFrontImage(image: UIImage) {
        drivingLicenseFrontImage = image
    }
    
    func setDrivingLicenceBackImage(image: UIImage) {
        drivingLicenseBackImage = image
    }
    
    func setProfileImage(image: UIImage) {
        profileImage = image
    }
    
    func cancelRegistration() {
        emailRelay.accept("")
        passwordRelay.accept("")
        firstNameRelay.accept("")
        lastNameRelay.accept("")
        phoneNumberRelay.accept("")
        drivingLicenseNumberRelay.accept("")
        drivingLicenseExpirationRelay.accept("")
        drivingLicenseFrontImage = nil
        drivingLicenseBackImage = nil
        profileImage = nil
    }
    
    func register() -> Single<Response> {
        return networkManager.provider.rx.request(MultiTarget(RegistrationAPI.register(drivingLicenseFront: drivingLicenseFrontImage, drivingLicenseBack: drivingLicenseBackImage, profileImage: profileImage, licenceCardNumber: drivingLicenseNumberRelay.value ?? "", firstName: firstNameRelay.value ?? "", expirationDate: drivingLicenseExpirationRelay.value ?? "", lastName: lastNameRelay.value ?? "", emailAddress: emailRelay.value ?? "", password: passwordRelay.value ?? "", phone: phoneNumberRelay.value ?? "")))
        .filterSuccessfulStatusCodes()
    }
}
