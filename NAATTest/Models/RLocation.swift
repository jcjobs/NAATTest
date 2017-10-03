//
//  RLocation.swift
//  NAATTest
//
//  Created by Juan Carlos Pérez D. on 10/2/17.
//  Copyright © 2017 Juan Carlos Pérez. All rights reserved.
//

import UIKit

import RealmSwift

class RLocation: Object {

    @objc dynamic var id = ""
    @objc dynamic var name = ""
    @objc dynamic var address = ""
    @objc dynamic var distance = 0.0
    @objc dynamic var lat = 0.0
    @objc dynamic var lng = 0.0
    
    override static func primaryKey() -> String? {
        return "id"
    }
    
    
}
