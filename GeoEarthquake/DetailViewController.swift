//
//  DetailViewController.swift
//  GeoEarthquake
//
//  Created by Mikel Ereño on 24/1/17.
//  Copyright © 2017 8FPROGMM11. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    var feature : Feature?
    @IBOutlet weak var l_place: UILabel!
    @IBOutlet weak var tf_hora: UITextField!
    @IBOutlet weak var tf_aviso: UITextField!
    @IBOutlet weak var tf_tsunami: UITextField!
    @IBOutlet weak var tf_sig: UITextField!
    @IBOutlet weak var tf_longuitud: UITextField!
    @IBOutlet weak var tf_latitud: UITextField!
    @IBOutlet weak var tf_profundidad: UITextField!
    @IBOutlet weak var tf_tipo: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        if let terremoto = feature{
            l_place.text = terremoto.place
            tf_tipo.text = terremoto.type
            tf_hora.text = terremoto.time
            tf_aviso.text = String(terremoto.alert)
            tf_tsunami.text = String(terremoto.tsunami)
            tf_sig.text = String(terremoto.sig)
            tf_longuitud.text = String(terremoto.longitude)
            tf_latitud.text = String(terremoto.latitude)
            tf_profundidad.text = String(terremoto.depth)
            
        }
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

}
