//
//  Button.swift
//  CarRentingApplication
//
//  Created by Ács Patrik on 2019. 11. 03..
//  Copyright © 2019. Ács Patrik Tamás. All rights reserved.
//

import UIKit

class Button: UIButton {

    func setupData(title: String) {
        self.setTitle(title, for: .normal)
        setupStyle()
    }
    
    func setupStyle() {
        self.tintColor = .white
        self.backgroundColor = .gray
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func draw(_ rect: CGRect) {
        self.layoutIfNeeded()
        self.setNeedsLayout()
        super.draw(rect)
    }
    
    
    override var intrinsicContentSize: CGSize {
        return CGSize(width: frame.width, height: 40.0)
    }
}

class UrlButton: Button {
    
    override func setupStyle() {
        self.tintColor = .blue
        self.backgroundColor = .clear
    }
}
