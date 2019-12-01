//
//  RentData.swift
//  CarRentingApplication
//
//  Created by Ács Patrik on 2019. 12. 01..
//  Copyright © 2019. Ács Patrik Tamás. All rights reserved.
//

import Foundation
import UIKit

struct RentData {
    
    var rentStatus: String
    var carId: String
    var startDate: String
    var endDate: String
    var startStationName: String
    var endStationName: String
    var firstButtonTitle: String
    var cancelButtonTitle: String
    var isUploadAvailable: Bool
    var isCancelAvailable: Bool
    var isFirstButtonAvailable: Bool
    var isStarted: Bool
    
    init(rent: Rent) {
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "yyyy-MM-dd'T'HH:mm"
        
        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.dateFormat = "yyyy MMM dd"
        
        self.rentStatus = rent.state?.lowercased() ?? "unknown"
        self.carId = String(rent.carId ?? 0)
        self.startDate = (rent.actualStartTime?.isEmpty ?? true) ? dateFormatterPrint.string(from: dateFormatterGet.date(from: rent.plannedStartTime ?? "") ?? Date()) : dateFormatterPrint.string(from: dateFormatterGet.date(from: rent.actualStartTime ?? "") ?? Date())
        self.endDate = (rent.actualEndTime?.isEmpty ?? true) ? dateFormatterPrint.string(from: dateFormatterGet.date(from: rent.plannedEndTime ?? "") ?? Date()) : dateFormatterPrint.string(from: dateFormatterGet.date(from: rent.actualEndTime ?? "") ?? Date())
        self.startStationName = rent.startStationName ?? ""
        self.endStationName = rent.endStationName ?? ""
        self.firstButtonTitle = rent.state == "RESERVED" ? "Start rent" : "Finish rent"
        self.cancelButtonTitle = "Cancel rent"
        self.isUploadAvailable = rent.state == "RESERVED" || rent.state == "UNCLOSED"
        self.isCancelAvailable = !(rent.state == "RESERVED")
        self.isFirstButtonAvailable = rent.state == "UNCLOSED" ||  rent.state == "DONE"
        self.isStarted = !(rent.state == "RESERVED")
    }
}
