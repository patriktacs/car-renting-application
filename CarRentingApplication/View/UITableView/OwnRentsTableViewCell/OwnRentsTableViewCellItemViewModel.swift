//
//  OwnRentsTableViewCellItemViewModel.swift
//  CarRentingApplication
//
//  Created by Ács Patrik on 2019. 11. 24..
//  Copyright © 2019. Ács Patrik Tamás. All rights reserved.
//

import Foundation

class OwnRentsTableViewCellItemViewModel {
    
    var startStationId: Int
    var startTime: String
    var endTime: String
    var status: String?
    
    init(rent: Rent) {
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "yyyy-MM-dd'T'HH:mm"

        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.dateFormat = "yyyy MMM dd"
        
        self.startStationId = rent.startStationId ?? 0
        
        self.startTime = (rent.actualStartTime?.isEmpty ?? true) ? dateFormatterPrint.string(from: dateFormatterGet.date(from: rent.plannedStartTime ?? "") ?? Date()) : dateFormatterPrint.string(from: dateFormatterGet.date(from: rent.actualStartTime ?? "") ?? Date())
        self.endTime = (rent.actualEndTime?.isEmpty ?? true) ? dateFormatterPrint.string(from: dateFormatterGet.date(from: rent.plannedEndTime ?? "") ?? Date()) : dateFormatterPrint.string(from: dateFormatterGet.date(from: rent.actualEndTime ?? "") ?? Date())
        
        self.status = rent.state
    }
}
