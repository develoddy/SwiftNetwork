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
    
    func apiToGetPostCommentsData(completion : @escaping (PostCommentsViewModel) -> ()) {
        //completion()
        //Llamar a Web Service
    }
    
    func apiToGetUserData(completion : @escaping (PostLikeViewModel) -> ()) {
        //completion()
        //Llamar a Web Service
        
        /**URLSession.shared.dataTask(with: sourcesURL) { (data, urlResponse, error) in
            if let data = data {
                let jsonDecoder = JSONDecoder()
                let empData = try! jsonDecoder.decode(Employees.self, from: data)
                    completion(empData)
            }
        }.resume()**/
    }
    
    func apiToGetUserPostViewModelData(completion : @escaping (UserPostViewModel) -> ()) {
        //completion()
        //Llamar a Web Service
    }
    
}
