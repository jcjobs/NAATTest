//
//  CResultWS.swift
//  NAATTest
//
//  Created by Juan Carlos Pérez D. on 10/2/17.
//  Copyright © 2017 Juan Carlos Pérez. All rights reserved.
//
import UIKit

class CResultWS: NSObject {
    
    var succes: String
    var errorNumber: String
    var errorDescripcion: String
    
    init(succes: String, errorNumber: String, errorDescripcion: String) {
        self.succes = succes
        self.errorNumber = errorNumber
        self.errorDescripcion = errorDescripcion
    }
    
}
