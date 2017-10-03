//
//  BaseDAO.swift
//  NAATTest
//
//  Created by Juan Carlos Pérez D. on 10/2/17.
//  Copyright © 2017 Juan Carlos Pérez. All rights reserved.
//

import UIKit
import RealmSwift


open class BaseDAO<T : Object, PK : AnyObject> : NSObject {
    
    public func getAll() -> Results<T> { //TODO: para pasarlo a List o Array debe ser de forma manual
        let realm = try! Realm()
        let results = realm.objects(T.self)
        return results
    }
    
    public func save(_ object : T) {
        let realm = try! Realm()
        
        try! realm.write {
            realm.add(object, update: true)
        }
    }
    
    public func saveOrUpdate(_ properties : Dictionary<String,AnyObject>) { //TODO: requiere id para actualizar
        let realm = try! Realm()
        try! realm.write {
            realm.create(T.self,value: properties, update: true)
        }
    }
    
    public func update(_ object : T) { //TODO: requiere id para actualizar
        let realm = try! Realm()
        try! realm.write {
            realm.add(object, update: true)
        }
    }
    
    
    public func deleteAll(_ objects : Results<T>) {
        let realm = try! Realm()
        
        try! realm.write {
            realm.delete(objects)
        }
    }
    
    public func deleteObject(_ object : T) {
        let realm = try! Realm()
        
        try! realm.write {
            realm.delete(object)
        }
    }
    
    public func findByPK(_ primaryKey : PK) -> T? {
        let realm = try! Realm()
        
        if let object = realm.object(ofType: T.self, forPrimaryKey: primaryKey){
            return object
        } else {
            return nil
        }
    }
    
    public func exists(_ object : T) -> Bool {
        let pk = T.primaryKey()! as String
        let result = findByPK(object.value(forKey: pk) as! PK)
        return result != nil ? true : false;
    }
}

extension Results {
    func toArray<T>(ofType: T.Type) -> [T] {
        var array = [T]()
        for i in 0 ..< count {
            if let result = self[i] as? T {
                array.append(result)
            }
        }
        
        return array
    }
}


