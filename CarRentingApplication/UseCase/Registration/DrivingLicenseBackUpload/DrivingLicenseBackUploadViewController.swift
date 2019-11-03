//
//  DrivingLicenseBackUploadViewController.swift
//  CarRentingApplication
//
//  Created by Ács Patrik on 2019. 11. 03..
//  Copyright © 2019. Ács Patrik Tamás. All rights reserved.
//

import UIKit

class DrivingLicenseBackUploadViewController: UIViewController {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var drivingLicenseBackImage: UIImageView!
    @IBOutlet weak var nextButton: Button!
    
    var viewModel: DrivingLicenseBackUploadViewModelType!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupCancel()
        hideKeyboardWhenTappedAround()
        
        titleLabel.text = "Driving license back image"
        nextButton.setupData(title: "Next")
        drivingLicenseBackImage.backgroundColor = .gray
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationItem.title = "Driving license back"
    }
    
    @IBAction func nextButtonAction(_ sender: Any) {
        let loginStoryboard = UIStoryboard(name: "Login", bundle: nil)
        let personalDataInputViewController = loginStoryboard.instantiateViewController(withIdentifier: "ProfileImageUpload")
        self.navigationController?.pushViewController(personalDataInputViewController, animated: true)
    }
    
    func setupCancel() {
        let cancelButton = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancelRegistration(sender:)))
        self.navigationItem.rightBarButtonItem = cancelButton
    }
    
    @objc func cancelRegistration(sender: UIBarButtonItem) {
        self.navigationController?.popToRootViewController(animated: true)
    }
}
