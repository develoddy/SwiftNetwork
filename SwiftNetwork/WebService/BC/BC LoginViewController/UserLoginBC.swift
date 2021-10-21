//
//  UserLoginBC.swift
//  Blubinn
//
//  Created by Eddy Donald Chinchay Lujan on 6/4/21.
//

import UIKit

class UserLoginBC: NSObject {
    static let shared = UserLoginBC()
    
    let fileName = "userdata.dat"
    
    lazy var fullPath : URL =  { return getDocumentsDirectory().appendingPathComponent(fileName)}()
    
    func getDocumentsDirectory() -> URL {
        return FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
    }
    
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
    
    ///Guardar session
    class func guardarSesion(deUsuario objUsuario : ResponseTokenBE) -> Void {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        do {
            appDelegate.objUsuarioSesion = objUsuario
            let objUsuario = try JSONEncoder().encode(objUsuario) ///encode data
            CDMKeyChain.guardarDataEnKeychain(
                try NSKeyedArchiver.archivedData(withRootObject: objUsuario, requiringSecureCoding: false),conCuenta: "CDMLogin", conServicio:"datosUsuario")
            ///let writeData = try NSKeyedArchiver.archivedData(withRootObject: objUsuario, requiringSecureCoding: false)
            ///try writeData.write(to:  shared.fullPath)
            /***
            appDelegate.objUsuarioSesion = objUsuario//.token
            do {
                CDMKeyChain.guardarDataEnKeychain(try NSKeyedArchiver.archivedData(withRootObject: objUsuario, requiringSecureCoding: false),conCuenta: "CDMLogin", conServicio: "datosUsuario")
            } catch {
                print("Failed to save data... log: OSLog.default, type: .error")
            }*/
        } catch {
            print("Failed to save data... log: OSLog.default, type: .error")
        }
    }
}
