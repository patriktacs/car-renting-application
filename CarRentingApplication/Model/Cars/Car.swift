//
//  Car.swift
//  CarRentingApplication
//
//  Created by Ács Patrik on 2019. 11. 10..
//  Copyright © 2019. Ács Patrik Tamás. All rights reserved.
//

import Foundation

struct Car: Codable {
    var cardId: Int?
    var licencePlate: String?
    var currentKm: Int?
    var brand: String?
    var engineType: String?
    var model: String?
    var color: String?
    var state: String?
    var price: Int?
    var station: Station?
}
