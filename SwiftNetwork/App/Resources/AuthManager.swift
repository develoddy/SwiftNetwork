//
//  AuthManager.swift
//  Blubinn
//
//  Created by Eddy Donald Chinchay Lujan on 31/3/21.
//

import UIKit

class AuthManager {
    
    static let shared = AuthManager()
    
    // MARK: Public
    
    public func registerNewUser(name: String, username: String, email: String, password: String, completion: @escaping (Bool) -> Void) {
        /**
         - Check if username is available
         - Check if email is available
        */
        DatabaseManager.shared.canCreateNewUser(name: name, email: email, username: username) { canCreate in
            ///Verifify if  the user exist in the database
            if canCreate {
                /**
                 - Create account
                 -  Insert account to database
                */
                let objUser = UserBE()
                objUser.name = name
                objUser.username = username
                objUser.email = email
                objUser.password = password
                
                BCApiRest.signIn(objUser) { (objUsuario) in
                    completion(true)
                } conCompletionIncorrecto: { (mensajeError) in
                    completion(false)
                }
            } else {
                completion(false)
            }
        }
    }
    
 
    public func login(email: String?, password: String?, completion: @escaping (Bool) -> Void) {
        if let email = email {
            let objUser = UserBE()
            objUser.email = email
            objUser.password = password
            
            ///Call to API
            BCApiRest.logIn(objUser) { (objUsuario) in
                completion(true)
            } conCompletionIncorrecto: { (mensajeError) in
                completion(false)
            }
        }
    }
}
