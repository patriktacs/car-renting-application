//
//  OwnRentsTableViewCell.swift
//  CarRentingApplication
//
//  Created by Ács Patrik on 2019. 11. 24..
//  Copyright © 2019. Ács Patrik Tamás. All rights reserved.
//

import UIKit

class OwnRentsTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var statusImageView: UIImageView!
    @IBOutlet weak var carLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setupData(_ data: OwnRentsTableViewCellItemViewModel) {
        statusImageView.image = UIImage(named: data.status?.lowercased() ?? "unknown")
        carLabel.text = "Station: " + String(data.startStationId)
        timeLabel.text = data.startTime + " - " + data.endTime
        
        self.selectionStyle = .none
    }
    
}
