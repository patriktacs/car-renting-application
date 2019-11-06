//
//  AccountDataInputViewController.swift
//  CarRentingApplication
//
//  Created by Ács Patrik on 2019. 10. 25..
//  Copyright © 2019. Ács Patrik Tamás. All rights reserved.
//

import UIKit
import RxBiBinding
import RxSwift

class AccountDataInputViewController: UIViewController {
    
    
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var emailTextField: TextField!
    @IBOutlet weak var passwordLabel: UILabel!
    @IBOutlet weak var passwordTextField: TextField!
    @IBOutlet weak var repeatPasswordLabel: UILabel!
    @IBOutlet weak var repeatPasswordtextField: TextField!
    @IBOutlet weak var nextButton: Button!
    
    var viewModel: AccountDataInputViewModelType!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupCancel()
        setupInputValidation()
        hideKeyboardWhenTappedAround()
        
        emailLabel.text = " "
        emailLabel.textColor = .red
        passwordLabel.text = " "
        passwordLabel.textColor = .red
        repeatPasswordLabel.text = " "
        repeatPasswordLabel.textColor = .red
        
        emailTextField.setupData(placeholder: "Email")
        emailTextField.delegate = self
        passwordTextField.setupData(placeholder: "Password", secureTextEntry: true)
        passwordTextField.delegate = self
        repeatPasswordtextField.setupData(placeholder: "Repeat password", secureTextEntry: true)
        repeatPasswordtextField.delegate = self

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
        if inputValidation() {
            let loginStoryboard = UIStoryboard(name: "Login", bundle: nil)
            let personalDataInputViewController = loginStoryboard.instantiateViewController(withIdentifier: "PersonalDataInput")
            self.navigationController?.pushViewController(personalDataInputViewController, animated: true)
        }
    }
    
    func setupCancel() {
        let cancelButton = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancelRegistration(sender:)))
        self.navigationItem.rightBarButtonItem = cancelButton
    }
    
    @objc func cancelRegistration(sender: UIBarButtonItem) {
        viewModel.cancelRegistration()
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    func inputValidation() -> Bool {
        let emailRegexString = "[A-Z0-9a-z._-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailRegex = NSPredicate(format:"SELF MATCHES %@", emailRegexString)
        let emailValidation = emailRegex.evaluate(with: emailTextField.text)
        
        let passwordRegexString = "(?=.*[a-z])(?=.*[A-Z])(?=.*[0-9])[A-Z0-9a-z]{6,}"
        let passwordRegex = NSPredicate(format:"SELF MATCHES %@", passwordRegexString)
        let passwordValidation = passwordRegex.evaluate(with: passwordTextField.text)
        
        let repeatPasswordValidation = self.repeatPasswordtextField.text == self.passwordTextField.text
        
        if !emailValidation {
            emailLabel.text = "Email format is 'someone@somewhere.com'"
        } else {
            emailLabel.text = " "
        }
        
        if !passwordValidation {
            passwordLabel.text = "At least 6 characters one upper, one lowercase letter and a number."
        } else {
            passwordLabel.text = " "
        }
        
        if !repeatPasswordValidation {
            repeatPasswordLabel.text = "Passwords doesn't match."
        } else {
            repeatPasswordLabel.text = " "
        }
        
        return emailValidation && passwordValidation && repeatPasswordValidation
    }
    
    func setupInputValidation() {
        let emailRegexString = "[A-Z0-9a-z._-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailRegex = NSPredicate(format:"SELF MATCHES %@", emailRegexString)
        
        let passwordRegexString = "(?=.*[a-z])(?=.*[A-Z])(?=.*[0-9])[A-Z0-9a-z]{6,}"
        let passwordRegex = NSPredicate(format:"SELF MATCHES %@", passwordRegexString)
        
        let emailEditEnd = emailTextField.rx.controlEvent(.editingDidEnd).asObservable().startWith(())
        let passwordEditEnd = passwordTextField.rx.controlEvent(.editingDidEnd).asObservable().startWith(())
        let repeatPasswordEditEnd = repeatPasswordtextField.rx.controlEvent(.editingDidEnd).asObservable().startWith(())
        
        Observable.combineLatest(emailEditEnd, passwordEditEnd, repeatPasswordEditEnd)
            .map { _, _, _ in
                let emailValidation = emailRegex.evaluate(with: self.emailTextField.text) || self.emailTextField.text == ""
                let passwordValidation = passwordRegex.evaluate(with: self.passwordTextField.text) || self.passwordTextField.text == ""
                let repeatPasswordValidation = self.repeatPasswordtextField.text == self.passwordTextField.text || self.repeatPasswordtextField.text == ""
        
                if !emailValidation {
                    self.emailLabel.text = "Email format is 'someone@somewhere.com'"
                } else {
                    self.emailLabel.text = " "
                }
        
                if !passwordValidation {
                    self.passwordLabel.text = "At least 6 characters one upper, one lowercase letter and a number."
                } else {
                    self.passwordLabel.text = " "
                }
        
                if !repeatPasswordValidation {
                    self.repeatPasswordLabel.text = "Passwords doesn't match."
                } else {
                    self.repeatPasswordLabel.text = " "
        }}.subscribe().disposed(by: rx.disposeBag)
    }
}
