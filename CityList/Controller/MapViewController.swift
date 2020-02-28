//
//  MapViewController.swift
//  CityList
//
//  Created by Elano on 27/02/20.
//  Copyright © 2020 Elano. All rights reserved.
//

import UIKit
import MapKit

final class MapViewController: UIViewController {

    private let name: String
    private let location: Location
    private let locationCoordinate: CLLocationCoordinate2D
    private var mapView: MKMapView = {
       
        let newMap = MKMapView(frame: .zero)
        
        newMap.mapType = .standard
        newMap.isZoomEnabled = true
        newMap.isScrollEnabled = true
        
        return newMap
    }()
    
    //MARK: -
    init(name: String, location: Location) {
        self.name = name
        self.location = location
        self.locationCoordinate = CLLocationCoordinate2DMake(location.latitude,
                                                             location.longitude)
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARk: -
    override func viewDidLoad() {
        super.viewDidLoad()

        setupMap()
        addPosition()
    }
    
    private func setupMap() {
        view.addSubview(mapView)
        
        mapView.fullAnchor(view: view)
        mapView.setCenter(locationCoordinate, animated: false)
    }

    private func addPosition() {
        let span = MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
        let region = MKCoordinateRegion(center: locationCoordinate, span: span)
        let annotation = MKPointAnnotation()
        
        annotation.coordinate = locationCoordinate
        annotation.title = name
        
        mapView.setRegion(region, animated: true)
        //annotation.subtitle = "current location"
        mapView.addAnnotation(annotation)
    }
}
