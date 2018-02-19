//
//  ViewController.swift
//  geofencing
//
//  Created by macbook on 19/01/18.
//  Copyright © 2018 macbook. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class ViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {

    @IBOutlet weak var mapKitView: MKMapView!
    let locationManager = CLLocationManager()
    override func viewDidLoad() {
        super.viewDidLoad()
        mapKitView.delegate = self
        mapKitView.showsScale = true
        mapKitView.showsUserLocation = true
        mapKitView.userTrackingMode = .followWithHeading
        
        locationManager.requestAlwaysAuthorization()
        
        if CLLocationManager.locationServicesEnabled(){
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.startUpdatingLocation()
        }
        
        //Reconocer gesto
        let uilpgr = UILongPressGestureRecognizer(target: self, action: #selector(longPress))
        uilpgr.minimumPressDuration = 2
        mapKitView.addGestureRecognizer(uilpgr)
    }
    
    @objc func longPress(gestureRecognizer: UIGestureRecognizer){
        let puntoPantalla = gestureRecognizer.location(in: self.mapKitView)
        let coordenadas = mapKitView.convert(puntoPantalla, toCoordinateFrom: self.mapKitView)
        let region = CLCircularRegion(center: coordenadas, radius: 400, identifier: "ID")
        locationManager.startMonitoring(for: region)
        let circulo = MKCircle(center: coordenadas, radius: region.radius)
        mapKitView.add(circulo)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        guard let circuloOverlay = overlay as? MKCircle else { return MKOverlayRenderer() }
        let circuloRender = MKCircleRenderer(circle: circuloOverlay)
        circuloRender.strokeColor = #colorLiteral(red: 0.8549019694, green: 0.250980407, blue: 0.4784313738, alpha: 1)
        circuloRender.fillColor = #colorLiteral(red: 0.9098039269, green: 0.4784313738, blue: 0.6431372762, alpha: 1)
        circuloRender.alpha = 0.5
        return circuloRender
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        locationManager.stopUpdatingLocation()
        mapKitView.showsUserLocation = true
    }
    
    func locationManager(_ manager: CLLocationManager, didEnterRegion region: CLRegion) {
        print("Entro a la region")
        let titulo = "Entraste a una region monitoreada"
        let mensaje = "Revisa las promociones"
        showAlert(title: titulo, message: mensaje)
    }
    
    func showAlert(title: String, message: String){
        let alerta = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "Ok", style: .default, handler: nil)
        alerta.addAction(action)
        present(alerta, animated: true, completion: nil)
    }


}

