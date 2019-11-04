//
//  AccountDataInputViewController.swift
//  CarRentingApplication
//
//  Created by Ács Patrik on 2019. 10. 25..
//  Copyright © 2019. Ács Patrik Tamás. All rights reserved.
//

import UIKit
import RxBiBinding

class AccountDataInputViewController: UIViewController {
    
    @IBOutlet weak var emailTextField: TextField!
    @IBOutlet weak var passwordTextField: TextField!
    @IBOutlet weak var repeatPasswordtextField: TextField!
    @IBOutlet weak var nextButton: Button!
    
    var viewModel: AccountDataInputViewModelType!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupCancel()
        hideKeyboardWhenTappedAround()
        
        emailTextField.setupData(placeholder: "Email")
        passwordTextField.setupData(placeholder: "Password", secureTextEntry: true)
        repeatPasswordtextField.setupData(placeholder: "Repeat password", secureTextEntry: true)

        nextButton.setupData(title: "Next")
        
        (emailTextField.rx.text <-> viewModel.emailRelay).disposed(by: rx.disposeBag)
        (passwordTextField.rx.text <-> viewModel.passwordRelay).disposed(by: rx.disposeBag)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationItem.setHidesBackButton(false, animated: false)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationItem.title = "Account data"
        self.navigationItem.setHidesBackButton(true, animated: false)
    }
    
    @IBAction func nextButtonAction(_ sender: Any) {
        let loginStoryboard = UIStoryboard(name: "Login", bundle: nil)
        let personalDataInputViewController = loginStoryboard.instantiateViewController(withIdentifier: "PersonalDataInput")
        self.navigationController?.pushViewController(personalDataInputViewController, animated: true)
    }
    
    func setupCancel() {
        let cancelButton = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancelRegistration(sender:)))
        self.navigationItem.rightBarButtonItem = cancelButton
    }
    
    @objc func cancelRegistration(sender: UIBarButtonItem) {
        viewModel.cancelRegistration()
        self.navigationController?.popToRootViewController(animated: true)
    }
}
