//
//  Feature.swift
//  GeoEarthquake
//
//  Created by Mikel Ereño on 7/2/17.
//  Copyright © 2017 8FPROGMM11. All rights reserved.
//

import Foundation

struct Feature {
    var mag: Decimal
    var place: String
    var time: NSDate
    var alert: String
    var tsunami: Int
    var sig: Int
    var nst: Int
    var dmin: Int
    var type: String
    var longitude: Decimal
    var latitude: Decimal
    var depth : Decimal
    
}
