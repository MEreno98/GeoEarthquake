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

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        if let terremoto = feature{
            l_place.text = terremoto.place
            tf_hora.value(forKey: terremoto.time)
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
