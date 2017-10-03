//
//  GenericResponseWS.swift
//  NAATTest
//
//  Created by Juan Carlos Pérez D. on 10/2/17.
//  Copyright © 2017 Juan Carlos Pérez. All rights reserved.
//

import UIKit

class GenericResponseWS: NSObject {

    var httpCode: String
    var code: String
    var responseDescription: String
    var dataResponse : Data?
    
    convenience override init() {
        self.init(httpCode : "",code:"", responseDescription: "", dataResponse : Data())
    }
    
    init(httpCode: String, code: String, responseDescription: String, dataResponse: Data) {
        self.httpCode = httpCode
        self.code = code
        self.responseDescription = responseDescription
        self.dataResponse = dataResponse
    }

}
