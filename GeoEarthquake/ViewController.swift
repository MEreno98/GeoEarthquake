//
//  ViewController.swift
//  GeoEarthquake
//
//  Created by Mikel Ereño on 17/1/17.
//  Copyright © 2017 8FPROGMM11. All rights reserved.
//

import UIKit
import GoogleMaps

class ViewController: UIViewController, GMSMapViewDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let camera = GMSCameraPosition.camera(withLatitude: 35.895, longitude: -77.036, zoom: 4)
        let mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
        
        mapView.isMyLocationEnabled = true
        mapView.mapType = kGMSTypeTerrain
        mapView.delegate = self
        
        self.view = mapView
        
        let marker = GMSMarker()
        
        marker.position = CLLocationCoordinate2DMake(35.895, -77.036)
        
        marker.title = "Estados Unidos"
        marker.snippet = "Washington D. C."
        marker.map = mapView
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func mapView(_ mapView: GMSMapView, didTap marker: GMSMarker) -> Bool {
        //Navegar a la vista de detalle
        self.performSegue(withIdentifier: "show_detail", sender: marker)
        
        return true
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "show_detail"){
            //Obtener el ViewController del Detalle
            let destino = segue.destination as! DetailViewController
            
        }
    }

}

