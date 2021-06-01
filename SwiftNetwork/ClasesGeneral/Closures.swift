//
//  Closures.swift
//  SwiftNetwork
//
//  Created by Eddy Donald Chinchay Lujan on 13/4/21.
//

import UIKit

class Closures: NSObject {
    typealias MensajeError = (_ mensajeError : String) -> Void
    typealias MensajeErrorStatus = (_ mensajeError : String, _ expiroSesion : Bool) -> Void
    typealias Login = (_ usuario : ResponseTokenBE) -> Void
    typealias LogOut = (_ usuario : ResponseLogOutBE) -> Void
    typealias SearchUser = (_ usuario: [Search]) -> Void
    
    ///ProfileViewcontroller
    typealias iReqResponsePostLike = (_ usuario: IReqResponseFeaturePosLike) -> Void ///IReqResponsePostLike
    typealias iReqResponsePostComments = (_ usuario: IReqResponsePostComments) -> Void ///IReqResponsePostComments
    typealias iReqResponseUser = (_ usuario: IReqResponseUser) -> Void ///IReqResponseUser IReqResponseTaggedUsers
    typealias iReqResponseTaggedUsers = (_ usuario: IReqResponseTaggedUsers) -> Void ///IReqResponseTaggedUsers
    typealias iReqResponseUserPost = (_ usuario: IReqResponseUserPost) -> Void 
    
}

