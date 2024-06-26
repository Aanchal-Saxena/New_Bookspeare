//
//  LocationManager.swift
//  New_Bookspeare
//
//  Created by Katyayani Singh on 12/06/24.
//

import Foundation
import CoreLocation
class LocationManager: NSObject, CLLocationManagerDelegate {
    static let shared = LocationManager()
    
    let manager = CLLocationManager()
    
    var completion: ((CLLocation) -> Void)?
    
    public func getUserLocation(completion: @escaping ((CLLocation) -> Void)) {
        self.completion = completion
        manager.requestWhenInUseAuthorization()
        manager.delegate = self
        manager.startUpdatingLocation()
    }
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations:[CLLocation]) {
        guard let location = locations.first else{
            return
        }
        completion?(location)
        manager.stopUpdatingLocation()
    }
}
