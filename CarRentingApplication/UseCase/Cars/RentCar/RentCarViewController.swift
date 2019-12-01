//
//  RentCarViewController.swift
//  CarRentingApplication
//
//  Created by Ács Patrik on 2019. 11. 24..
//  Copyright © 2019. Ács Patrik Tamás. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import RxBiBinding
import Moya

class RentCarViewController: UIViewController, Notifiable {
    
    
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var startDateTextField: TextField!
    @IBOutlet weak var startStationPickerView: UIPickerView!
    @IBOutlet weak var endDateTextField: TextField!
    @IBOutlet weak var endStationPickerView: UIPickerView!
    @IBOutlet weak var rentButton: Button!
    
    var viewModel: RentCarViewModelType!
    
    var startDateBehaviorRelay = BehaviorRelay<String?>(value: "")
    var endDateBehaviorRelay = BehaviorRelay<String?>(value: "")
    
    var stationRelay = BehaviorRelay<[Station]>(value: [])

    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.stations
            .map { stations in
                self.viewModel.setStartStation(station: stations[0])
                self.viewModel.setEndStation(station: stations[0])
                return stations
        }.bind(to: stationRelay).disposed(by: rx.disposeBag)
        
        setupStartDatePicker()
        setupEndDatePicker()
        setupInputValidation()
        setupStationSelection()
        hideKeyboardWhenTappedAround()
        
        errorLabel.text = ""
        errorLabel.textColor = .red
        
        startDateTextField.placeholder = "Starting date"
        endDateTextField.placeholder = "Ending date"
        
        rentButton.setupData(title: "Rent car")
        rentButton.isEnabled = false
        
        viewModel.stationNames.bind(to: startStationPickerView.rx.itemTitles) { (row, element) in
            return element
        }.disposed(by: rx.disposeBag)
        
        viewModel.stationNames.bind(to: endStationPickerView.rx.itemTitles) { (row, element) in
            return element
        }.disposed(by: rx.disposeBag)
        
        (startDateBehaviorRelay <-> viewModel.startDateRelay).disposed(by: rx.disposeBag)
        (endDateBehaviorRelay <-> viewModel.endDateRelay).disposed(by: rx.disposeBag)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationItem.title = "Rent car"
    }
    
    @IBAction func rentAction(_ sender: Any) {
        viewModel.rent().subscribe(onSuccess: { response in
            self.navigationController?.popViewController(animated: true)
            self.showNotification("Renting", "Renting was successful!")
        }, onError: { error in
            if let moyaError = error as? MoyaError {
                if let response = moyaError.response {
                    switch response.statusCode {
                    case 400:
                        self.showNotification("Renting error", "The car has already been reserved for this time period.")
                    case 500:
                        self.showNotification("Registration error", "Unknown error 2.")
                    default:
                        self.showNotification("Registration error", "Unknown error.")
                    }
                } else {
                    self.showNotification("Renting error", "Network error.")
                }
            }
        }).disposed(by: rx.disposeBag)
    }
    
    func setupStartDatePicker() {
        let datePickerView = UIDatePicker()
        datePickerView.datePickerMode = UIDatePicker.Mode.date
        datePickerView.addTarget(self, action: #selector(handleStartDate(sender:)), for: UIControl.Event.valueChanged)
        startDateTextField.inputView = datePickerView
    }
    
    @objc func handleStartDate(sender: UIDatePicker) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm"
        startDateBehaviorRelay.accept(dateFormatter.string(from: sender.date))
        dateFormatter.dateFormat = "yyyy-MM-dd"
        startDateTextField.text = dateFormatter.string(from: sender.date)
    }
    
    func setupEndDatePicker() {
        let datePickerView = UIDatePicker()
        datePickerView.datePickerMode = UIDatePicker.Mode.date
        datePickerView.addTarget(self, action: #selector(handleEndDate(sender:)), for: UIControl.Event.valueChanged)
        endDateTextField.inputView = datePickerView
    }
    
    @objc func handleEndDate(sender: UIDatePicker) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm"
        endDateBehaviorRelay.accept(dateFormatter.string(from: sender.date))
        dateFormatter.dateFormat = "yyyy-MM-dd"
        endDateTextField.text = dateFormatter.string(from: sender.date)
    }
    
    func setupInputValidation() {
        
        let startDateEnd = startDateTextField.rx.controlEvent(.editingDidEnd).asObservable()
        let endDateEnd = endDateTextField.rx.controlEvent(.editingDidEnd).asObservable()
        
        Observable.combineLatest(startDateEnd, endDateEnd)
            .map { _, _ -> Bool in
                
                print(self.startDateTextField.text ?? "")
                print(self.endDateTextField.text ?? "")
                
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "yyyy-MM-dd"
                
                let startDate = dateFormatter.date(from: self.startDateTextField.text ?? "") ?? Date()
                let endDate = dateFormatter.date(from: self.endDateTextField.text ?? "") ?? Date()
                
                if startDate < Date() {
                    self.errorLabel.text = "Start date can't be earlier then today."
                    return false
                } else if startDate < endDate {
                    self.errorLabel.text = ""
                    return true
                } else {
                    self.errorLabel.text = "Start date can't be later than end date."
                    return false
                }
        }.bind(to: rentButton.rx.isEnabled).disposed(by: rx.disposeBag)
    }
    
    func setupStationSelection() {
        self.startStationPickerView.rx.itemSelected.subscribe(onNext: { item in
            self.viewModel.setStartStation(station: self.stationRelay.value[item.row])
        }).disposed(by: rx.disposeBag)
        
        self.endStationPickerView.rx.itemSelected.subscribe(onNext: { item in
            self.viewModel.setEndStation(station: self.stationRelay.value[item.row])
        }).disposed(by: rx.disposeBag)
    }

}
