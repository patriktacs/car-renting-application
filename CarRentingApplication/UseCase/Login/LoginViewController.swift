//
//  LoginViewController.swift
//  CarRentingApplication
//
//  Created by Ács Patrik on 2019. 10. 20..
//  Copyright © 2019. Ács Patrik Tamás. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import RxBiBinding
import Moya

class LoginViewController: UIViewController, Notifiable {
    
    @IBOutlet weak var backgroundView: UIView!
    @IBOutlet weak var usernameTexField: TextField!
    @IBOutlet weak var passwordTextField: TextField!
    @IBOutlet weak var loginButton: Button!
    @IBOutlet weak var registrationButton: UrlButton!
    @IBOutlet weak var forgotPasswordButton: UrlButton!
    
    var viewModel: LoginViewModelType!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        hideKeyboardWhenTappedAround()
        
        loginButton.setupData(title: "Log in")
        registrationButton.setupData(title: "Register")
        forgotPasswordButton.setupData(title: "Forgot password")
        
        usernameTexField.setupData(placeholder: "Email")
        passwordTextField.setupData(placeholder: "Password", secureTextEntry: true)

        (usernameTexField.rx.text <-> viewModel.usernameRelay).disposed(by: rx.disposeBag)
        (passwordTextField.rx.text <-> viewModel.passwordRelay).disposed(by: rx.disposeBag)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = false
    }
    
    @IBAction func loginButton(_ sender: Any) {
        viewModel.login()
            .subscribe(onSuccess: { _ in
                let dashboardStoryboard = UIStoryboard(name: "Dashboard", bundle: nil)
                if let dashboardMainController = dashboardStoryboard.instantiateInitialViewController() {
                    let appdelegate = UIApplication.shared.delegate as! AppDelegate
                    appdelegate.window!.rootViewController = dashboardMainController
                }
            }, onError: { error in
                if let moyaError = error as? MoyaError {
                    if let response = moyaError.response {
                        switch response.statusCode {
                        case 401:
                            self.showNotification("Login error", "Wrong email or password.")
                        default:
                            self.showNotification("Login error", "Unknown error.")
                        }
                    } else {
                        self.showNotification("Login error", "Network error.")
                    }
                }
            }).disposed(by: rx.disposeBag)
    }
    
    
    @IBAction func navRegistration(_ sender: Any) {
        let loginStoryboard = UIStoryboard(name: "Login", bundle: nil)
        let registrationViewController = loginStoryboard.instantiateViewController(withIdentifier: "AccountDataInput") as UIViewController
        self.navigationController?.pushViewController(registrationViewController, animated: true)
    }
}
