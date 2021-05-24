//
//  APIService.swift
//  SwiftNetwork
//
//  Created by Eddy Donald Chinchay Lujan on 18/5/21.
//

import Foundation

class APIService: NSObject {
    
    static let shared = APIService()
  
    ///Llamar a Web Service API
    ///Send Token
    ///Return Oject codable IReqResponsePostLike to ProfileViewcontroller
    public func apiToGetPostLikeData(token: String, completion: @escaping (IReqResponsePostLike) -> Void) { 
        ///Calla API
        GeneralBC.apiToGetPostLikeDataBC(token) { (objPostLike) in
            completion(objPostLike)
        } conCompletionIncorrecto: { (mensajeError) in
            print(mensajeError)
        }
    }
    
    ///Llamar a Web Service API
    ///Send Token
    ///Return Oject codable IReqResponsePostComments to ProfileViewcontroller
    func apiToGetPostCommentsData(token: String, completion : @escaping (IReqResponsePostComments) -> ()) {
        ///Call API
        GeneralBC.apiToGetPostCommentsDataBC(token) { (object) in
            completion(object)
        } conCompletionIncorrecto: { (mensajeError) in
            print(mensajeError)
        }
    }
    
    ///Llamar a Web Service API
    ///Send Token
    ///Return Oject codable IReqResponsePostComments to ProfileViewcontroller
    func apiToGetUsersData(token: String, completion : @escaping (IReqResponseUser) -> ()) {
        ///Call API
        GeneralBC.apiToGetUsersDataBC(token) { (object) in
            //print( "APIService - apiToGetUsersData:::::: \(object)")
            completion(object)
        } conCompletionIncorrecto: { (mensajeError) in
            print(mensajeError)
        }

    }
    
    func apiToGetUserPostViewModelData(token: String, completion : @escaping (IReqResponseUserPost) -> ()) {
        ///Call API
        GeneralBC.apiToGetUserPostDataBC(token) { (object) in
            completion(object)
        } conCompletionIncorrecto: { (mensajeError) in
            print(mensajeError)
        }

    }
    
}
