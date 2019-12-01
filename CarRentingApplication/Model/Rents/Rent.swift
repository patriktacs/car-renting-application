//
//  Rent.swift
//  CarRentingApplication
//
//  Created by Ács Patrik on 2019. 11. 23..
//  Copyright © 2019. Ács Patrik Tamás. All rights reserved.
//

import Foundation

struct Rent: Codable {
    var rentId: Int?
    var carId: Int?
    var plannedStartTime: String?
    var plannedEndTime: String?
    var startStationId: Int?
    var startStationName: String?
    var endStationId: Int?
    var endStationName: String?
    var actualStartTime: String?
    var actualEndTime: String?
    var state: String?
    var mine: Bool?
    var imageIdsBefore: [Int]?
    var imageIdsAfter: [Int]?
    var positionReportRequested: Bool?
}
