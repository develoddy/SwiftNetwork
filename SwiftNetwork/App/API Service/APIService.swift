//
//  APIService.swift
//  SwiftNetwork
//
//  Created by Eddy Donald Chinchay Lujan on 18/5/21.
//

import Foundation

class APIService: NSObject {
    
    static let shared = APIService()
    
    ///PostLike
    ///Llamar a Web Service API
    ///Send Token
    ///Return Oject codable IReqResponsePostLike to ProfileViewcontroller
    //public func apiToGetPostLikeData(token: String, tabs: String, completion: @escaping (IReqResponsePostLike) -> Void) {
    public func apiToGetPostLikeData(token: String, tabs: String, completion: @escaping ((Result<IReqResponseFeaturePosLike, Error>)) -> Void) {
  
        
        ///Calla API Grid
        GeneralBC.apiToGetPostLikeDataBC(token, tabs) { (objPostLike) in
            completion(.success(objPostLike))
            
        } conCompletionIncorrecto: { (mensajeError) in
            print(mensajeError)
            //completion(.failure(mensajeError))
        }
    }
    
    ///PostComments
    ///Llamar a Web Service API
    ///Send Token
    ///Return Oject codable IReqResponsePostComments to ProfileViewcontroller
    ///func apiToGetPostCommentsData(token: String, completion : @escaping (IReqResponsePostComments) -> ()) {
    func apiToGetPostCommentsData(token: String, tabs: String, completion : @escaping ((Result<IReqResponsePostComments, Error>)) -> ()) {
        
        ///Call API
        GeneralBC.apiToGetPostCommentsDataBC(token, tabs) { (object) in
            completion(.success(object))
        } conCompletionIncorrecto: { (mensajeError) in
            completion(.failure(mensajeError as! Error))
            print(mensajeError)
        }
        
    }
    
    ///User
    ///Llamar a Web Service API
    ///Send Token
    ///Return Oject codable IReqResponsePostComments to ProfileViewcontroller
    ///func apiToGetUsersData(token: String, completion : @escaping (IReqResponseUser) -> ()) {
    func apiToGetUsersData(token: String, tabs: String, completion : @escaping ((Result<IReqResponseUser, Error>)) -> ()) {
     
        ///Call API
        GeneralBC.apiToGetUsersDataBC(token, tabs) { (object) in
            completion(.success(object))
        } conCompletionIncorrecto: { (mensajeError) in
            completion(.failure(mensajeError as! Error))
        }
        
    }
    
    ///Llamar a Web Service API
    ///Send Token
    ///Return Oject codable IReqResponsePostComments to ProfileViewcontroller
    ///func apiToGetUserPostViewModelData(token: String, completion : @escaping (IReqResponseUserPost) -> ()) {
    func apiToGetUserPostViewModelData(token: String, tabs: String, completion : @escaping ((Result<IReqResponseUserPost, Error>)) -> ()) {
       
        GeneralBC.apiToGetUserPostDataBC(token, tabs) { (object) in
            completion(.success(object))
        } conCompletionIncorrecto: { (mensajeError) in
            completion(.failure(mensajeError as! Error))
        }
      
    }
}
