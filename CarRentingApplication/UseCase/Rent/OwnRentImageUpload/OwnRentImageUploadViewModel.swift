//
//  OwnRentImageUploadViewModel.swift
//  CarRentingApplication
//
//  Created by Ács Patrik on 2019. 12. 01..
//  Copyright © 2019. Ács Patrik Tamás. All rights reserved.
//

import Foundation
import UIKit
import RxSwift
import Moya

protocol OwnRentImageUploadViewModelType {
    
    func setImage(image: UIImage)
    func uploadImage() -> Single<Response>
}

class OwnRentImageUploadViewModel: OwnRentImageUploadViewModelType {
    
    
    var rentsInteractor: RentingInteractor!
    
    init(rentsInteractor: RentingInteractor) {
        self.rentsInteractor = rentsInteractor
    }
    
    func setImage(image: UIImage) {
        self.rentsInteractor.setImage(image: image)
    }
    
    func uploadImage() -> Single<Response> {
        if self.rentsInteractor.currentRent.state == "RESERVED" {
            return self.rentsInteractor.uploadBefore()
        } else {
            return self.rentsInteractor.uploadAfter()
        }
    }
}
