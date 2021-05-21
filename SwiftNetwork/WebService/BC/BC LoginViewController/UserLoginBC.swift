//
//  UserLoginBC.swift
//  Blubinn
//
//  Created by Eddy Donald Chinchay Lujan on 6/4/21.
//

import UIKit

class UserLoginBC: NSObject {
    
    //MARK: logOut
    @discardableResult class func logOut(
        _ token: String?,
        conCompletionCorrecto completioCorrecto: @escaping Closures.LogOut,
        conCompletionIncorrecto completionIncorrecto : @escaping Closures.MensajeError ) -> URLSessionDataTask? {
        
        return WebModelLoginViewController.sesionSignOut(token!, conCompletionCorrecto: { (objUser) in
            completioCorrecto(objUser)
        }, error: { (mensajeError) in
            completionIncorrecto(mensajeError)
        })
    }
    
    
    //MARK: logIn
    @discardableResult class func logIn(
        _ objUser: UserBE,
        conCompletionCorrecto completioCorrecto: @escaping Closures.Login,
        conCompletionIncorrecto completionIncorrecto : @escaping Closures.MensajeError ) -> URLSessionDataTask? {
        
        if objUser.email?.count == 0 {
            completionIncorrecto("You need enter your email")
            return nil
        }
        
        if objUser.password?.count == 0 {
            completionIncorrecto("You need enter your password")
            return nil
        }
            
        return WebModelLoginViewController.iniciarSesion(objUser, conCompletionCorrecto: { (objUser) in
            UserLoginBC.guardarSesion(deUsuario: objUser)
            completioCorrecto(objUser)
        }, error: { (mensajeError) in
            completionIncorrecto(mensajeError)
        })
    }
    
    //MARK: signIn
    @discardableResult class func signIn(
        _ objUser: UserBE,
        conCompletionCorrecto completioCorrecto: @escaping Closures.Login,
        conCompletionIncorrecto completionIncorrecto : @escaping Closures.MensajeError ) -> URLSessionDataTask? {
        
        if objUser.name?.count == 0 {
            completionIncorrecto("You need enter your name")
            return nil
        }
        if objUser.username?.count == 0 {
            completionIncorrecto("You need enter your username")
            return nil
        }
        if objUser.email?.count == 0 {
            completionIncorrecto("You need enter your email")
            return nil
        }
        if objUser.password?.count == 0 {
            completionIncorrecto("You need enter your password")
            return nil
        }
            
        return WebModelLoginViewController.sesionSignIn(
            objUser, conCompletionCorrecto: { (objUser) in
            UserLoginBC.guardarSesion(deUsuario: objUser)
                
            completioCorrecto(objUser)
        }, error: { (mensajeError) in
            completionIncorrecto(mensajeError)
        })
    }
    
    class func guardarSesion(deUsuario objUsuario : ResponseTokenBE) -> Void {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.objUsuarioSesion = objUsuario//.token
        do {
            CDMKeyChain.guardarDataEnKeychain(try NSKeyedArchiver.archivedData(withRootObject: objUsuario,
                                                                               requiringSecureCoding: false),
                                              conCuenta: "CDMLogin", conServicio: "datosUsuario")
            } catch {
                print("Failed to save meals... log: OSLog.default, type: .error")
        }
    }
    
   
}