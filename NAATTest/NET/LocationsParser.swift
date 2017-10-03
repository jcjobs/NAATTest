//
//  LocationsParser.swift
//  NAATTest
//
//  Created by Juan Carlos Pérez D. on 10/2/17.
//  Copyright © 2017 Juan Carlos Pérez. All rights reserved.
//

import UIKit
import CoreLocation

protocol LocationsParserDelegate{
    func doneLocationsParserWithObject(_ locations : [RLocation], resultWS : CResultWS)
}


class LocationsParser: NSObject {

    var delegate:LocationsParserDelegate! = nil
    //var elementValue: String?
    var locationsArray = [RLocation]()
    var resultWS : CResultWS? = nil
    
    let SESSION_TRANSACTION_SUCCESS = "200"
    let SESSION_TRANSACTION_ERROR = "-90"
    
    func makeParseWithParametters(_ dataResponse : Data) {
        resultWS = CResultWS.init(succes: "S", errorNumber: SESSION_TRANSACTION_SUCCESS, errorDescripcion: "Success")
        
        do {
            
            let json = try JSONSerialization.jsonObject(with: dataResponse, options: []) as! [String: AnyObject]
            
            if let results = json["results"] as? [[String : AnyObject]] {
                for result in results{
                 let location =  RLocation()
                    
                    if let id = result["id"] as? String {
                        location.id = id
                    }
                    
                    if let name = result["name"] as? String {
                        location.name = name
                    }
                    
                    if let address = result["vicinity"] as? String {
                        location.address = address
                    }
                    
                    if let geometryComponents = result["geometry"] as? NSDictionary {
                        if let locationComponents = geometryComponents["location"] as? NSDictionary {
                            if let latitud = locationComponents["lat"] as? Double {
                                location.lat = latitud
                            }
                            
                            if let longitud = locationComponents["lng"] as? Double {
                                location.lng = longitud
                            }
                        }
                    }
                    
                    location.distance = self.calculateDistance(coordinateToCompare: CLLocation(latitude:location.lat, longitude: location.lng))
                    
                    locationsArray.append(location)
                }
            }
            
            // MARK: -- Códigos de error
            if let errorStatus = json["status"] as? String {
                resultWS?.errorNumber = errorStatus
            }
            if let errorDescription = json["error"] as? String {
                resultWS?.errorDescripcion = errorDescription
            }
            
        } catch let error as NSError {
            print("error trying to convert data to JSON")
            resultWS?.succes = SESSION_TRANSACTION_ERROR
            resultWS?.errorDescripcion = error.localizedDescription
            resultWS?.errorNumber = "\(error.code)"
        }
        
        
        delegate!.doneLocationsParserWithObject(self.locationsArray, resultWS : self.resultWS! )
    }
    
    //Función para calcular la distancia entre dos puntos
    internal func calculateDistance(coordinateToCompare:CLLocation)->Double{
        
        let coordinate1 = CLLocation(latitude: LOCATION_DEFAULT_LAT, longitude: LOCATION_DEFAULT_LNG)
        return coordinate1.distance(from: coordinateToCompare) // result is in meters
    }
    
    

}
