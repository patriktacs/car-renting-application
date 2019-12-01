//
//  OwnRentImageUploadViewController.swift
//  CarRentingApplication
//
//  Created by Ács Patrik on 2019. 12. 01..
//  Copyright © 2019. Ács Patrik Tamás. All rights reserved.
//

import UIKit
import RxSwift
import Moya

class OwnRentImageUploadViewController: UIViewController, Notifiable {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var uploadButton: Button!
    
    var viewModel: OwnRentImageUploadViewModelType!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        imageView.contentMode = .scaleAspectFill
        
        uploadButton.setupData(title: "Upload")
        uploadButton.isEnabled = false
        
        setupCamera()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationItem.title = "Upload image for car"
    }
    
    @IBAction func uploadAction(_ sender: Any) {
        viewModel.setImage(image: imageView.image ?? UIImage())
        viewModel.uploadImage()
        .subscribe(onSuccess: { _ in
            self.showNotification("Rent image", "Upload was successful.")
            self.imageView.image = nil
        }, onError: { error in
            if let moyaError = error as? MoyaError {
                if let response = moyaError.response {
                    switch response.statusCode {
                    case 400:
                        self.showNotification("Rent image error", "Missing parameters.")
                    case 500:
                        self.showNotification("Rent image error", "Image size error.")
                    default:
                        self.showNotification("Rent image error", "Unknown error.")
                    }
                } else {
                    self.showNotification("Rent image error", "Network error.")
                }
            }
        }).disposed(by: rx.disposeBag)
    }
    
    func setupCamera() {
        imageView.isUserInteractionEnabled = true
        let loadCamera = UITapGestureRecognizer(target: self, action: #selector(loadCamera(sender:)))
        imageView.addGestureRecognizer(loadCamera)
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

extension OwnRentImageUploadViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let image = info[UIImagePickerController.InfoKey.editedImage] as? UIImage
        imageView.image = image
        uploadButton.isEnabled = true
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
}
