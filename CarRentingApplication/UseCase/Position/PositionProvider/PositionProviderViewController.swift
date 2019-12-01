//
//  PositionProviderViewController.swift
//  CarRentingApplication
//
//  Created by Ács Patrik on 2019. 12. 01..
//  Copyright © 2019. Ács Patrik Tamás. All rights reserved.
//

import UIKit
import MapKit
import Moya

class PositionProviderViewController: UIViewController, Notifiable {
    
    @IBOutlet weak var textLabel: UILabel!
    @IBOutlet weak var currentPositionLabel: UILabel!
    @IBOutlet weak var map: MKMapView!
    @IBOutlet weak var sendButton: Button!
    
    var locManager = CLLocationManager()
    
    var currentLocation: CLLocation!
    
    var viewModel: PositionProviderViewModelType!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        locManager.requestWhenInUseAuthorization()
        
        textLabel.text = "You must provide your current location for the admins to be able to use the app!"
        currentPositionLabel.text = "Current position"
        sendButton.setupData(title: "Get position")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = true
        self.navigationItem.setHidesBackButton(true, animated: false)
        self.navigationItem.title = "Location"
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = false
        self.navigationItem.setHidesBackButton(false, animated: false)
    }
    
    func setupMap() {
        map.delegate = self
        
        let coordinates = CLLocationCoordinate2D(latitude: currentLocation.coordinate.latitude,
                                                  longitude: currentLocation.coordinate.longitude);
        let annotation = MKPointAnnotation();
        annotation.coordinate = coordinates;
        annotation.title = "You are here!"
        map.addAnnotation(annotation);
        
        map.setCenter(coordinates, animated: true)
    }
    
    @IBAction func getPosition(_ sender: Any) {
        if(CLLocationManager.authorizationStatus() == .authorizedWhenInUse ||
                CLLocationManager.authorizationStatus() ==  .authorizedAlways) {

            currentLocation = locManager.location
            
            setupMap()
            setupSend()
            
            viewModel.latitudeRelay.accept(Double(currentLocation.coordinate.latitude))
            viewModel.longitudeRelay.accept(Double(currentLocation.coordinate.longitude))
        }
    }
    
    func setupSend() {
        let sendButton = UIBarButtonItem(title: "Send", style: .plain, target: self, action: #selector(send))
        self.navigationItem.rightBarButtonItem = sendButton
    }
    
    @objc func send(sender: UIBarButtonItem) {
        viewModel.sendPosition().subscribe(onSuccess: { response in
            self.navigationController?.popToRootViewController(animated: true)
            self.showNotification("Position", "Position sent successfully.")
        }, onError: { error in
            if let moyaError = error as? MoyaError {
                if let response = moyaError.response {
                    switch response.statusCode {
                    default:
                        self.showNotification("Position error", "Unknown error.")
                    }
                } else {
                    self.showNotification("Position error", "Network error.")
                }
            }
        }).disposed(by: rx.disposeBag)
    }
}

extension PositionProviderViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if annotation is MKUserLocation{
            return nil;
        } else {
            let markerId = "Marker";
            var markerView: MKMarkerAnnotationView;
            if let dequeuedView = mapView.dequeueReusableAnnotationView(withIdentifier: markerId) as? MKMarkerAnnotationView {
                dequeuedView.annotation = annotation;
                markerView = dequeuedView;
            } else {
                markerView = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: markerId);
            }
            
            return markerView;
        }
    }
}
