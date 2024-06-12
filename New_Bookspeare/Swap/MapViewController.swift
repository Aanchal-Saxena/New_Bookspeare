//
//  MapViewController.swift
//  New_Bookspeare
//
//  Created by Katyayani Singh on 12/06/24.
//
import UIKit
import MapKit
import CoreLocation

class MapViewController: UIViewController {
    
    private let map: MKMapView = {
        let map = MKMapView()
        return map
    }()
    
    private let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(map)
        map.frame = view.bounds
        
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        map.frame = view.bounds
    }
    
    func addMapPin(with location: CLLocation) {
        let pin = MKPointAnnotation()
        pin.coordinate = location.coordinate
        map.setRegion(MKCoordinateRegion(center: location.coordinate, span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)), animated: true)
        map.addAnnotation(pin)
    }
}

extension MapViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.first else {
            print("No location found")
            return
        }
        
        print("Location updated: \(location.coordinate.latitude), \(location.coordinate.longitude)")
        addMapPin(with: location)
        
        // Stop updating location once we have received it
        manager.stopUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Failed to find user's location: \(error.localizedDescription)")
    }
}
