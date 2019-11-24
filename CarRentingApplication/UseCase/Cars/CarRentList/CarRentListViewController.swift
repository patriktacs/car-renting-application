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
    
    var pullToRefresh: UIRefreshControl = UIRefreshControl()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupCell()
        setupTableView()
        setupPullToRefresh()
        
        viewModel.rentItems
            .bind(to: rentListTableView.rx.items(cellIdentifier: "RentsTableViewCell", cellType: RentsTableViewCell.self)) { (row, element, cell) in
                cell.setupData(rent: element)
        }.disposed(by: rx.disposeBag)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationItem.title = "Rents for " + viewModel.carName
    }
    
    func setupCell() {
        let cellNib = UINib(nibName: "RentsTableViewCell", bundle: nil)
        self.rentListTableView.register(cellNib, forCellReuseIdentifier: "RentsTableViewCell")
    }
    
    func setupTableView() {
        rentListTableView.refreshControl = self.pullToRefresh
        rentListTableView.separatorStyle = .none
        rentListTableView.rx.setDelegate(self).disposed(by: rx.disposeBag)
    }
    
    func setupPullToRefresh() {
        self.pullToRefresh.rx.controlEvent(.valueChanged)
            .subscribe(onNext: { [weak self] _ in
                guard let self = self else { return }
                self.viewModel.rentsRefreshRelay.accept(())
            }).disposed(by: rx.disposeBag)
        
        self.viewModel.rentItems
            .subscribe(onNext: { [weak self] _ in
                guard let self = self else { return }
                self.pullToRefresh.endRefreshing()
            }).disposed(by: rx.disposeBag)
    }

}

extension CarRentListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80.0
    }
}
