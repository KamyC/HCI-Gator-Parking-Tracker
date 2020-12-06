//
//  ViewController.swift
//  Gator Parking Tracker
//
//  Created by JinghanCao on 11/17/20.
//

import UIKit
import MapKit
class ViewController: UIViewController, CLLocationManagerDelegate {
    var locationManager = CLLocationManager()
    
    @IBOutlet var textView: UITextField!
    @IBOutlet var mapView: MKMapView!
    let geocoder = CLGeocoder()
    var placemaker: CLPlacemark?
    override func viewDidLoad() {
        super.viewDidLoad()
        self.locationManager.requestWhenInUseAuthorization()
        if CLLocationManager.locationServicesEnabled(){
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
        }
    }
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let localValue: CLLocationCoordinate2D = manager.location!.coordinate
        print("locations = \(localValue.latitude) \(localValue.longitude) ")

        let userLocation = locations.last
        let viewRegion = MKCoordinateRegion(center: (userLocation?.coordinate)!, latitudinalMeters: 600,longitudinalMeters: 600)
        self.mapView.setRegion(viewRegion, animated: true)
    }
    
    @IBAction func locate(_ sender: Any) {
        let userLocation = mapView.userLocation
        let region = MKCoordinateRegion(center: (userLocation.location?.coordinate)!, latitudinalMeters: 1000, longitudinalMeters: 1000)
        mapView.setRegion(region, animated: true)
        let longitude :CLLocationDegrees = (self.locationManager.location?.coordinate.longitude)!
        let latitude :CLLocationDegrees = (self.locationManager.location?.coordinate.latitude)!
        let location = CLLocation(latitude: latitude, longitude: longitude)
        CLGeocoder().reverseGeocodeLocation(location, completionHandler: {(placemarks, error) -> Void in
            if error != nil {
                print("failed")
                return
            }
            if (placemarks?.count)! > 0 {
                
                let pm = placemarks?[0]
                
                let address = (pm?.subThoroughfare)! + " " + (pm?.thoroughfare)! + (pm?.locality)! + "," + (pm?.administrativeArea)! + " " + (pm?.postalCode)! + " " + (pm?.isoCountryCode)!
                print(address)
                self.textView.text = address
            }else{
                print("error")
            }
    })
    }
    func mapView(_ mapView: MKMapView, didUpdate userLocation: MKUserLocation) {
        mapView.centerCoordinate = userLocation.location!.coordinate
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.destination is BBBViewController{
            let data = segue.destination as? BBBViewController
            data?.location = self.textView.text!
        }
    }
}


