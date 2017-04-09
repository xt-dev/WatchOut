//
//  ViewController.swift
//  WatchOut!
//
//  Created by Derek Wu on 2017/4/8.
//  Copyright © 2017年 Xintong Wu. All rights reserved.
//

import UIKit
import Mapbox

//import Mapbox
//
//class ViewController: UIViewController {
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        
//        let mapView = MGLMapView(frame: view.bounds,
//                                 styleURL: MGLStyle.outdoorsStyleURL(withVersion: 9))
//        
//        // Tint the ℹ️ button and the user location annotation.
//        mapView.tintColor = .darkGray
//        
//        mapView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
//        
//        // Set the map’s center coordinate and zoom level.
//        mapView.setCenter(CLLocationCoordinate2D(latitude: 51.50713,
//                                                 longitude: -0.10957),
//                          zoomLevel: 13, animated: false)
//        view.addSubview(mapView)
//    }
//}

class ViewController: UIViewController, MGLMapViewDelegate {

    @IBOutlet var mapView: MGLMapView!
    
    //Annotation tap
    func mapView(_ mapView: MGLMapView, annotationCanShowCallout annotation: MGLAnnotation) -> Bool {
        // Always try to show a callout when an annotation is tapped.
        return true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        mapView.delegate = self
        
        let point = MGLPointAnnotation() //Define an annotation
        point.coordinate = CLLocationCoordinate2D(latitude: 45.52258, longitude: -122.6732)
        point.title = "Voodoo Doughnut"
        point.subtitle = "22 SW 3rd Avenue Portland Oregon, U.S.A."
    
        mapView.addAnnotation(point)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

