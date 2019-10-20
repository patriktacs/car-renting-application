//
//  Notifiable.swift
//  CarRentingApplication
//
//  Created by Ács Patrik on 2019. 10. 20..
//  Copyright © 2019. Ács Patrik Tamás. All rights reserved.
//

import Foundation
import UIKit

protocol Notifiable: class {
    func showNotification(_ title: String, _ message: String)
}

extension Notifiable where Self: UIViewController {
    func showNotification(_ title: String, _ message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .actionSheet)
        
        alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
        
        self.present(alert, animated: true)
    }
}
