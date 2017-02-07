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

    
    var mapView : GMSMapView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //Generamos el punto desde donde queremos empezar a visualizar el mapa.
        let camera = GMSCameraPosition.camera(withLatitude: 35.895, longitude: -77.036, zoom: 4)
        
        //Generamos el mapa con la camara indicaca.
        mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)

        //Propiedades del mapa.
        
        if let mapa = mapView{
            mapa.isMyLocationEnabled = true
            mapa.mapType = kGMSTypeTerrain
            mapa.delegate = self
            
            self.view = mapa
        }
        
        //Procedemos a buscar los terremetos que han ocurrido.
        relizarBusqueda()
        
        //let marker = GMSMarker()
        
        //marker.position = CLLocationCoordinate2DMake(35.895, -77.036)
        
        //marker.title = "Estados Unidos"
        //marker.snippet = "Washington D. C."
        //marker.map = mapView
        
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
                //La petición me devuelve un JSON, el cual guardo para su posterior procesamiento.
                let info_terremetos = JSON(value)
                //Generar_marcas es el encargado de colocar los puntos en nuestro mapa.
                self.generar_marcas(informacion: info_terremetos)
                
            case .failure(let error):
                print(error)
            }
        }
    }
    func generar_marcas(informacion info:JSON ){
       
        for terremeto in info{
            print(terremeto)
        }
    }

}

