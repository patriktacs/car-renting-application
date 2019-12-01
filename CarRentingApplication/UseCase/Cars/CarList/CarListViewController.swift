//
//  CarListViewController.swift
//  CarRentingApplication
//
//  Created by Ács Patrik on 2019. 11. 10..
//  Copyright © 2019. Ács Patrik Tamás. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class CarListViewController: UIViewController, UITabBarControllerDelegate {
    
    @IBOutlet weak var carListTableView: UITableView!
    
    var viewModel: CarListViewModelType!
    
    var cars: BehaviorRelay<[Car]> = BehaviorRelay<[Car]>(value: [])
    
    var pullToRefresh: UIRefreshControl = UIRefreshControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupLogout()
        setupCell()
        setupTableView()
        setupPullToRefresh()
        setupItemSelected()
        
        viewModel.carItems
            .bind(to: carListTableView.rx.items(cellIdentifier: "carsTableViewCell", cellType: CarsTableViewCell.self)) { (row, element, cell) in
                cell.setupData(element)
        }.disposed(by: rx.disposeBag)
        
        viewModel.cars.bind(to: cars).disposed(by: rx.disposeBag)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationItem.title = "Cars"
        self.viewModel.carsRefreshRelay.accept(())
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
        let cellNib = UINib(nibName: "CarsTableViewCell", bundle: nil)
        self.carListTableView.register(cellNib, forCellReuseIdentifier: "carsTableViewCell")
    }
    
    func setupTableView() {
        carListTableView.refreshControl = self.pullToRefresh
        carListTableView.separatorStyle = .none
        carListTableView.rx.setDelegate(self).disposed(by: rx.disposeBag)
    }
    
    func setupPullToRefresh() {
        self.pullToRefresh.rx.controlEvent(.valueChanged)
            .subscribe(onNext: { [weak self] _ in
                guard let self = self else { return }
                self.viewModel.carsRefreshRelay.accept(())
            }).disposed(by: rx.disposeBag)
        
        self.viewModel.cars
            .subscribe(onNext: { [weak self] _ in
                guard let self = self else { return }
                self.pullToRefresh.endRefreshing()
            }).disposed(by: rx.disposeBag)
    }
    
    func setupItemSelected() {
        self.carListTableView.rx.itemSelected.subscribe(onNext: { indexPath in
            let selectedCar = self.cars.value[indexPath.row]
            self.viewModel.setCurrentCar(car: selectedCar)
            
            let dashboardStoryboard = UIStoryboard(name: "Dashboard", bundle: nil)
            let carDetailsViewController = dashboardStoryboard.instantiateViewController(withIdentifier: "CarDetails")
            self.navigationController?.pushViewController(carDetailsViewController, animated: true)
        }).disposed(by: rx.disposeBag)
    }
}

extension CarListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80.0
    }
}
