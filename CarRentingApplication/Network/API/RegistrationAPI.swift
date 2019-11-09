//
//  RegistrationAPI.swift
//  CarRentingApplication
//
//  Created by Ács Patrik on 2019. 11. 03..
//  Copyright © 2019. Ács Patrik Tamás. All rights reserved.
//

import Foundation
import Moya

enum RegistrationAPI {
    case register(drivingLicenseFront: UIImage, drivingLicenseBack: UIImage, profileImage: UIImage, licenceCardNumber: String, firstName: String, expirationDate: String, lastName: String, emailAddress: String, password: String, phone: String)
}

extension RegistrationAPI: TargetType {
    
    var baseURL: URL {
        switch self {
        case .register:
            return URL(string: "http://ec2-3-14-28-216.us-east-2.compute.amazonaws.com")!
        }
    }
    
    var path: String {
        switch self {
        case .register:
            return "/register"
        }
        
    }
    
    var method: Moya.Method {
        switch self {
        case .register:
            return .post
        }
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var task: Task {
        switch self {
        case .register(let drivingLicenseFront, let drivingLicenseBack, let profileImage, let licenceCardNumber, let firstName, let expirationDate, let lastName, let emailAddress, let password, let phone):
            let frontData = drivingLicenseFront.jpegData(compressionQuality: 0.01) ?? Data()
            let multiFront = MultipartFormData(provider: .data(frontData), name: "DrivingLicenceFront", fileName: emailAddress + "drivingLicenseFront.jpeg", mimeType: "image/jpeg")

            let backData = drivingLicenseBack.jpegData(compressionQuality: 0.01) ?? Data()
            let multiBack = MultipartFormData(provider: .data(backData), name: "DrivingLicenceBack", fileName: emailAddress + "drivingLicenseBack.jpeg", mimeType: "image/jpeg")

            let profileData = profileImage.jpegData(compressionQuality: 0.01) ?? Data()
            let multiProfile = MultipartFormData(provider: .data(profileData), name: "ProfileImage", fileName: emailAddress + "ProfileImage.jpeg", mimeType: "image/jpeg")

            let multiCardNumber = MultipartFormData(provider: .data(licenceCardNumber.data(using: .utf8)!), name: "LicenceCardNumber")
            let multiFirstName = MultipartFormData(provider: .data(firstName.data(using: .utf8)!), name: "FirstName")
            let multiExpirationDate = MultipartFormData(provider: .data(expirationDate.data(using: .utf8)!), name: "ExpirationDate")
            let multiLastName = MultipartFormData(provider: .data(lastName.data(using: .utf8)!), name: "LastName")
            let multiEmail = MultipartFormData(provider: .data(emailAddress.data(using: .utf8)!), name: "EmailAddress")
            let multiPassword = MultipartFormData(provider: .data(password.data(using: .utf8)!), name: "Password")
            let multiPhone = MultipartFormData(provider: .data(phone.data(using: .utf8)!), name: "Phone")

            return .uploadMultipart([multiFront, multiBack, multiProfile, multiCardNumber, multiFirstName, multiExpirationDate, multiLastName, multiEmail, multiPassword, multiPhone])
        }
    }
    
    var headers: [String : String]? {
        return ["Content-Type": "multipart/form-data"]
    }
}
