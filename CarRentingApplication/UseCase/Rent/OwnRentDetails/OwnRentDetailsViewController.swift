//
//  OwnRentDetailsViewController.swift
//  CarRentingApplication
//
//  Created by Ács Patrik on 2019. 11. 30..
//  Copyright © 2019. Ács Patrik Tamás. All rights reserved.
//

import UIKit
import RxSwift
import Moya

class OwnRentDetailsViewController: UIViewController, Notifiable {
    
    
    @IBOutlet weak var stateImageView: UIImageView!
    @IBOutlet weak var carLabel: UILabel!
    @IBOutlet weak var startStationLabel: UILabel!
    @IBOutlet weak var startDateLabel: UILabel!
    @IBOutlet weak var endStationLabel: UILabel!
    @IBOutlet weak var endDateLabel: UILabel!
    @IBOutlet weak var mainButton: Button!
    @IBOutlet weak var cancelButton: Button!
    
    
    var viewModel: OwnRentDetailsViewModelType!
    
    var isStarted = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationItem.title = "Rent details"
    }
    
    func setupUI() {
        viewModel.data.subscribe(onNext: { data in
            self.navigationItem.rightBarButtonItems = []
            
            self.stateImageView.image = UIImage(named: data.rentStatus)
            self.carLabel.text = data.carId
            self.startStationLabel.text = data.startStationName
            self.endStationLabel.text = data.endStationName
            self.startDateLabel.text = data.startDate
            self.endDateLabel.text = data.endDate
            
            self.mainButton.setupData(title: data.firstButtonTitle)
            self.cancelButton.setupData(title: data.cancelButtonTitle)
            
            self.mainButton.isHidden = data.isFirstButtonAvailable
            self.cancelButton.isHidden = data.isCancelAvailable
            
            if data.isUploadAvailable {
                self.setupAddImage()
            }
            
            self.setupImageList()
            
            self.isStarted = data.isStarted
        }).disposed(by: rx.disposeBag)
    }
    
    @IBAction func mainActionButton(_ sender: Any) {
        if self.isStarted {
            self.viewModel.stopRent().subscribe(onSuccess: { _ in
                self.viewModel.setRentStatusToStopped()
                self.viewModel.dataRefreshRelay.accept(())
                self.showNotification("Rent", "Rent stopped successfully!")
            }, onError: { error in
                if let moyaError = error as? MoyaError {
                    if let response = moyaError.response {
                        switch response.statusCode {
                        case 400:
                            self.showNotification("Rent error", "Rent already stopped.")
                        default:
                            self.showNotification("Rent error", "Unknown error.")
                        }
                    } else {
                        self.showNotification("Rent error", "Network error.")
                    }
                }
            }).disposed(by: rx.disposeBag)
        } else {
            self.viewModel.startRent().subscribe(onSuccess: { _ in
                self.viewModel.setRentStatusToStarted()
                self.viewModel.dataRefreshRelay.accept(())
                self.showNotification("Rent", "Rent started successfully!")
            }, onError: { error in
                if let moyaError = error as? MoyaError {
                    if let response = moyaError.response {
                        switch response.statusCode {
                        case 400:
                            self.showNotification("Rent error", "Rent already started.")
                        default:
                            self.showNotification("Rent error", "Unknown error.")
                        }
                    } else {
                        self.showNotification("Rent error", "Network error.")
                    }
                }
            }).disposed(by: rx.disposeBag)
        }
    }
    
    @IBAction func cancelAction(_ sender: Any) {
        self.viewModel.cancelRent().subscribe(onSuccess: { _ in
            self.navigationController?.popViewController(animated: true)
            self.showNotification("Rent", "Rent cancelled.")
        }, onError: { error in
            if let moyaError = error as? MoyaError {
                if let response = moyaError.response {
                    switch response.statusCode {
                    default:
                        self.showNotification("Rent error", "Cancelling rent is not available.")
                    }
                } else {
                    self.showNotification("Rent error", "Network error.")
                }
            }
        }).disposed(by: rx.disposeBag)
    }
    
    
    func setupImageList() {
        let imagesButton = UIBarButtonItem(title: "Images", style: .plain, target: self, action: #selector(images))
        self.navigationItem.rightBarButtonItems?.append(imagesButton)
    }
    
    func setupAddImage() {
        let addImageButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.add, target: self, action: #selector(addImage))
        self.navigationItem.rightBarButtonItems?.append(addImageButton)
    }
    
    @objc func images(sender: UIBarButtonItem) {
        let dashboardStoryboard = UIStoryboard(name: "Dashboard", bundle: nil)
        let imagesViewController = dashboardStoryboard.instantiateViewController(withIdentifier: "OwnRentImages")
        self.navigationController?.pushViewController(imagesViewController, animated: true)
    }
    
    @objc func addImage(sender: UIBarButtonItem) {
        let dashboardStoryboard = UIStoryboard(name: "Dashboard", bundle: nil)
        let rentCarViewController = dashboardStoryboard.instantiateViewController(withIdentifier: "OwnRentImageUpload")
        self.navigationController?.pushViewController(rentCarViewController, animated: true)
    }
}
