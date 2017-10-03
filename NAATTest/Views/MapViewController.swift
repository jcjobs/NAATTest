//
//  MapViewController.swift
//  NAATTest
//
//  Created by Juan Carlos Pérez D. on 10/2/17.
//  Copyright © 2017 Juan Carlos Pérez. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController {

    @IBOutlet weak var mapView: MKMapView!
    
    var selectedLocation : RLocation?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        mapView.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.removeNavigationBar()
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        
        
        //Ubicación default
        let annotation = MKPointAnnotation()
        annotation.coordinate = CLLocationCoordinate2D(latitude: selectedLocation!.lat, longitude: selectedLocation!.lng)
        annotation.title = selectedLocation?.name
        annotation.subtitle = selectedLocation?.address
        mapView.addAnnotation(annotation)
        
        
        let defaultAnnotation = MKPointAnnotation()
        defaultAnnotation.coordinate = CLLocationCoordinate2D(latitude: LOCATION_DEFAULT_LAT, longitude: LOCATION_DEFAULT_LNG)
        defaultAnnotation.title = "Ubicación Default"
        defaultAnnotation.subtitle = "Ubicación a partir de la que se mide la distancia del punto seleccionado previamente"
        mapView.addAnnotation(defaultAnnotation)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        //Centrar el mapa en la ubicacion Default
        let initialLocation = CLLocation(latitude: LOCATION_DEFAULT_LAT, longitude: LOCATION_DEFAULT_LNG)
        centerMapOnLocation(location: initialLocation)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    internal func removeNavigationBar() {
        let nav = self.navigationController?.navigationBar
        if let subviews = nav?.subviews {
            for subView in subviews {
                if(subView.tag != 0){
                    subView.removeFromSuperview()
                }
            }
        }
    }
    
    
    func centerMapOnLocation(location: CLLocation) {
        let center = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
        let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.03, longitudeDelta: 0.03))

        mapView.setRegion(region, animated: true)
    }

}


extension MapViewController : MKMapViewDelegate{
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView)
    {
        if let annotationTitle = view.annotation?.title
        {
            print("Titulo del pin seleccionado \(annotationTitle!)")
        }
    }
}
