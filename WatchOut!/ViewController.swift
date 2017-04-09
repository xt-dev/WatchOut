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

class ViewController: UIViewController, MGLMapViewDelegate, UISearchBarDelegate {

    @IBOutlet weak var topView: UIView!
    @IBOutlet var mapView: MGLMapView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    
    
    //Annotation tap
    func mapView(_ mapView: MGLMapView, annotationCanShowCallout annotation: MGLAnnotation) -> Bool {
        // Always try to show a callout when an annotation is tapped.
        return true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view, typically from a nib.
        displayTopView();
        displaySearchbar();
        displayCord();
        mapView.delegate = self;
        searchBar.delegate = self;

        view.addSubview(mapView);
        view.addSubview(topView);
        view.addSubview(searchBar);
    }
    
    func searchBarSearchButtonClicked( _ searchBar: UISearchBar)
    {
        print(searchBar.text ?? "hahaha");
    }
    
    func displayTopView(){
        topView.backgroundColor = UIColor.green.withAlphaComponent(0.7);
    }
    
    func displayCord(){
        let point = MGLPointAnnotation(); //Define an annotation
        point.coordinate = CLLocationCoordinate2D(latitude: 40.6331, longitude: -89.3985);
        point.title = "Voodoo Doughnut";
        point.subtitle = "22 SW 3rd Avenue Portland Oregon, U.S.A.";
        
        mapView = MGLMapView(frame: view.bounds);
        mapView.autoresizingMask = [.flexibleWidth, .flexibleHeight];
        
        mapView.setCenter(CLLocationCoordinate2D(latitude: 40.6331, longitude: -89.3985), zoomLevel: 11, animated: false);
        mapView.addAnnotation(point);
    }
    
    func displaySearchbar(){
        searchBar.showsCancelButton = false;
        searchBar.placeholder = "type something...";
    }
    
    override func viewDidAppear(_ animated: Bool) {
        // Draw the polygon after the map has initialized
        drawShape()
    }
    
    func drawShape() {
        // Create a coordinates array to hold all of the coordinates for our shape.
        var coordinates = [
            CLLocationCoordinate2D(latitude: 42.5116, longitude: -90.6290),
            CLLocationCoordinate2D(latitude: 42.4924, longitude: -87.0213),
            CLLocationCoordinate2D(latitude: 41.7641, longitude: -87.2067),
            CLLocationCoordinate2D(latitude: 41.7611, longitude: -87.5226),
            CLLocationCoordinate2D(latitude: 39.6417, longitude: -87.5336),
            CLLocationCoordinate2D(latitude: 39.3566, longitude: -87.5308),
            CLLocationCoordinate2D(latitude: 39.1386, longitude: -87.6517),
            CLLocationCoordinate2D(latitude: 38.9445, longitude: -87.5157),
            CLLocationCoordinate2D(latitude: 38.7294, longitude: -87.5047),
            CLLocationCoordinate2D(latitude: 38.6115, longitude: -87.6146),
            CLLocationCoordinate2D(latitude: 38.4944, longitude: -87.6544),
            CLLocationCoordinate2D(latitude: 38.3740, longitude: -87.7780),
            CLLocationCoordinate2D(latitude: 38.2856, longitude: -87.8371),
            CLLocationCoordinate2D(latitude: 38.2414, longitude: -87.9758),
            CLLocationCoordinate2D(latitude: 38.1454, longitude: -87.9291),
            CLLocationCoordinate2D(latitude: 37.9788, longitude: -88.0225),
            CLLocationCoordinate2D(latitude: 37.8900, longitude: -88.0458),
            CLLocationCoordinate2D(latitude: 37.7881, longitude: -88.0321),
            CLLocationCoordinate2D(latitude: 37.6349, longitude: -88.1529),
            CLLocationCoordinate2D(latitude: 37.5097, longitude: -88.0609),
            CLLocationCoordinate2D(latitude: 37.4149, longitude: -88.4152),
            CLLocationCoordinate2D(latitude: 37.2828, longitude: -88.5086),
            CLLocationCoordinate2D(latitude: 37.1428, longitude: -88.4221),
            CLLocationCoordinate2D(latitude: 37.0585, longitude: -88.4990),
            CLLocationCoordinate2D(latitude: 37.1428, longitude: -88.7256),
            CLLocationCoordinate2D(latitude: 37.2128, longitude: -88.9453),
            CLLocationCoordinate2D(latitude: 37.1559, longitude: -89.0689),
            CLLocationCoordinate2D(latitude: 37.0376, longitude: -89.1650),
            CLLocationCoordinate2D(latitude: 36.9894, longitude: -89.2873),
            CLLocationCoordinate2D(latitude: 37.1505, longitude: -89.4356),
            CLLocationCoordinate2D(latitude: 37.2762, longitude: -89.5345),
            CLLocationCoordinate2D(latitude: 37.3996, longitude: -89.4315),
            CLLocationCoordinate2D(latitude: 37.6936, longitude: -89.5358),
            CLLocationCoordinate2D(latitude: 37.9767, longitude: -89.9670),
            CLLocationCoordinate2D(latitude: 38.2587, longitude: -90.3790),
            CLLocationCoordinate2D(latitude: 38.6169, longitude: -90.2376),
            CLLocationCoordinate2D(latitude: 38.7573, longitude: -90.1744),
            CLLocationCoordinate2D(latitude: 38.8247, longitude: -90.1167),
            CLLocationCoordinate2D(latitude: 38.8846, longitude: -90.1799),
            CLLocationCoordinate2D(latitude: 38.9680, longitude: -90.4504),
            CLLocationCoordinate2D(latitude: 38.8654, longitude: -90.5905),
            CLLocationCoordinate2D(latitude: 39.0405, longitude: -90.7086),
            CLLocationCoordinate2D(latitude: 39.2301, longitude: -90.7306),
            CLLocationCoordinate2D(latitude: 39.3173, longitude: -90.8350),
            CLLocationCoordinate2D(latitude: 39.3853, longitude: -90.9338),
            CLLocationCoordinate2D(latitude: 39.5559, longitude: -91.1398),
            CLLocationCoordinate2D(latitude: 39.7262, longitude: -91.3554),
            CLLocationCoordinate2D(latitude: 39.8570, longitude: -91.4406),
            CLLocationCoordinate2D(latitude: 39.9940, longitude: -91.4941),
            CLLocationCoordinate2D(latitude: 40.1694, longitude: -91.5120),
            CLLocationCoordinate2D(latitude: 40.3497, longitude: -91.4667),
            CLLocationCoordinate2D(latitude: 40.4166, longitude: -91.3939),
            CLLocationCoordinate2D(latitude: 40.5566, longitude: -91.4021),
            CLLocationCoordinate2D(latitude: 40.6265, longitude: -91.2524),
            CLLocationCoordinate2D(latitude: 40.6963, longitude: -91.1151),
            CLLocationCoordinate2D(latitude: 40.8232, longitude: -91.0890),
            CLLocationCoordinate2D(latitude: 40.9312, longitude: -90.9792),
            CLLocationCoordinate2D(latitude: 41.1642, longitude: -91.0162),
            CLLocationCoordinate2D(latitude: 41.2355, longitude: -91.1055),
            CLLocationCoordinate2D(latitude: 41.4170, longitude: -91.0368),
            CLLocationCoordinate2D(latitude: 41.4458, longitude: -90.8487),
            CLLocationCoordinate2D(latitude: 41.4417, longitude: -90.7251),
            CLLocationCoordinate2D(latitude: 41.5816, longitude: -90.3516),
            CLLocationCoordinate2D(latitude: 41.7713, longitude: -90.2637),
            CLLocationCoordinate2D(latitude: 41.9023, longitude: -90.1538),
            CLLocationCoordinate2D(latitude: 42.0819, longitude: -90.1758),
            CLLocationCoordinate2D(latitude: 42.2021, longitude: -90.3598),
            CLLocationCoordinate2D(latitude: 42.2936, longitude: -90.4395),
            CLLocationCoordinate2D(latitude: 42.4032, longitude: -90.5356),
            CLLocationCoordinate2D(latitude: 42.4843, longitude: -90.6564)
        ]
        
        
        
        let shape = MGLPolygon(coordinates: &coordinates, count: UInt(coordinates.count))
        
        mapView.addAnnotation(shape);
    }
    
    func mapView(_ mapView: MGLMapView, alphaForShapeAnnotation annotation: MGLShape) -> CGFloat {
        return 0.5
    }
    func mapView(_ mapView: MGLMapView, strokeColorForShapeAnnotation annotation: MGLShape) -> UIColor {
        return .white
    }
    
    func mapView(_ mapView: MGLMapView, fillColorForPolygonAnnotation annotation: MGLPolygon) -> UIColor {
        return UIColor(red: 59/255, green: 178/255, blue: 208/255, alpha: 1)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

