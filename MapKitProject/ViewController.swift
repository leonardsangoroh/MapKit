//
//  ViewController.swift
//  MapKit
//
//  Created by Lee Sangoroh on 16/02/2024.
//

import UIKit
import MapKit

class ViewController: UIViewController, MKMapViewDelegate {

    @IBOutlet var mapView: MKMapView!
    
    let mapTypes = ["hybrid": MKMapType.hybrid, "hybridFlyover": MKMapType.hybridFlyover, "mutedStandard": MKMapType.mutedStandard, "satellite": MKMapType.satellite, "satelliteFlyover": MKMapType.satelliteFlyover, "standard": MKMapType.standard]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        // Capital objects that conform to MKAnnotation protocol
        let london = Capital(title: "London", coordinate: CLLocationCoordinate2D(latitude: 51.507222, longitude: -0.1275), info: "Home to the 2012 Summer Olympics.")
        let oslo = Capital(title: "Oslo", coordinate: CLLocationCoordinate2D(latitude: 59.95, longitude: 10.75), info: "Founded over a thousand years ago.")
        let paris = Capital( title: "Paris", coordinate: CLLocationCoordinate2D(latitude: 48.8567, longitude: 2.3508), info: "Often called the City of Light.")
        let rome = Capital(title: "Rome", coordinate: CLLocationCoordinate2D(latitude: 41.9, longitude: 12.5), info: "Has a whole country inside it.")
        let washington = Capital(title: "Washington DC", coordinate: CLLocationCoordinate2D(latitude: 38.895111, longitude: -77.036667), info: "Named after George himself.")
        
        // send to map view for display
        mapView.addAnnotation(london)
        mapView.addAnnotation(oslo)
        mapView.addAnnotation(paris)
        mapView.addAnnotation(rome)
        mapView.addAnnotation(washington)
        //mapView.addAnnotations([london, oslo, paris, rome, washington])
        
        // right bar button item (for selecting map type)
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Map Type", style: .plain, target: self, action: #selector(setMapType))

    }
    
    @objc func setMapType(){
        let ac = UIAlertController(title: "Choose Map Type", message: nil, preferredStyle: .alert)
        ac.addTextField()
        
        let submitMapType = UIAlertAction(title: "Submit", style: .default) { [weak self, weak ac] _ in
            guard let mapType = ac?.textFields?[0].text else {return}
            
            self?.submit(mapType)
        }
        
        ac.addAction(submitMapType)
        present(ac, animated: true)
    }
    
    func submit(_ mapTypee: String) {
        
        for mapType in mapTypes {
            if mapType.key == mapTypee {
                mapView.mapType = mapType.value
            } else {
                mapView.mapType = MKMapType.mutedStandard
            }
        }
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        // 1 If the annotation isn't from a capital city, it must return nil so iOS uses a default view.
        guard annotation is Capital else { return nil }

        // 2 Define a reuse identifier. This is a string that will be used to ensure we reuse annotation views as much as possible.
        let identifier = "Capital"

        // 3 Try to dequeue an annotation view from the map view's pool of unused views.
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier) as? MKPinAnnotationView ?? nil

        
        if annotationView == nil {
            //4 If it isn't able to find a reusable view, create a new one using MKPinAnnotationView and sets its canShowCallout property to true. This triggers the popup with the city name.
            annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            annotationView?.canShowCallout = true
            annotationView?.pinTintColor = .black

            // 5 Create a new UIButton using the built-in .detailDisclosure type.
            let btn = UIButton(type: .detailDisclosure)
            annotationView?.rightCalloutAccessoryView = btn
        } else {
            // 6 Create a new UIButton using the built-in .detailDisclosure type.
            annotationView?.annotation = annotation
        }

        return annotationView
    }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        guard let capital = view.annotation as? Capital else { return }
        
        let vc = WebViewController()
        vc.placeName = capital.title
        vc.placeInfo = capital.info
        navigationController?.pushViewController(vc, animated: true)
        
    }


}

