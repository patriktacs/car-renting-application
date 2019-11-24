//
//  CarDetailsViewController.swift
//  CarRentingApplication
//
//  Created by Ács Patrik on 2019. 11. 16..
//  Copyright © 2019. Ács Patrik Tamás. All rights reserved.
//

import UIKit
import MapKit

class CarDetailsViewController: UIViewController {
    
    @IBOutlet weak var engineTypeImage: UIImageView!
    @IBOutlet weak var colorLabel: UILabel!
    @IBOutlet weak var kmLabel: UILabel!
    @IBOutlet weak var licensePlateLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var locationMap: MKMapView!
    
    var viewModel: CarDetailsViewModelType!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.rightBarButtonItems = []
        
        setupRent()
        setupRentList()
        setupMap()
        
        engineTypeImage.image = UIImage(named: viewModel.engineType)
        colorLabel.text = viewModel.color
        kmLabel.text = viewModel.currentKm
        licensePlateLabel.text = viewModel.licensePlate
        priceLabel.text = viewModel.price
        locationLabel.text = "Current location"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationItem.title = viewModel.title
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationItem.title = "Details"
    }
    
    func setupRent() {
        let rentButton = UIBarButtonItem(title: "Rent", style: .plain, target: self, action: #selector(rent))
        self.navigationItem.rightBarButtonItems?.append(rentButton)
    }
    
    @objc func rent(sender: UIBarButtonItem) {
        
    }
    
    func setupRentList() {
        let rentListButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.bookmarks, target: self, action: #selector(rentList))
        self.navigationItem.rightBarButtonItems?.append(rentListButton)
    }
    
    @objc func rentList(sender: UIBarButtonItem) {
        let dashboardStoryboard = UIStoryboard(name: "Dashboard", bundle: nil)
        let carRentsViewController = dashboardStoryboard.instantiateViewController(withIdentifier: "CarRents")
        self.navigationController?.pushViewController(carRentsViewController, animated: true)
    }
    
    func setupMap() {
        locationMap.delegate = self
        
        let coordinates = CLLocationCoordinate2D(latitude: viewModel.latitude,
                                                  longitude: viewModel.longitude);
        let annotation = MKPointAnnotation();
        annotation.coordinate = coordinates;
        annotation.title = viewModel.stationName
        locationMap.addAnnotation(annotation);
        
        locationMap.setCenter(coordinates, animated: true)
    }
}

extension CarDetailsViewController: MKMapViewDelegate {
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
