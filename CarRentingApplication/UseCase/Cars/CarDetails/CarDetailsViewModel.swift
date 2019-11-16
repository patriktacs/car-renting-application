//
//  CarDetailsViewModel.swift
//  CarRentingApplication
//
//  Created by Ács Patrik on 2019. 11. 16..
//  Copyright © 2019. Ács Patrik Tamás. All rights reserved.
//

import Foundation

protocol CarDetailsViewModelType {
    
    var title: String { get }
    var color: String { get }
    var currentKm: String { get }
    var licensePlate: String { get }
    var price: String { get }
    var engineType: String { get }
    var longitude: Double { get }
    var latitude: Double { get }
}

class CarDetailsViewModel: CarDetailsViewModelType {
    
    var title: String
    var color: String
    var currentKm: String
    var licensePlate: String
    var price: String
    var engineType: String
    var longitude: Double
    var latitude: Double
    
    var carsInteractor: CarInteractor!
    
    init(carsInteractor: CarInteractor) {
        self.carsInteractor = carsInteractor
        
        self.title = (carsInteractor.currentCar.brand ?? "") + " " + (carsInteractor.currentCar.model ?? "")
        self.color = carsInteractor.currentCar.color ?? ""
        self.currentKm = String(carsInteractor.currentCar.currentKm ?? 0) + " Km"
        self.licensePlate = carsInteractor.currentCar.licencePlate ?? ""
        self.price = String(carsInteractor.currentCar.price ?? 0) + " Ft. / day"
        self.engineType = carsInteractor.currentCar.engineType?.lowercased() ?? "unknown"
        self.longitude = carsInteractor.currentCar.station?.longitude ?? 0.0
        self.latitude = carsInteractor.currentCar.station?.latitude ?? 0.0
    }
}
