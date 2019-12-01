//
//  OwnRentImagesViewModel.swift
//  CarRentingApplication
//
//  Created by Ács Patrik on 2019. 12. 01..
//  Copyright © 2019. Ács Patrik Tamás. All rights reserved.
//

import Foundation
import RxSwift

protocol OwnRentImagesViewModelType {
    
    var imageData: Observable<[RentImagesTableViewCellItemViewModel]> { get }
}

class OwnRentImagesViewModel: OwnRentImagesViewModelType {
    
    var imageData: Observable<[RentImagesTableViewCellItemViewModel]>
    
    var sessionManager: SessioningManager!
    var rentsInteractor: RentingInteractor!
    
    init(sessionManager: SessioningManager, rentsInteractor: RentingInteractor) {
        self.sessionManager = sessionManager
        self.rentsInteractor = rentsInteractor
        
        var tempImageData: [RentImagesTableViewCellItemViewModel] = []
        
        for bi in (rentsInteractor.currentRent.imageIdsBefore ?? []) {
            let id = RentImagesTableViewCellItemViewModel(imageId: String(bi), token: sessionManager.token)
            tempImageData.append(id)
        }
        
        for ai in (rentsInteractor.currentRent.imageIdsAfter ?? []) {
            let id = RentImagesTableViewCellItemViewModel(imageId: String(ai), token: sessionManager.token)
            tempImageData.append(id)
        }
        
        self.imageData = Observable.just(tempImageData)
    }
}
