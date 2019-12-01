//
//  RentImagesTableViewCell.swift
//  CarRentingApplication
//
//  Created by Ács Patrik on 2019. 12. 01..
//  Copyright © 2019. Ács Patrik Tamás. All rights reserved.
//

import UIKit
import Moya

class RentImagesTableViewCell: UITableViewCell {
    
    @IBOutlet weak var rentImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setupData(imageData: RentImagesTableViewCellItemViewModel) {
        let provider = MoyaProvider<RentsAPI>()
        
        provider.request(.getImage(token: imageData.token, imageId: imageData.imageId)) { result in
            switch result {
            case let .success(moyaResponse):
                let data = moyaResponse.data
                self.rentImageView.image = UIImage(data: data)
            case .failure:
                self.rentImageView.image = UIImage(named: "unknown")
            }
        }
    }
}
