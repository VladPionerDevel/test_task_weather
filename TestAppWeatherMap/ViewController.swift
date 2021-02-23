//
//  ViewController.swift
//  TestAppWeatherMap
//
//  Created by pioner on 17.02.2021.
//

import UIKit
import MapKit
import CoreData

class ViewController: UIViewController {

    @IBOutlet weak var mapView: MKMapView!
    
    let placeWeatherHandler = PlaceWeatherCDHandler()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        setMap()
    }
    
    func setMap(){
        let initialLocation = CLLocation(latitude: 50.42882673575938, longitude: 30.51206386474074)
        let coordinateRegion = MKCoordinateRegion(center: initialLocation.coordinate, latitudinalMeters: 150000, longitudinalMeters: 150000)
        mapView.setRegion(coordinateRegion, animated: true)
        
        let cameraCenter = CLLocation(latitude: 50.42882673575938, longitude: 30.51206386474074)
        let region = MKCoordinateRegion(center: cameraCenter.coordinate, latitudinalMeters: 1500000, longitudinalMeters: 1500000)
        mapView.setCameraBoundary(MKMapView.CameraBoundary(coordinateRegion: region), animated: true)
        
        let zoomRage = MKMapView.CameraZoomRange(maxCenterCoordinateDistance: 5600000)
        mapView.setCameraZoomRange(zoomRage, animated: true)
        
        let gest = UITapGestureRecognizer(target: self, action: #selector(handlerPressTtt(gestureReconizer:)))
        self.mapView.addGestureRecognizer(gest)
    }

    @objc func handlerPressTtt(gestureReconizer: UITapGestureRecognizer){
        let touchPoint = gestureReconizer.location(in: mapView)
        let touchCoordinate = mapView.convert(touchPoint, toCoordinateFrom: self.mapView)
        
        // Add below code to get address for touch coordinates.
        let geoCoder = CLGeocoder()
        let location = CLLocation(latitude: touchCoordinate.latitude, longitude: touchCoordinate.longitude)
        geoCoder.reverseGeocodeLocation(location, completionHandler:
                                            { [self]
                placemarks, error -> Void in
                
                var nameFromMap = ""
                // Place details
                guard let placeMark = placemarks?.first else { return }

                // Location name
//                    if let locationName = placeMark.location {
//                        print(locationName)
//                    }
                // Street address
//                    if let street = placeMark.thoroughfare {
//                        print(street)
//                    }
                // City
                if let city = placeMark.subAdministrativeArea {
                    nameFromMap = city
                }
                // Zip code
//                    if let zip = placeMark.isoCountryCode {
//                        print(zip)
//                    }
                // Country
                if let country = placeMark.country {
                    nameFromMap = country + " " + nameFromMap
                }
                          
                self.toWeatherLocalVC(latitude: Float(touchCoordinate.latitude), longitude: Float(touchCoordinate.longitude), nameFromMap: nameFromMap)
        })
    }
    
    func toWeatherLocalVC(latitude: Float!, longitude: Float!, nameFromMap: String){
        guard let vc = storyboard?.instantiateViewController(identifier: String(describing: WeatherLocalViewController.self)) as? WeatherLocalViewController else {return}
        
        vc.latitude = latitude
        vc.longitude = longitude
        vc.nameFromMap = nameFromMap
        
        navigationController?.pushViewController(vc, animated: true)
    }

}

