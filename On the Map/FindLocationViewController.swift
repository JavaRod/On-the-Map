//
//  FindLocationViewController.swift
//  On the Map
//
//  Created by Rodrick Musser on 8/24/16.
//  Copyright © 2016 RodCo. All rights reserved.
//

import Foundation
import UIKit
import MapKit


class FindLocationViewController: UIViewController {
    

    
    var appDelegate: AppDelegate!
    


    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var centerView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var locationText: UITextField!
    @IBOutlet weak var bottomButton: UIButton!
    
    @IBOutlet weak var bottomView: UIView!
    @IBOutlet weak var mapView: MKMapView!
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
  
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        

        //titleLabel.backgroundColor = UIColor.clearColor()
        titleLabel.numberOfLines = 3
        titleLabel.textAlignment = .Center
        
        // get the app delegate
        appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
 
        let labelText = createAttributedString("Where are you \n", font: UIFont(name: "Roboto-Thin", size: 20)!, color: UIColor.blueColor())
        labelText.appendAttributedString(createAttributedString("studying \n", font: UIFont(name: "Roboto-Medium", size: 20)!, color: UIColor.blueColor()))
        labelText.appendAttributedString(createAttributedString("today?", font: UIFont(name: "Roboto-Thin", size: 20)!, color: UIColor.blueColor()))
        
        
        titleLabel.attributedText = labelText
        titleLabel.textAlignment = NSTextAlignment.Center
        titleLabel.sizeToFit()

    }
    
    
    func createAttributedString(string: String, font: UIFont, color: UIColor) -> NSMutableAttributedString {
        
        let attrs = [NSFontAttributeName: font, NSForegroundColorAttributeName: color]
        return NSMutableAttributedString(string: string, attributes: attrs)
        
    }
    
    override func viewWillAppear(animated: Bool) {
        
        super.viewWillAppear(animated)
        
        bottomButton.contentEdgeInsets = UIEdgeInsetsMake(5,10,5,10)
        bottomButton.layer.cornerRadius = 5
        bottomButton.setTitle("Find on the Map", forState: UIControlState.Normal)
        bottomButton.sizeToFit()
        
        mapView.hidden = true
        activityIndicator.hidden = true
       
        
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
       // self.navigationController!.navigationBar.frame = CGRectMake(0, 0, self.view.frame.size.width, 160.0)
    }
    
    @IBAction func bottomButton(sender: AnyObject) {
        
        startActivityIndicator()
        
        forwardGeocoding(locationText.text!)
        
        stopActivityIndicator()
        
        mapView.hidden = false
        locationText.hidden = true
        bottomView.backgroundColor = UIColor.clearColor()
        bottomView.opaque = false
        bottomButton.setTitle("Submit", forState: UIControlState.Normal)
        bottomButton.sizeToFit()

        
        
    }
    
    //Code from: http://mhorga.org/2015/08/14/geocoding-in-ios.html
    func forwardGeocoding(address: String) {
        CLGeocoder().geocodeAddressString(address, completionHandler: { (placemarks, error) in
            if error != nil {
                print(error)
                return
            }
            if placemarks?.count > 0 {
                let placemark = placemarks?[0]
                let location = placemark?.location
                let coordinate = location?.coordinate
                print("\nlat: \(coordinate!.latitude), long: \(coordinate!.longitude)")
                
                // We will create an MKPointAnnotation for each dictionary in "locations". The
                // point annotations will be stored in this array, and then provided to the map view.
                var annotations = [MKPointAnnotation]()
                
                // The "locations" array is loaded with the sample data below. We are using the dictionaries
                // to create map annotations. This would be more stylish if the dictionaries were being
                // used to create custom structs. Perhaps StudentLocation structs.
                
                    
                    // Notice that the float values are being used to create CLLocationDegree values.
                    // This is a version of the Double type.
                    let lat = coordinate!.latitude
                    let long = coordinate!.longitude
                    
                    // The lat and long are used to create a CLLocationCoordinates2D instance.
                    let coordinate2D = CLLocationCoordinate2D(latitude: lat, longitude: long)
                    
//                    let first = dictionary["firstName"] as! String
//                    let last = dictionary["lastName"] as! String
//                    let mediaURL = dictionary["mediaURL"] as! String
                
                    // Here we create the annotation and set its coordiate, title, and subtitle properties
                    let annotation = MKPointAnnotation()
                    annotation.coordinate = coordinate2D
//                    annotation.title = "\(first) \(last)"
//                    annotation.subtitle = mediaURL
                
                    // Finally we place the annotation in an array of annotations.
                    annotations.append(annotation)
       
                
                // When the array is complete, we add the annotations to the map.
                self.mapView.addAnnotations(annotations)
                
                let coordinateRegion = MKCoordinateRegionMakeWithDistance(coordinate2D, 2000, 2000)
                self.mapView.setRegion(coordinateRegion, animated: true)
                self.centerView.alpha = 1
                
//                if placemark?.areasOfInterest?.count > 0 {
//                    let areaOfInterest = placemark!.areasOfInterest![0]
//                    print(areaOfInterest)
//                } else {
//                    print("No area of interest found.")
//                }
            }
        })
    }
    
    func startActivityIndicator() {
        
        dispatch_async(dispatch_get_main_queue()) {
            for subView in self.view.subviews {
                subView.alpha = 0.3
            }
            
            self.activityIndicator.hidden = false
            self.activityIndicator.startAnimating()
            
        }
    }
    
    func stopActivityIndicator() {
        
        dispatch_async(dispatch_get_main_queue()) {
            for subView in self.view.subviews {
                subView.alpha = 1
            }
            
            self.activityIndicator.hidden = true
            self.activityIndicator.stopAnimating()
            
        }
    }
    
}