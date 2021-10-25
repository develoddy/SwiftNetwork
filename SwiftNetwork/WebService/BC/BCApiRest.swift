//
//  ProfileBC.swift
//  SwiftNetwork
//
//  Created by Eddy Donald Chinchay Lujan on 18/5/21.
//

import UIKit



// Class BCApiRest

//class GeneralBC: NSObject {
class BCApiRest: NSObject {
    
    //MARK: logOut
    @discardableResult class func logOut(_ token                                     : String?                          ,
                                         conCompletionCorrecto completioCorrecto     : @escaping Closures.LogOut        ,
                                         conCompletionIncorrecto completionIncorrecto: @escaping Closures.MensajeError  ) -> URLSessionDataTask? {
        
        return WSApiRest.sesionSignOut(token!, conCompletionCorrecto: { (objUser) in
            completioCorrecto(objUser)
        }, error: { (mensajeError) in
            completionIncorrecto(mensajeError)
        })
    }
    
    //MARK: logIn
    @discardableResult class func logIn(_ objUser                                   : UserBE                          ,
                                        conCompletionCorrecto completioCorrecto     : @escaping Closures.Login        ,
                                        conCompletionIncorrecto completionIncorrecto: @escaping Closures.MensajeError ) -> URLSessionDataTask? {
        if objUser.email?.count == 0 {
            completionIncorrecto("You need enter your email")
            return nil
        }
        
        if objUser.password?.count == 0 {
            completionIncorrecto("You need enter your password")
            return nil
        }
            
        return WSApiRest.iniciarSesion(objUser, conCompletionCorrecto: { ( objUser ) in
            BCApiRest.guardarSesion(deUsuario: objUser)
            completioCorrecto( objUser )
        }, error: { ( mensajeError ) in
            completionIncorrecto( mensajeError )
        })
    }
    
    //MARK: signIn
    @discardableResult class func signIn(_ objUser                                   : UserBE                          ,
                                         conCompletionCorrecto completioCorrecto     : @escaping Closures.Login        ,
                                         conCompletionIncorrecto completionIncorrecto: @escaping Closures.MensajeError ) -> URLSessionDataTask? {
        
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
            
        return WSApiRest.sesionSignIn( objUser, conCompletionCorrecto: { ( objUser ) in
            BCApiRest.guardarSesion(deUsuario: objUser)
            completioCorrecto( objUser )
        }, error: { ( mensajeError ) in
            completionIncorrecto( mensajeError )
        })
    }
    
    //MARK: Guardar session
    class func guardarSesion(deUsuario objUsuario : ResponseTokenBE) -> Void {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        do {
            appDelegate.objUsuarioSesion = objUsuario
            let objUsuario = try JSONEncoder().encode(objUsuario) ///encode data
            CDMKeyChain.guardarDataEnKeychain(
                try NSKeyedArchiver.archivedData(withRootObject: objUsuario, requiringSecureCoding: false),conCuenta: "CDMLogin", conServicio:"datosUsuario")
        } catch {
            print("Failed to save data... log: OSLog.default, type: .error")
        }
    }
    
    

    
    //MARK: User Post
    /// Vamos a llamar al backend para traer los datos de la base de datos.
    /// Esta funcion recibe por parametros el token
    /// Return object userpost o de lo contrario un mensaje de error.
    @discardableResult class
    public func apiUserPostBC(_ token                                     : String?                         ,
                              conCompletionCorrecto completioCorrecto     : @escaping Closures.userPost     ,
                              conCompletionIncorrecto completionIncorrecto: @escaping Closures.MensajeError ) -> URLSessionDataTask? {
        
        let result = WSApiRest.startApiUserPost(token, conCompletionCorrecto: { ( data ) in
            completioCorrecto(data)
        }, error: { (messageError) in
            completionIncorrecto(messageError)
        })
        return result
    }
    
    //MARK: Explore
    /// Vamos a llamar al backend para traer los datos de la base de datos.
    /// Esta funcion recibe por parametros el objeto userSearch y el token
    /// Return object userpost o de lo contrario un mensaje de error.
    @discardableResult class func search(_ objSearch: UserSearchBE,
                                         _ token: String?,
                                         conCompletionCorrecto completioCorrecto: @escaping Closures.SearchUser,
                                         conCompletionIncorrecto completionIncorrecto : @escaping Closures.MensajeError) -> URLSessionDataTask? {
        if objSearch.name?.count == 0 {
            completionIncorrecto("You need enter your name")
            return nil
        }
        
        let resultSearch = WSApiRest.startSearch(objSearch, token!, conCompletionCorrecto: { (objSearch) in
            completioCorrecto(objSearch)
        }, error: { (mensajeError) in
            print("mensajeError")
            completionIncorrecto(mensajeError)
        })
        
        return resultSearch
    }
}
