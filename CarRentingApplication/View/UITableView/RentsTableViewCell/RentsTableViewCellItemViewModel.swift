//
//  RentsTableViewCellItemViewModel.swift
//  CarRentingApplication
//
//  Created by Ács Patrik on 2019. 11. 23..
//  Copyright © 2019. Ács Patrik Tamás. All rights reserved.
//

import Foundation

class RentsTableViewCellItemViewModel {
    
    var startStationId: Int
    var endStationId: Int
    var plannedStartTime: String
    var plannedEndTime: String
    var isMine: Bool
    
    init(rent: Rent) {
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "yyyy-MM-dd'T'HH:mm"

        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.dateFormat = "yyyy MMM dd"
        
        self.startStationId = rent.startStationId ?? 0
        self.endStationId = rent.endStationId ?? 0
        
        self.plannedStartTime = dateFormatterPrint.string(from: dateFormatterGet.date(from: rent.plannedStartTime ?? "") ?? Date())
        self.plannedEndTime = dateFormatterPrint.string(from: dateFormatterGet.date(from: rent.plannedEndTime ?? "") ?? Date())
        self.isMine = rent.mine ?? false
    }
}
