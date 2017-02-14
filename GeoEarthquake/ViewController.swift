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
import SystemConfiguration

class ViewController: UIViewController, GMSMapViewDelegate {

    
    var mapView : GMSMapView?
    var terremotos : [String:Feature] = [:]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //Generamos el punto desde donde queremos empezar a visualizar el mapa. (Mostramos America siempre y cuando no haya un punto.) 
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
        
        //Comprobar si tenemos conexión a internet
        if(connectedToNetwork()){
            //Procedemos a buscar los terremetos que han ocurrido.
            relizarBusqueda()
        }else{
            print("Sin conexión")
        }
        
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
       
        for terremoto in info["features"]{
            
            //Guardamos los parametros tanto de la longitud como la latitud de los puntos.
            let latitude = terremoto.1["geometry"]["coordinates"][1].doubleValue
            let longitude = terremoto.1["geometry"]["coordinates"][0].doubleValue
            
            //terremoto.0 almacena el indice de nuestro array.
            if (Int(terremoto.0) == 0){
                let camera = GMSCameraPosition.camera(withLatitude: latitude, longitude: longitude, zoom: 4)
                
                if let mapa = mapView{
                    mapa.camera=camera
                }
            }
            
            //Generamos un punto.
            let marker = GMSMarker()
            
            //Indicamos al punto en que posición lo queremos y con que título.
            marker.position = CLLocationCoordinate2DMake(latitude ,longitude)
            marker.title = terremoto.1["id"].stringValue
            
            //Le indicamos al punto que su mapa es el que nosotros queremos.
            marker.map = mapView
            
            //Después de generar la marca, guardo la información en una estructura.
            var terre = Feature()
            
            terre.mag = terremoto.1["properties"]["mag"].doubleValue
            terre.place = terremoto.1["properties"]["place"].stringValue
            //Generar una fecha.
            let fecha = Date.init(timeIntervalSince1970: terremoto.1["properties"]["time"].doubleValue/1000)
            
            let dateFormatter = DateFormatter()
            dateFormatter.dateStyle = .medium
            dateFormatter.timeStyle = .medium
            
            terre.time = dateFormatter.string(from: fecha)
            terre.alert = terremoto.1["properties"]["alert"].stringValue
            terre.tsunami = terremoto.1["properties"]["tsunami"].intValue
            terre.sig = terremoto.1["properties"]["sig"].intValue
            terre.nst = terremoto.1["properties"]["nst"].intValue
            terre.dmin = terremoto.1["properties"]["dmin"].intValue
            terre.type = terremoto.1["properties"]["type"].stringValue
            terre.longitude = terremoto.1["geometry"]["coordinates"][0].doubleValue
            terre.latitude = terremoto.1["geometry"]["coordinates"][1].doubleValue
            terre.depth = terremoto.1["geometry"]["coordinates"][2].doubleValue
            
            terremotos[terremoto.1["id"].stringValue] = terre
        }
        
        
        print(terremotos)
    }
    func connectedToNetwork() -> Bool {
        var zeroAddress = sockaddr_in()
        zeroAddress.sin_len = UInt8(MemoryLayout<sockaddr_in>.size)
        zeroAddress.sin_family = sa_family_t(AF_INET)
        
        guard let defaultRouteReachability = withUnsafePointer(to: &zeroAddress, {
            $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {
                SCNetworkReachabilityCreateWithAddress(nil, $0)
            }
        }) else {
            return false
        }
        
        var flags: SCNetworkReachabilityFlags = []
        if !SCNetworkReachabilityGetFlags(defaultRouteReachability, &flags) {
            return false
        }
        
        let isReachable = flags.contains(.reachable)
        let needsConnection = flags.contains(.connectionRequired)
        
        return (isReachable && !needsConnection)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "show_detail"){
            //Obtener el ViewController del Detalle
            let destino = segue.destination as! DetailViewController
            
            if let marker = sender {
                //print((marker as! GMSMarker).title!)
                if let l_terremostos = terremotos{
                    destino.feature = l_terremostos[(marker as! GMSMarker).title!]
                }
            }
            
            
        }
    }

}

