//
//  Capital.swift
//  MapKitProject
//
//  Created by Lee Sangoroh on 16/02/2024.
//

import UIKit
// import because MKAnnotation & CLLocationCoordinate2D are defined in MapKit
import MapKit

class Capital: NSObject, MKAnnotation {
    var title: String?
    var coordinate: CLLocationCoordinate2D
    var info: String
    
    init(title: String, coordinate: CLLocationCoordinate2D, info: String) {
        self.title = title
        self.coordinate = coordinate
        self.info = info
    }
}
