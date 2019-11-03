//
//  ProfileImageUploadViewController.swift
//  CarRentingApplication
//
//  Created by Ács Patrik on 2019. 11. 03..
//  Copyright © 2019. Ács Patrik Tamás. All rights reserved.
//

import UIKit

class ProfileImageUploadViewController: UIViewController {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var registerButton: Button!
    
    var viewModel: ProfileImageUploadViewModelType!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupCancel()
        hideKeyboardWhenTappedAround()
        
        titleLabel.text = "Profile image"
        registerButton.setupData(title: "Register")
        profileImage.backgroundColor = .gray
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationItem.title = "Profile image"
    }
    
    func setupCancel() {
        let cancelButton = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancelRegistration(sender:)))
        self.navigationItem.rightBarButtonItem = cancelButton
    }
    
    @objc func cancelRegistration(sender: UIBarButtonItem) {
        self.navigationController?.popToRootViewController(animated: true)
    }
}
