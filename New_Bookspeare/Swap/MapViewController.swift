//
//  MapViewController.swift
//  Swap
//
//  Created by Katyayani Singh on 02/06/24.
//
import CoreLocation
import MapKit
import UIKit

class MapViewController: UIViewController {

    private let map: MKMapView = {
       let map = MKMapView()
        return map
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(map)
        
        
        LocationManager.shared.getUserLocation { [weak self] location in
            DispatchQueue.main.async {
                guard let strongSelf = self else {
                    return
                }
                strongSelf.addMapPin(with: location)
            }
        }
        // Do any additional setup after loading the view.
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        map.frame = view.bounds
    }
    func addMapPin(with location: CLLocation){
        let pin = MKPointAnnotation()
        pin.coordinate = location.coordinate
        map.setRegion(MKCoordinateRegion(center: location.coordinate, span: MKCoordinateSpan(latitudeDelta: 0.7, longitudeDelta: 0.5)), animated: true)
        map.addAnnotation(pin)
        LocationManager.shared.resolveLocationName(with: location) { [weak self] locationName in
            self?.title = locationName
        }
        
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
