//
//  ViewController.swift
//  PixelCity
//
//  Created by Artur Ratajczak on 23/02/2019.
//  Copyright © 2019 Artur Ratajczak. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class MapVC: UIViewController, UIGestureRecognizerDelegate {
    @IBOutlet weak var mapView: MKMapView!
    
    var locationManager = CLLocationManager()
    let authorizationStatus = CLLocationManager.authorizationStatus()
    let regionRadius: Double = 800
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.delegate = self
        locationManager.delegate = self
        configureLocationServices()
        addDoubleTap()
    }

    @IBAction func centerMapButtonWasPressed(_ sender: Any) {
        if authorizationStatus == .authorizedAlways || authorizationStatus == .authorizedWhenInUse {
            centerMapOnUserLocation()
        }
    }
    
    func addDoubleTap(){
        let doubleTap = UITapGestureRecognizer(target: self, action: #selector(dropPin(sender:)))
        doubleTap.numberOfTapsRequired = 2
        doubleTap.delegate = self
        mapView.addGestureRecognizer(doubleTap)
    }
}

extension MapVC: MKMapViewDelegate {
    func centerMapOnUserLocation(){
        guard let coordinate = locationManager.location?.coordinate else {
            return
        }
        let coordinateRegion = MKCoordinateRegion.init(center: coordinate, latitudinalMeters: regionRadius * 2, longitudinalMeters: regionRadius * 2)
        mapView.setRegion(coordinateRegion, animated: true)
    }
    
    @objc func dropPin( sender: UITapGestureRecognizer ){
        removePin()
        
        let touchPoint = sender.location(in: mapView)
        let touchCoordinate = mapView.convert(touchPoint, toCoordinateFrom: mapView)
        
        let annotation = DroppablePin(coordinate: touchCoordinate, identifier: "droppablePin")
        mapView.addAnnotation(annotation)
        
        let coordinateRegion = MKCoordinateRegion.init(center: touchCoordinate, latitudinalMeters: regionRadius * 2, longitudinalMeters: regionRadius * 2)
        mapView.setRegion(coordinateRegion, animated: true)
    }
    
    func removePin(){
        for annotation in mapView.annotations {
            mapView.removeAnnotation(annotation)
        }
    }
}

extension MapVC: CLLocationManagerDelegate {
    func configureLocationServices(){
        if authorizationStatus == .notDetermined {
            locationManager.requestAlwaysAuthorization()
        } else {
            return
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        centerMapOnUserLocation()
    }
}
