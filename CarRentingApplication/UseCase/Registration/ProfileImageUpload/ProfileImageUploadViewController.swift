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
        registerButton.setupData(title: "Register")
        profileImage.contentMode = .scaleAspectFill
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationItem.title = "Profile image"
    }
    
    @IBAction func registerButtonAction(_ sender: Any) {
        viewModel.setImage(image: profileImage.image ?? UIImage())
        viewModel.register()
            .subscribe(onSuccess: { _ in
                self.showNotification("Registration", "Registration was successful!")
                self.navigationController?.popToRootViewController(animated: true)
            }, onError: { error in
                guard let moyaError = error as? MoyaError else {
                    return
                }
            
                self.showNotification("Registration error", "Error " + String(moyaError.response!.statusCode) + " " + (String(data: moyaError.response!.data, encoding: .utf8) ?? ""))
            }).disposed(by: rx.disposeBag)
    }
    
    func setupCancel() {
        let cancelButton = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancelRegistration(sender:)))
        self.navigationItem.rightBarButtonItem = cancelButton
    }
    
    @objc func cancelRegistration(sender: UIBarButtonItem) {
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
            self.present(imagePicker, animated: true, completion: nil)
        } else {
            self.showNotification("Device error", "Camera not found.")
        }
    }
}

extension ProfileImageUploadViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage
        profileImage.image = image
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
}
