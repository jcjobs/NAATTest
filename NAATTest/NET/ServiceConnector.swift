//
//  ServiceConnector.swift
//  NAATTest
//
//  Created by Juan Carlos Pérez D. on 10/2/17.
//  Copyright © 2017 Juan Carlos Pérez. All rights reserved.
//

import UIKit

protocol ServiceConnectorDelegate{
    func requestReturnedData(_ responseObjectWS : GenericResponseWS)
}

class ServiceConnector: NSObject{
    
    let SESSION_TRANSACTION_SUCCESS = "100"
    let TIME_OUT_INTERVAL = 300.0
    
    var delegate:ServiceConnectorDelegate! = nil
    
    var urlString = SESSION_URL_SERVER.appending(SESSION_WS_EXTENSION)
    
    var mutableData:NSMutableData?  = nil
    var responseObjectWS : GenericResponseWS? = nil
    
    var queue : OperationQueue? = nil
    
    var cancelled = Bool()
    
    
    func getQueryStringParameter(_ url: String, param: String) -> String? {
        guard let url = URLComponents(string: url) else { return nil }
        return url.queryItems?.first(where: { $0.name == param })?.value
    }
    
    func makeConnectionWithParametters(_ function: String, params: Dictionary<String, String>){
        
        var urlComp = URLComponents(string: urlString.appending(function) )!
        
        //Agregar parámetros a la URL
        
        var items = [URLQueryItem]()
        for (key,value) in params {
            items.append(URLQueryItem(name: key, value: value))
        }
        items = items.filter{!$0.name.isEmpty}
        
        if !items.isEmpty {
            urlComp.queryItems = items
        }
        
        
        responseObjectWS = GenericResponseWS.init(httpCode: SESSION_TRANSACTION_SUCCESS, code: "200", responseDescription: "", dataResponse: Data())
        
        var theRequest = URLRequest(url: urlComp.url!)
        theRequest.timeoutInterval = TIME_OUT_INTERVAL
        theRequest.httpMethod = "GET"
        theRequest.addValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
        theRequest.addValue("application/json", forHTTPHeaderField: "Accept")

        
        // set up the session
        let session = URLSession.shared
        let task = session.dataTask(with: theRequest as URLRequest, completionHandler: { data, response, error in

            self.LogW("data: \(String(describing: data))")
            self.LogW("response: \(String(describing: response))")
            self.LogW("error: \(String(describing: error))")
            
            if error != nil {
                print(error!.localizedDescription)
                self.LogW("Connection failed with error:\(error!.localizedDescription)" )
                self.responseObjectWS!.responseDescription = error!.localizedDescription
                
                let erro2 = error! as NSError
                self.responseObjectWS!.code = "\(erro2.code)"
            }
            
            
            if(self.cancelled){
                //Proceso cancelado
                self.LogW("Connection canceled with error:\(error!.localizedDescription)" )
                
                self.responseObjectWS!.httpCode = "0"
                
                self.responseObjectWS!.dataResponse = nil
                
                self.delegate!.requestReturnedData(self.responseObjectWS!)
            }
            else if data == nil {
                
                
                self.responseObjectWS!.httpCode = "0"
                self.responseObjectWS!.dataResponse = nil
                
                self.delegate!.requestReturnedData(self.responseObjectWS!)
            }
            else{
                
                let httpResponse : HTTPURLResponse = response as! HTTPURLResponse
                let httpCode = String(format: "%d", httpResponse.statusCode)
                self.responseObjectWS!.httpCode = httpCode
                self.responseObjectWS!.dataResponse = data
                
                self.delegate!.requestReturnedData(self.responseObjectWS!)
            }
            
        })
        task.resume()

    }

    
    func cancelCurrentRequest(){
        //connection?.cancel()
    }

    
    func LogW(_ msg:String, function: String = #function, file: String = #file, line: Int = #line){
        print("[WARNING]\(makeTag(function, file: file, line: line)) : \(msg)")
    }
    
    fileprivate func makeTag(_ function: String, file: String, line: Int) -> String{
        let url = URL(fileURLWithPath: file)
        let className:String! = url.lastPathComponent.characters.count == 0 ? file: url.lastPathComponent
        return "\(className) \(function)[\(line)]"
    }

    
}
