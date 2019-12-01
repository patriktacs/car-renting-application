//
//  OwnRentImagesViewController.swift
//  CarRentingApplication
//
//  Created by Ács Patrik on 2019. 12. 01..
//  Copyright © 2019. Ács Patrik Tamás. All rights reserved.
//

import UIKit
import RxSwift

class OwnRentImagesViewController: UIViewController {
    
    @IBOutlet weak var imagesTableView: UITableView!
    
    var viewModel: OwnRentImagesViewModelType!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTableView()
        setupCell()
        
        viewModel.imageData
            .bind(to: imagesTableView.rx.items(cellIdentifier: "RentImagesTableViewCell", cellType: RentImagesTableViewCell.self)) { (row, element, cell) in
                cell.setupData(imageData: element)
        }.disposed(by: rx.disposeBag)
    }
    
    func setupCell() {
        let cellNib = UINib(nibName: "RentImagesTableViewCell", bundle: nil)
        self.imagesTableView.register(cellNib, forCellReuseIdentifier: "RentImagesTableViewCell")
    }
    
    func setupTableView() {
        imagesTableView.separatorStyle = .none
        imagesTableView.rx.setDelegate(self).disposed(by: rx.disposeBag)
    }
}

extension OwnRentImagesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 316
    }
}
