//
//  PersonalDataInputViewController.swift
//  CarRentingApplication
//
//  Created by Ács Patrik on 2019. 11. 03..
//  Copyright © 2019. Ács Patrik Tamás. All rights reserved.
//

import UIKit
import RxBiBinding
import RxSwift

class PersonalDataInputViewController: UIViewController {
    
    
    @IBOutlet weak var firstNameLabel: UILabel!
    @IBOutlet weak var firstNameTextField: TextField!
    @IBOutlet weak var lastNameLabel: UILabel!
    @IBOutlet weak var lastNameTextField: TextField!
    @IBOutlet weak var phoneLabel: UILabel!
    @IBOutlet weak var phoneNumberTextField: TextField!
    @IBOutlet weak var nextButton: Button!
    
    var viewModel: PersonalDataInputViewModelType!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupCancel()
        setupInputValidation()
        hideKeyboardWhenTappedAround()
        
        firstNameLabel.text = " "
        firstNameLabel.textColor = .red
        lastNameLabel.text = " "
        lastNameLabel.textColor = .red
        phoneLabel.text = " "
        phoneLabel.textColor = .red
        
        firstNameTextField.setupData(placeholder: "First name")
        firstNameTextField.delegate = self
        lastNameTextField.setupData(placeholder: "Last name")
        lastNameTextField.delegate = self
        phoneNumberTextField.setupData(placeholder: "+36110000000")
        phoneNumberTextField.delegate = self
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
    
    func setupInputValidation() {
        let nameRegexString = "[A-Za-z\\s]{2,64}"
        let nameRegex = NSPredicate(format:"SELF MATCHES %@", nameRegexString)
        
        let phoneNumberRegexString = "\\+36(70|30|20)[0-9]{7}"
        let phoneNumberRegex = NSPredicate(format:"SELF MATCHES %@", phoneNumberRegexString)
        
        let firstNameEditEnd = firstNameTextField.rx.controlEvent(.editingDidEnd).asObservable().startWith(())
        let lastNameEditEnd = lastNameTextField.rx.controlEvent(.editingDidEnd).asObservable().startWith(())
        let phoneNumberEditEnd = phoneNumberTextField.rx.controlEvent(.editingDidEnd).asObservable().startWith(())
        
        Observable.combineLatest(firstNameEditEnd, lastNameEditEnd, phoneNumberEditEnd)
            .map { _, _, _ -> Bool in
                let firstNameValidation = nameRegex.evaluate(with: self.firstNameTextField.text) || self.firstNameTextField.text == ""
                let lastNameValidation = nameRegex.evaluate(with: self.lastNameTextField.text) || self.lastNameTextField.text == ""
                let phoneNumberValidation = phoneNumberRegex.evaluate(with: self.phoneNumberTextField.text) || self.lastNameTextField.text == "" || self.phoneNumberTextField.text == ""
        
                if !firstNameValidation {
                    self.firstNameLabel.text = "Shouldn't contain any special characters or numbers."
                } else {
                    self.firstNameLabel.text = " "
                }
        
                if !lastNameValidation {
                    self.lastNameLabel.text = "Shouldn't contain any special characters or numbers."
                } else {
                    self.lastNameLabel.text = " "
                }
        
                if !phoneNumberValidation {
                    self.phoneLabel.text = "Phone number format is '+36xx1234567'"
                } else {
                    self.phoneLabel.text = " "
                }
                
                return firstNameValidation && lastNameValidation && phoneNumberValidation && self.firstNameTextField.text != "" && self.lastNameTextField.text != "" && self.phoneNumberTextField.text != ""
        }.bind(to: nextButton.rx.isEnabled).disposed(by: rx.disposeBag)
    }
}
