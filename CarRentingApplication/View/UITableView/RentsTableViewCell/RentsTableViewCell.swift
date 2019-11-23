//
//  RentsTableViewCell.swift
//  CarRentingApplication
//
//  Created by Ács Patrik on 2019. 11. 23..
//  Copyright © 2019. Ács Patrik Tamás. All rights reserved.
//

import UIKit

class RentsTableViewCell: UITableViewCell {
    
    @IBOutlet weak var departureLabel: UILabel!
    @IBOutlet weak var arrivalLabel: UILabel!
    @IBOutlet weak var intervalLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setupData(rent: Rent) {
        self.departureLabel.text = "Departure: " + String(rent.startStationId ?? 0)
        self.arrivalLabel.text = "Arrival: " + String(rent.endStationId ?? 0)
        self.intervalLabel.text = (rent.plannedStartTime ?? "") + " - " + (rent.plannedEndTime ?? "")
    }
}
