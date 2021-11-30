//
//  Closures.swift
//  SwiftNetwork
//
//  Created by Eddy Donald Chinchay Lujan on 13/4/21.
//

import UIKit

class Closures: NSObject {
    typealias userPost = (_ user: UserPost) -> Void
    typealias message = (_ message: Operation) -> Void
    typealias MensajeError       = (_ mensajeError : String                         ) -> Void
    
    typealias MensajeErrorStatus = (_ mensajeError : String, _ expiroSesion : Bool  ) -> Void
    typealias Login              = (_ usuario      : ResponseTokenBE                ) -> Void
    typealias LogOut             = (_ usuario      : ResponseLogOutBE               ) -> Void
    
}

