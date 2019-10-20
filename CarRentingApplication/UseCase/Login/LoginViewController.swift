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
    @IBOutlet weak var usernameTexField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    var viewModel: LoginViewModelType!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        (usernameTexField.rx.text <-> viewModel.usernameRelay).disposed(by: rx.disposeBag)
        (passwordTextField.rx.text <-> viewModel.passwordRelay).disposed(by: rx.disposeBag)
    }
    
    @IBAction func loginButton(_ sender: Any) {
        viewModel.login()
            .subscribe(onSuccess: { _ in
                let dashboardStoryboard = UIStoryboard(name: "Dashboard", bundle: nil)
                if let dashboardMainController = dashboardStoryboard.instantiateInitialViewController() {
                    self.present(dashboardMainController, animated: true, completion: nil)
                }
            }, onError: { error in
                guard let moyaError = error as? MoyaError else {
                    return
                }
                
                self.showNotification("Login error", "Error " + String(moyaError.response!.statusCode))
            }).disposed(by: rx.disposeBag)
    }
    
}
