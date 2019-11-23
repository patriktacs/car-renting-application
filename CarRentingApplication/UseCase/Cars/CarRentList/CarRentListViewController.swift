//
//  CarRentListViewController.swift
//  CarRentingApplication
//
//  Created by Ács Patrik on 2019. 11. 23..
//  Copyright © 2019. Ács Patrik Tamás. All rights reserved.
//

import UIKit

class CarRentListViewController: UIViewController {
    
    @IBOutlet weak var rentListTableView: UITableView!
    
    var viewModel: CarRentListViewModelType!

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
    }

}
