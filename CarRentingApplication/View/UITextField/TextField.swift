//
//  TextField.swift
//  CarRentingApplication
//
//  Created by Ács Patrik on 2019. 11. 03..
//  Copyright © 2019. Ács Patrik Tamás. All rights reserved.
//

import UIKit

class TextField: UITextField {
    
    func setupData(placeholder: String, secureTextEntry: Bool? = false) {
        self.placeholder = placeholder
        self.isSecureTextEntry = secureTextEntry!
    }
    
    override var intrinsicContentSize: CGSize {
        return CGSize(width: frame.width, height: 40.0)
    }
}
