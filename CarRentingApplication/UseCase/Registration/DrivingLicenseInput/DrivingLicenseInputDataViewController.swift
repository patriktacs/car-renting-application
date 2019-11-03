//
//  DrivingLicenseInputDataViewController.swift
//  CarRentingApplication
//
//  Created by Ács Patrik on 2019. 11. 03..
//  Copyright © 2019. Ács Patrik Tamás. All rights reserved.
//

import UIKit
import RxCocoa
import RxBiBinding

class DrivingLicenseInputDataViewController: UIViewController {
    
    @IBOutlet weak var drivingLicenseNumberTextField: TextField!
    @IBOutlet weak var expirationDateTextField: TextField!
    @IBOutlet weak var nextButton: Button!
    
    var viewModel: DrivingLicenseInputDataViewModelType!
    
    var unformattedBehaviorRelay = BehaviorRelay<String?>(value: "")

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupCancel()
        setupDatePicker()
        hideKeyboardWhenTappedAround()
        
        drivingLicenseNumberTextField.setupData(placeholder: "Driving license number")
        expirationDateTextField.setupData(placeholder: "Expiration date")
        nextButton.setupData(title: "Next")
        
        (drivingLicenseNumberTextField.rx.text <-> viewModel.drivingLicenseNumberRelay).disposed(by: rx.disposeBag)
        (unformattedBehaviorRelay <-> viewModel.drivingLicenseExpirationRelay).disposed(by: rx.disposeBag)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationItem.title = "Driving license data"
    }
    
    @IBAction func nextButtonAction(_ sender: Any) {
        let loginStoryboard = UIStoryboard(name: "Login", bundle: nil)
        let personalDataInputViewController = loginStoryboard.instantiateViewController(withIdentifier: "DrivingLicenseFrontUpload")
        self.navigationController?.pushViewController(personalDataInputViewController, animated: true)
    }
    
    func setupCancel() {
        let cancelButton = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancelRegistration(sender:)))
        self.navigationItem.rightBarButtonItem = cancelButton
    }
    
    @objc func cancelRegistration(sender: UIBarButtonItem) {
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    func setupDatePicker() {
        let datePickerView = UIDatePicker()
        datePickerView.datePickerMode = UIDatePicker.Mode.date
        datePickerView.addTarget(self, action: #selector(handleDate(sender:)), for: UIControl.Event.valueChanged)
        expirationDateTextField.inputView = datePickerView
    }
    
    @objc func handleDate(sender: UIDatePicker) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        unformattedBehaviorRelay.accept(dateFormatter.string(from: sender.date))
        dateFormatter.dateFormat = "yyyy-MM-dd"
        expirationDateTextField.text = dateFormatter.string(from: sender.date)
    }
}
