//
//  ProfileImageUploadViewController.swift
//  CarRentingApplication
//
//  Created by Ács Patrik on 2019. 11. 03..
//  Copyright © 2019. Ács Patrik Tamás. All rights reserved.
//

import UIKit
import Moya

class ProfileImageUploadViewController: UIViewController, Notifiable {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var registerButton: Button!
    
    var viewModel: ProfileImageUploadViewModelType!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupCancel()
        setupCamera()
        hideKeyboardWhenTappedAround()
        
        titleLabel.text = "Profile image"
        titleLabel.textColor = .black
        profileImage.contentMode = .scaleAspectFill
        
        registerButton.setupData(title: "Register")
        registerButton.isEnabled = false
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationItem.title = "Profile image"
    }
    
    @IBAction func registerButtonAction(_ sender: Any) {
        viewModel.setImage(image: profileImage.image ?? UIImage())
        viewModel.register()
            .subscribe(onSuccess: { _ in
                self.navigationController?.popToRootViewController(animated: true)
                self.showNotification("Registration", "Registration was successful!")
            }, onError: { error in
                if let moyaError = error as? MoyaError {
                    if let response = moyaError.response {
                        switch response.statusCode {
                        case 400:
                            self.showNotification("Registration error", "Missing parameters.")
                        case 200:
                            self.showNotification("Registration", "Successful registration.")
                        case 500:
                            self.showNotification("Registration error", "Image size error.")
                        default:
                            self.showNotification("Registration error", "Unknown error.")
                        }
                    } else {
                        self.showNotification("Registration error", "Network error.")
                    }
                }
            }).disposed(by: rx.disposeBag)
    }
    
    func setupCancel() {
        let cancelButton = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancelRegistration(sender:)))
        self.navigationItem.rightBarButtonItem = cancelButton
    }
    
    @objc func cancelRegistration(sender: UIBarButtonItem) {
        viewModel.cancelRegistration()
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    func setupCamera() {
        profileImage.isUserInteractionEnabled = true
        let loadCamera = UITapGestureRecognizer(target: self, action: #selector(loadCamera(sender:)))
        profileImage.addGestureRecognizer(loadCamera)
    }
    
    @objc func loadCamera(sender: UITapGestureRecognizer) {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            imagePicker.sourceType = .camera
            imagePicker.allowsEditing = true
            self.present(imagePicker, animated: true, completion: nil)
        } else {
            self.showNotification("Device error", "Camera not found.")
        }
    }
}

extension ProfileImageUploadViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let image = info[UIImagePickerController.InfoKey.editedImage] as? UIImage
        profileImage.image = image
        registerButton.isEnabled = true
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
}
