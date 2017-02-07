//
//  ViewController.swift
//  GeoEarthquake
//
//  Created by Mikel Ereño on 17/1/17.
//  Copyright © 2017 8FPROGMM11. All rights reserved.
//

import UIKit
import GoogleMaps
import Alamofire
import SwiftyJSON

class ViewController: UIViewController, GMSMapViewDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        

        relizarBusqueda()
        
        let camera = GMSCameraPosition.camera(withLatitude: -33.86, longitude: 151.20, zoom: 6)

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
    func relizarBusqueda(){
        Alamofire.request("http://earthquake.usgs.gov/earthquakes/feed/v1.0/summary/all_hour.geojson").responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                print(json)
                
            self.generar_marcas(informacion: json)
                
            case .failure(let error):
                print(error)
            }
        }
    }
    func generar_marcas(informacion info:JSON ){
       
    }

}

