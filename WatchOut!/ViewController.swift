//
//  ViewController.swift
//  WatchOut!
//
//  Created by Derek Wu on 2017/4/8.
//  Copyright © 2017年 Xintong Wu. All rights reserved.
//

import UIKit
import Mapbox
import MapboxGeocoder

var cur_lat = 0.0
var cur_lon = 0.0
var r_ = 50


class ViewController: UIViewController, MGLMapViewDelegate, UISearchBarDelegate{

    @IBOutlet var mapView: MGLMapView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var topView: UIView!
    
//    let geocoder = Geocoder(accessToken: "pk.eyJ1IjoibGlnaHRtb25zdGVyIiwiYSI6ImNqMTU5bGpvcjAwdHMzMnF1aTRnaDEzdGkifQ.06oBuWTqcG6SdyJjFD7trg")
    

    //Add subview
    func addBottomSheetView() {
        // 1- Init bottomSheetVC
        let bottomSheetVC = BottomSheetViewController();
        
        
        // 2- Add bottomSheetVC as a child view
        self.addChildViewController(bottomSheetVC)
        self.view.addSubview(bottomSheetVC.view)
        bottomSheetVC.didMove(toParentViewController: self)
        
        // 3- Adjust bottomSheet frame and initial position.
        let height = view.frame.height
        let width  = view.frame.width
        bottomSheetVC.view.frame = CGRect(x: 0, y: self.view.frame.maxY, width: width, height: height)
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
//        mapView.delegate = self
        
//        let point = MGLPointAnnotation() //Define an annotation
//        point.coordinate = CLLocationCoordinate2D(latitude: 45.52258, longitude: -122.6732)
//        point.title = "Voodoo Doughnut"
//        point.subtitle = "22 SW 3rd Avenue Portland Oregon, U.S.A."
        
        
        displayTopView();
        displaySearchbar();
        
        
//        mapView = MGLMapView(frame: view.bounds)
        let styleURL = URL(string: "mapbox://styles/lightmonster/cj1aucwe8005b2ro790v2gtrv")
        mapView = MGLMapView(frame: view.bounds,
                                 styleURL: styleURL as URL?)
        mapView.autoresizingMask = [.flexibleWidth, .flexibleHeight]

        
        // Specify coordinates for our annotations.
        
        let coordinates = [
            CLLocationCoordinate2D(latitude: 36.7783, longitude: -119.4179),

            ]
        
        // Fill an array with point annotations and add it to the map.
        var pointAnnotations = [MGLPointAnnotation]()
        for coordinate in coordinates {
            let point = MGLPointAnnotation()
            point.coordinate = coordinate
            //            point.title = "\(coordinate.latitude), \(coordinate.longitude)"
            point.title = "36.7783, -119.4179"
            pointAnnotations.append(point)
        }
        
        mapView.setCenter(CLLocationCoordinate2D(latitude: 36.7783, longitude: -119.4179), zoomLevel: 5, animated: false);
        
        //init
        cur_lat = 36.7783
        cur_lon = -119.4179
        
        
        mapView.addAnnotations(pointAnnotations);

        mapView.delegate = self;
        searchBar.delegate = self;
        
        polygonCircleForCoordinate(coordinate: CLLocationCoordinate2D(latitude: 36.7783, longitude: -119.4179), withMeterRadius: 80000);

        
        view.addSubview(mapView);
        view.addSubview(topView);
        view.addSubview(searchBar);
        addBottomSheetView();
    }
    
    //====================Main====================
    func searchBarSearchButtonClicked( _ searchBar: UISearchBar)
    {
        let lat = searchBar.text?.components(separatedBy: ",")[0]
        let lon = searchBar.text?.components(separatedBy: ",")[1]
        let rad = searchBar.text?.components(separatedBy: ",")[2]

        let coord = CLLocationCoordinate2D(latitude: Double(lat!)!, longitude: Double(lon!)!)
        mapView.setCenter(coord, zoomLevel: 5, animated: true);
        polygonCircleForCoordinate(coordinate: coord, withMeterRadius: Double(rad!)! * 1609.34);
        let point = MGLPointAnnotation()
        point.coordinate = coord
        point.title = "\(coord.latitude), \(coord.longitude)"
        cur_lat = Double(lat!)!
        cur_lon = Double(lon!)!
        r_ = Int(Double(rad!)!)
        mapView.addAnnotation(point)
        
        
    }
    
    func polygonCircleForCoordinate(coordinate: CLLocationCoordinate2D, withMeterRadius: Double) {
        let degreesBetweenPoints = 8.0
        //45 sides
        let numberOfPoints = floor(360.0 / degreesBetweenPoints)
        let distRadians: Double = withMeterRadius / 6371000.0
        // earth radius in meters
        let centerLatRadians: Double = coordinate.latitude * Double.pi/180;
        let centerLonRadians: Double = coordinate.longitude * Double.pi/180;
        var coordinates = [CLLocationCoordinate2D]()
        //array to hold all the points
        for index in 0 ..< Int(numberOfPoints) {
            let degrees: Double = Double(index) * Double(degreesBetweenPoints)
            let degreeRadians: Double = degrees * Double.pi / 180;
            let pointLatRadians: Double = asin(sin(centerLatRadians) * cos(distRadians) + cos(centerLatRadians) * sin(distRadians) * cos(degreeRadians))
            let pointLonRadians: Double = centerLonRadians + atan2(sin(degreeRadians) * sin(distRadians) * cos(centerLatRadians), cos(distRadians) - sin(centerLatRadians) * sin(pointLatRadians))
            let pointLat: Double = pointLatRadians * 180 / Double.pi;
            let pointLon: Double = pointLonRadians * 180 / Double.pi;
            let point: CLLocationCoordinate2D = CLLocationCoordinate2DMake(pointLat, pointLon)
            coordinates.append(point)
        }
        let polygon = MGLPolygon(coordinates: &coordinates, count: UInt(coordinates.count))
        
        self.mapView.addAnnotation(polygon)
    }
    
    func displayTopView(){
        topView.backgroundColor = UIColor.white.withAlphaComponent(0.7);
    }
    
    
    func displaySearchbar(){
        searchBar.showsCancelButton = false;
        searchBar.placeholder = "type something...";
    }

    
    
    // This delegate method is where you tell the map to load a view for a specific annotation. To load a static MGLAnnotationImage, you would use `-mapView:imageForAnnotation:`.
//    func mapView(_ mapView: MGLMapView, viewFor annotation: MGLAnnotation) -> MGLAnnotationView? {
//        // This example is only concerned with point annotations.
//        
//        
////        guard annotation is MGLPointAnnotation else {
////            return nil
////        }
////        
//        // Use the point annotation’s longitude value (as a string) as the reuse identifier for its view.
//        let reuseIdentifier = "\(annotation.coordinate.longitude)"
//        
//        // For better performance, always try to reuse existing annotations.
//        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: reuseIdentifier)
//        
//        // If there’s no reusable annotation view available, initialize a new one.
//        if annotationView == nil {
//            annotationView = CustomAnnotationView(reuseIdentifier: reuseIdentifier)
//            annotationView!.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
//            
//            // Set the annotation view’s background color to a value determined by its longitude.
//            let hue = CGFloat(annotation.coordinate.longitude) / 100
//            annotationView!.backgroundColor = UIColor(hue: hue, saturation: 0.5, brightness: 1, alpha: 1)
//        }
//        
//        return annotationView
//    }
    
    func mapView(_ mapView: MGLMapView, annotationCanShowCallout annotation: MGLAnnotation) -> Bool {
        return true
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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

    
}

//
// MGLAnnotationView subclass
//class CustomAnnotationView: MGLAnnotationView {
//    override func layoutSubviews() {
//        super.layoutSubviews()
//        
//        // Force the annotation view to maintain a constant size when the map is tilted.
//        scalesWithViewingDistance = false
//        
//        // Use CALayer’s corner radius to turn this view into a circle.
//        layer.cornerRadius = frame.width / 2
//        layer.borderWidth = 2
//        layer.borderColor = UIColor.white.cgColor
//    }
//    
//    override func setSelected(_ selected: Bool, animated: Bool) {
//        super.setSelected(selected, animated: animated)
//        
//        // Animate the border width in/out, creating an iris effect.
//        let animation = CABasicAnimation(keyPath: "borderWidth")
//        animation.duration = 0.1
//        layer.borderWidth = selected ? frame.width / 4 : 2
//        layer.add(animation, forKey: "borderWidth")
//    }
//}





