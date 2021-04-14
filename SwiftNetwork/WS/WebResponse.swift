//
//  WebResponse.swift
//  Blubinn
//
//  Created by Eddy Donald Chinchay Lujan on 6/4/21.
//

import UIKit

class WebResponse: NSObject {
    
    var respuestaJSON   : Any?
    var statusCode      : NSInteger?
    var respuestaNSData : Data?
    var error           : NSError?
    var datosCabecera   : NSDictionary?
    var token           : NSString?
    var cookie          : NSString?
    
}
