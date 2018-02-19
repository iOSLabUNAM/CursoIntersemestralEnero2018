//
//  ViewController.swift
//  direcciones
//
//  Created by macbook on 19/01/18.
//  Copyright © 2018 macbook. All rights reserved.
//

import UIKit
import MapKit

class ViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {
    
    
    @IBOutlet weak var mapKitView: MKMapView!
    
    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mapKitView.delegate = self
        mapKitView.showsScale = true
        mapKitView.showsUserLocation = true
        mapKitView.userTrackingMode = .followWithHeading
        
        locationManager.requestWhenInUseAuthorization()
        
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
    
    //Se encarga de trazar la ruta
    @objc func longPress(gestureRecognizer: UIGestureRecognizer){
        let puntoPantalla = gestureRecognizer.location(in: self.mapKitView)
        let coordenadas = mapKitView.convert(puntoPantalla, toCoordinateFrom: self.mapKitView)
        
        let anotacion = MKPointAnnotation()
        anotacion.title = "Titulo Punto"
        anotacion.subtitle = "Subtitulo"
        anotacion.coordinate = coordenadas
        mapKitView.addAnnotation(anotacion)
        
        guard let coordenadasUsuario = locationManager.location?.coordinate else { return }
        let coordenadasDestino = coordenadas
        
        let origenPlaceMark = MKPlacemark(coordinate: coordenadasUsuario)
        let destinoPlaceMark = MKPlacemark(coordinate: coordenadasDestino)
        
        let origenItem = MKMapItem(placemark: origenPlaceMark)
        let destinoItem = MKMapItem(placemark: destinoPlaceMark)
        
        let requestDirecciones = MKDirectionsRequest()
        requestDirecciones.source = origenItem
        requestDirecciones.destination = destinoItem
        requestDirecciones.transportType = .walking
        
        let direcciones = MKDirections(request: requestDirecciones)
        direcciones.calculate { (respuesta, error) in
            guard let respuesta = respuesta else {
                print("Ocurrio un error")
                return
            }
            let ruta = respuesta.routes[0]
            self.mapKitView.add(ruta.polyline, level: .aboveRoads)
            
            let rectangulo = ruta.polyline.boundingMapRect
            self.mapKitView.setRegion(MKCoordinateRegionForMapRect(rectangulo), animated: true)
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        let render = MKPolylineRenderer(overlay: overlay)
        render.strokeColor = #colorLiteral(red: 0.2745098174, green: 0.4862745106, blue: 0.1411764771, alpha: 1)
        render.lineWidth = 5.0
        return render
    }


}

