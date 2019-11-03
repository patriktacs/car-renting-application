//
//  DrivingLicenseFrontUploadViewController.swift
//  CarRentingApplication
//
//  Created by Ács Patrik on 2019. 11. 03..
//  Copyright © 2019. Ács Patrik Tamás. All rights reserved.
//

import UIKit

class DrivingLicenseFrontUploadViewController: UIViewController, UIImagePickerControllerDelegate, Notifiable {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var drivingLicenseFrontImage: UIImageView!
    @IBOutlet weak var nextButton: Button!
    
    var viewModel: DrivingLicenseFrontUploadViewModelType!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupCancel()
        setupCamera()
        hideKeyboardWhenTappedAround()
        
        titleLabel.text = "Driving license front image"
        nextButton.setupData(title: "Next")
        drivingLicenseFrontImage.backgroundColor = .gray
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationItem.title = "Driving license front"
    }
    
    @IBAction func nextButtonAction(_ sender: Any) {
        let loginStoryboard = UIStoryboard(name: "Login", bundle: nil)
        let personalDataInputViewController = loginStoryboard.instantiateViewController(withIdentifier: "DrivingLicenseBackUpload")
        self.navigationController?.pushViewController(personalDataInputViewController, animated: true)
    }
    
    func setupCancel() {
        let cancelButton = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancelRegistration(sender:)))
        self.navigationItem.rightBarButtonItem = cancelButton
    }
    
    @objc func cancelRegistration(sender: UIBarButtonItem) {
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    func setupCamera() {
        drivingLicenseFrontImage.isUserInteractionEnabled = true
        let loadCamera = UITapGestureRecognizer(target: self, action: #selector(loadCamera(sender:)))
        drivingLicenseFrontImage.addGestureRecognizer(loadCamera)
    }
    
    @objc func loadCamera(sender: UITapGestureRecognizer) {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self as? UIImagePickerControllerDelegate & UINavigationControllerDelegate
        
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            imagePicker.sourceType = .camera
            self.present(imagePicker, animated: true, completion: nil)
        } else {
            self.showNotification("Device error", "Camera not found.")
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage
        drivingLicenseFrontImage.image = image
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
}
