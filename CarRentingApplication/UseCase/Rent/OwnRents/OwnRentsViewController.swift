//
//  OwnRentsViewController.swift
//  CarRentingApplication
//
//  Created by Ács Patrik on 2019. 11. 24..
//  Copyright © 2019. Ács Patrik Tamás. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class OwnRentsViewController: UIViewController {
    
    
    @IBOutlet weak var ownRentsTableView: UITableView!
    
    var viewModel: OwnRentsViewModelType!
    
    var rents = BehaviorRelay<[Rent]>(value: [])
    
    var pullToRefresh: UIRefreshControl = UIRefreshControl()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupLogout()
        setupCell()
        setupTableView()
        setupPullToRefresh()
        setupItemSelected()
        
        viewModel.ownRentItems
            .bind(to: ownRentsTableView.rx.items(cellIdentifier: "OwnRentsTableViewCell", cellType: OwnRentsTableViewCell.self)) { (row, element, cell) in
                cell.setupData(element)
        }.disposed(by: rx.disposeBag)
        
        viewModel.rents.bind(to: rents).disposed(by: rx.disposeBag)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationItem.title = "My Rents"
        
        self.viewModel.ownRentsRefreshRelay.accept(())
    }
    
    func setupLogout() {
        let logoutButton = UIBarButtonItem(title: "Logout", style: .plain, target: self, action: #selector(logout))
        self.navigationItem.rightBarButtonItem = logoutButton
    }
    
    @objc func logout(sender: UIBarButtonItem) {
        viewModel.logout()
        let loginStoryboard = UIStoryboard(name: "Login", bundle: nil)
        if let loginMainController = loginStoryboard.instantiateInitialViewController() {
            let appdelegate = UIApplication.shared.delegate as! AppDelegate
            appdelegate.window!.rootViewController = loginMainController
        }
    }
    
    func setupCell() {
        let cellNib = UINib(nibName: "OwnRentsTableViewCell", bundle: nil)
        self.ownRentsTableView.register(cellNib, forCellReuseIdentifier: "OwnRentsTableViewCell")
    }
    
    func setupTableView() {
        ownRentsTableView.refreshControl = self.pullToRefresh
        ownRentsTableView.separatorStyle = .none
        ownRentsTableView.rx.setDelegate(self).disposed(by: rx.disposeBag)
    }
    
    func setupPullToRefresh() {
        self.pullToRefresh.rx.controlEvent(.valueChanged)
            .subscribe(onNext: { [weak self] _ in
                guard let self = self else { return }
                self.viewModel.ownRentsRefreshRelay.accept(())
            }).disposed(by: rx.disposeBag)
        
        self.viewModel.ownRentItems
            .subscribe(onNext: { [weak self] _ in
                guard let self = self else { return }
                self.pullToRefresh.endRefreshing()
            }).disposed(by: rx.disposeBag)
    }
    
    func setupItemSelected() {
        self.ownRentsTableView.rx.itemSelected.subscribe(onNext: { indexPath in
            let selectedRent = self.rents.value[indexPath.row]
            self.viewModel.setCurrentRent(rent: selectedRent)
            
            let dashboardStoryboard = UIStoryboard(name: "Dashboard", bundle: nil)
            let carDetailsViewController = dashboardStoryboard.instantiateViewController(withIdentifier: "OwnRentDetails")
            self.navigationController?.pushViewController(carDetailsViewController, animated: true)
        }).disposed(by: rx.disposeBag)
    }
}

extension OwnRentsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80.0
    }
}
