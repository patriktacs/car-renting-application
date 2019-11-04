//
//  PersonalDataInputViewController.swift
//  CarRentingApplication
//
//  Created by Ács Patrik on 2019. 11. 03..
//  Copyright © 2019. Ács Patrik Tamás. All rights reserved.
//

import UIKit
import RxBiBinding

class PersonalDataInputViewController: UIViewController {
    
    @IBOutlet weak var firstNameTextField: TextField!
    @IBOutlet weak var lastNameTextField: TextField!
    @IBOutlet weak var phoneNumberTextField: TextField!
    @IBOutlet weak var nextButton: Button!
    
    var viewModel: PersonalDataInputViewModelType!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupCancel()
        hideKeyboardWhenTappedAround()
        
        firstNameTextField.setupData(placeholder: "First name")
        lastNameTextField.setupData(placeholder: "Last name")
        phoneNumberTextField.setupData(placeholder: "+36110000000")
        nextButton.setupData(title: "Next")
        
        (firstNameTextField.rx.text <-> viewModel.firstNameRelay).disposed(by: rx.disposeBag)
        (lastNameTextField.rx.text <-> viewModel.lastNameRelay).disposed(by: rx.disposeBag)
        (phoneNumberTextField.rx.text <-> viewModel.phoneNumberRelay).disposed(by: rx.disposeBag)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationItem.title = "Personal data"
    }
    
    func setupCancel() {
        let cancelButton = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancelRegistration(sender:)))
        self.navigationItem.rightBarButtonItem = cancelButton
    }
    
    @objc func cancelRegistration(sender: UIBarButtonItem) {
        viewModel.cancelRegistration()
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    @IBAction func nextButtonAction(_ sender: Any) {
        let loginStoryboard = UIStoryboard(name: "Login", bundle: nil)
        let personalDataInputViewController = loginStoryboard.instantiateViewController(withIdentifier: "DrivingLicenseInput")
        self.navigationController?.pushViewController(personalDataInputViewController, animated: true)
    }
}
