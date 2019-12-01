//
//  RentsTableViewCellItemViewModel.swift
//  CarRentingApplication
//
//  Created by Ács Patrik on 2019. 11. 23..
//  Copyright © 2019. Ács Patrik Tamás. All rights reserved.
//

import Foundation

class RentsTableViewCellItemViewModel {
    
    var startStationName: String
    var endStationName: String
    var plannedStartTime: String
    var plannedEndTime: String
    var isMine: Bool
    
    init(rent: Rent) {
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "yyyy-MM-dd'T'HH:mm"

        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.dateFormat = "yyyy MMM dd"
        
        self.startStationName = rent.startStationName ?? ""
        self.endStationName = rent.endStationName ?? ""
        
        self.plannedStartTime = (rent.actualStartTime?.isEmpty ?? true) ? dateFormatterPrint.string(from: dateFormatterGet.date(from: rent.plannedStartTime ?? "") ?? Date()) : dateFormatterPrint.string(from: dateFormatterGet.date(from: rent.actualStartTime ?? "") ?? Date())
        self.plannedEndTime = (rent.actualEndTime?.isEmpty ?? true) ? dateFormatterPrint.string(from: dateFormatterGet.date(from: rent.plannedEndTime ?? "") ?? Date()) : dateFormatterPrint.string(from: dateFormatterGet.date(from: rent.actualEndTime ?? "") ?? Date())
        self.isMine = rent.mine ?? false
    }
}
