//
//  CarsTableViewCell.swift
//  CarRentingApplication
//
//  Created by Ács Patrik on 2019. 11. 10..
//  Copyright © 2019. Ács Patrik Tamás. All rights reserved.
//

import UIKit

class CarsTableViewCell: UITableViewCell {
    
    @IBOutlet weak var engineTypeImage: UIImageView!
    @IBOutlet weak var modelTypeLabel: UILabel!
    @IBOutlet weak var colorLabel: UILabel!
    @IBOutlet weak var distanceLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setupData(_ data: CarsTableViewCellItemViewModel) {
        engineTypeImage.image = UIImage(named: "electric")
        modelTypeLabel.text = (data.brand ?? "") + " " + (data.model ?? "")
        colorLabel.text = data.color ?? ""
        distanceLabel.text = String(data.currentKm ?? 0) + " Km"
    }
    
    override var intrinsicContentSize: CGSize {
        return CGSize(width: frame.width, height: 80.0)
    }
}
