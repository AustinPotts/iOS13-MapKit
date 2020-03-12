//
//  EarthquakesViewController.swift
//  Quakes
//
//  Created by Paul Solt on 10/3/19.
//  Copyright © 2019 Lambda, Inc. All rights reserved.
//

import UIKit
import MapKit

class EarthquakesViewController: UIViewController {
    
    private var quakeFetcher = QuakeFetcher()
		
	// NOTE: You need to import MapKit to link to MKMapView
	@IBOutlet var mapView: MKMapView!
	
	override func viewDidLoad() {
		super.viewDidLoad()
        
        
        mapView.delegate = self
        mapView.register(MKMarkerAnnotationView.self, forAnnotationViewWithReuseIdentifier: "Quakeview")
        
        quakeFetcher.fetchQuakes { (quakes, error) in
            if let error = error {
                print("Error fetching quakes \(error)")
                return
            }
            guard let quakes = quakes else {return}
            print("quakes \(quakes.count)")
            
            DispatchQueue.main.async {
                self.mapView.addAnnotations(quakes)
                
                //zoom to the first earthquake (sorted largest first)
                
                guard let quake = quakes.first else { return } //TODO Zoom to current user position
                
                let coordinateSpan = MKCoordinateSpan(latitudeDelta: 2, longitudeDelta: 2)
                let region = MKCoordinateRegion(center: quake.coordinate, span: coordinateSpan)
                
                self.mapView.setRegion(region, animated: true)
                
            }
        }
		
	}
}

extension EarthquakesViewController: MKMapViewDelegate {
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard let quake = annotation as? Quake else {
            fatalError("Only quake objects are currently supported")
        }
        
        guard let annotationview = mapView.dequeueReusableAnnotationView(withIdentifier: "QuakeView", for: annotation) as? MKMarkerAnnotationView else {
            fatalError("Missing a registered map kit view")
        }
        
        annotationview.glyphImage = UIImage(named: "QuakeIcon")
        return annotationview
        
    }
    
}
