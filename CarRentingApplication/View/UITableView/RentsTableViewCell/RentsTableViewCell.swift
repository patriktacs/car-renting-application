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
    
    func setupData(rent: RentsTableViewCellItemViewModel) {
        self.departureLabel.text = "Departure: " + rent.startStationName
        self.arrivalLabel.text = "Arrival: " + rent.endStationName
        self.intervalLabel.text = rent.plannedStartTime + " - " + rent.plannedEndTime
        
        if rent.isMine {
            self.backgroundView?.backgroundColor = .green
        }
        
        self.selectionStyle = .none
    }
}
