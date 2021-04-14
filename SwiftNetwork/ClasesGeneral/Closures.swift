//
//  Closures.swift
//  SwiftNetwork
//
//  Created by Eddy Donald Chinchay Lujan on 13/4/21.
//

import UIKit

class Closures: NSObject {

    typealias MensajeError                     = (_ mensajeError : String) -> Void
    typealias MensajeErrorStatus               = (_ mensajeError : String, _ expiroSesion : Bool) -> Void
    //typealias Login                            = (_ usuario : UserBE) -> Void
    //typealias SignUp                            = (_ usuario : SignUpBE) -> Void
    typealias Login                            = (_ usuario : ResponseTokenBE) -> Void
    typealias LogOut                           = (_ usuario : ResponseLogOutBE) -> Void
    
}

