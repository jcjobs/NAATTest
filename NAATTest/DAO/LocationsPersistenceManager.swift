//
//  LocationsPersistenceManager.swift
//  NAATTest
//
//  Created by Juan Carlos Pérez D. on 10/2/17.
//  Copyright © 2017 Juan Carlos Pérez. All rights reserved.
//

import UIKit
import RealmSwift

class LocationsPersistenceManager: BaseDAO<RLocation, NSString> {
    
    func getAllLocations()->[RLocation]{
        return self.getAll().toArray(ofType: (RLocation.self) ) as [RLocation]
    }
    
}
