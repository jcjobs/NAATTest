//
//  LocationsControllerDelegate.swift
//  NAATTest
//
//  Created by Juan Carlos Pérez D. on 10/2/17.
//  Copyright © 2017 Juan Carlos Pérez. All rights reserved.
//

import UIKit

@objc protocol LocationsControllerDelegate{
    @objc optional func doneMakeRequestWithParametters(result : String, success : Bool)
    func doneMakeRequestLocationsWithParametters(result : String, success : Bool)
}


class LocationsController: NSObject {

    var delegate:LocationsControllerDelegate? = nil
    let locationsPersistenceManager = LocationsPersistenceManager()
    
    
    //Request Users from net------>
    var serviceConnector = ServiceConnector()
    fileprivate let WS_PARAMETTER_LOCATION = "location"
    fileprivate let WS_PARAMETTER_RADIUS = "radius"
    fileprivate let WS_PARAMETTER_TYPE = "type"
    fileprivate let WS_PARAMETTER_KEY = "key"
    
    fileprivate let WS_PARAMETTER_RADIUS_VALUE = "2000"
    fileprivate let WS_PARAMETTER_TYPE_VALUE = "bank"
    fileprivate let WS_PARAMETTER_KEY_VALUE = "AIzaSyA7m5YQp_OQXvZ7DzylErwubKq7BhIVUcs"
    
    fileprivate let WS_PARAMETTER_FUNCTION = "json"
    
    func makeRequestUsersWithParametters(_ lat : String , lng: String){
        
        let params:[String:String] = [WS_PARAMETTER_LOCATION:lat.appending(",\(lng)"), WS_PARAMETTER_RADIUS:WS_PARAMETTER_RADIUS_VALUE,WS_PARAMETTER_TYPE:WS_PARAMETTER_TYPE_VALUE, WS_PARAMETTER_KEY:WS_PARAMETTER_KEY_VALUE ]
        serviceConnector.delegate = self
        serviceConnector.makeConnectionWithParametters(WS_PARAMETTER_FUNCTION, params: params)
    }

    func getLocations()->[RLocation]{
        return locationsPersistenceManager.getAllLocations()
    }
    
}

extension LocationsController : ServiceConnectorDelegate{
    
    func requestReturnedData(_ responseObjectWS: GenericResponseWS) {
        let data = responseObjectWS.dataResponse
        
        if(data != nil){
            let locationsParser : LocationsParser = LocationsParser()
            locationsParser.delegate = self
            locationsParser.makeParseWithParametters(data!)
        } else {
            DispatchQueue.main.async {
               self.delegate!.doneMakeRequestLocationsWithParametters(result: responseObjectWS.responseDescription, success: false)
            }
        }
    }
}

extension LocationsController : LocationsParserDelegate{
   
    func doneLocationsParserWithObject(_ locations: [RLocation], resultWS: CResultWS) {
        
        if(locations.count > 0){
            
            for location in locations{
                let properties = ["id" : location.id, "name" : location.name , "address" : location.address, "distance" : location.distance, "lat" : location.lat, "lng" : location.lng] as [String : Any]
                locationsPersistenceManager.saveOrUpdate(properties as Dictionary<String, AnyObject>)
            }
            
            DispatchQueue.main.async {
                self.delegate!.doneMakeRequestLocationsWithParametters(result: resultWS.errorNumber, success: true)
            }
        }
        else{
            DispatchQueue.main.async {
                self.delegate!.doneMakeRequestLocationsWithParametters(result: resultWS.errorDescripcion, success: false)
            }
        }
    }
    
}
