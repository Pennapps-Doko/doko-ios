//
//  MapsController.swift
//  doko
//
//  Created by Emily on 9/8/18.
//  Copyright © 2018 Emily. All rights reserved.
//

import Foundation
import UIKit
import MapKit
import CoreLocation

class MapsController: UIViewController, CLLocationManagerDelegate,MKMapViewDelegate
 {
    
    var initialLocation = CLLocation(latitude: 51.5001524, longitude: -0.1262362)
    let regionRadius: CLLocationDistance = 1000
//    var locationManager: CLLocationManager!
    let locationManager = CLLocationManager()

    
    func centerMapOnLocation(location:CLLocation) {
        let coordianteRegion = MKCoordinateRegionMakeWithDistance(location.coordinate,
                                                                  regionRadius * 2.0, regionRadius * 2.0)
        map.setRegion(coordianteRegion, animated: true)
    }
    
    @IBOutlet var map: MKMapView!
    @IBOutlet var tableView: UITableView!

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let locValue:CLLocationCoordinate2D = manager.location!.coordinate
        
        map.mapType = MKMapType.standard
        
        let span = MKCoordinateSpanMake(0.05, 0.05)
        let region = MKCoordinateRegion(center: locValue, span: span)
        map.setRegion(region, animated: true)
        
        let annotation = MKPointAnnotation()
        annotation.coordinate = locValue
        annotation.title = "Javed Multani"
        annotation.subtitle = "current location"
        map.addAnnotation(annotation)
        
        //centerMap(locValue)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        // For use in foreground
        self.locationManager.requestWhenInUseAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.startUpdatingLocation()
        }
        
        map.delegate = self
        map.mapType = .standard
        map.isZoomEnabled = true
        map.isScrollEnabled = true
        
        if let coor = map.userLocation.location?.coordinate{
            map.setCenter(coor, animated: true)
        }
        
        
        
        
        map.userTrackingMode = .follow
        centerMapOnLocation(location: initialLocation)

        let coordinate₁ = CLLocation(latitude: 51.5011524, longitude: -0.1262362)
        
        
        // meters distance
        let distanceInMeters = initialLocation.distance(from: coordinate₁)
        print(distanceInMeters)
        
        // add annotation
        let annotation = MKPointAnnotation()
        annotation.coordinate = CLLocationCoordinate2D(latitude: 51.5211524, longitude: -0.1262362)
        
        if (distanceInMeters < 200) {
//            annotation.pinTintColor = UIColor.Green
        }
        else if (distanceInMeters < 400) {
//            annotation.pinTintColor = UIColor.Yellow
        }
        else {
//            annotation.pinTintColor = UIColor.Red
        }
        
        map.addAnnotation(annotation)
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

class MapCell: UITableViewCell {
}

