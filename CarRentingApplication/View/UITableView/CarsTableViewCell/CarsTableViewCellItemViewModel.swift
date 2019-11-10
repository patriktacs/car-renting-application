//
//  CarsTableViewCellItemViewModel.swift
//  CarRentingApplication
//
//  Created by Ács Patrik on 2019. 11. 10..
//  Copyright © 2019. Ács Patrik Tamás. All rights reserved.
//

import Foundation

struct CarsTableViewCellItemViewModel {
    var cardId: Int?
    var currentKm: Int?
    var brand: String?
    var engineType: String?
    var model: String?
    var color: String?
    
    init(car: Car) {
        cardId = car.cardId
        currentKm = car.distanceTravelled
        brand = car.brand
        engineType = car.enginType
        model = car.model
        color = car.color
    }
}
