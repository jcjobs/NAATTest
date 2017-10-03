//
//  Config.swift
//  NAATTest
//
//  Created by Juan Carlos Pérez D. on 10/2/17.
//  Copyright © 2017 Juan Carlos Pérez. All rights reserved.
//

import UIKit
let SESSION_URL_SERVER = "https://maps.googleapis.com"
let SESSION_WS_EXTENSION = "/maps/api/place/nearbysearch/" //Segmento complementario de la URL en donde se encuentran alojados los WS

let DOCUMENTS_PATH = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]

let APP_SESSION_TIMEOUT = 54000.0 //Tiempo en segundos

let APP_NAME = "ABC"



let LOCATION_DEFAULT_LAT = 19.409737 //Tiempo en segundos
let LOCATION_DEFAULT_LNG = -99.169601 //Tiempo en segundos

class Config: NSObject {
}
