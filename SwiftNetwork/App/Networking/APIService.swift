//
//  APIService.swift
//  SwiftNetwork
//
//  Created by Eddy Donald Chinchay Lujan on 18/5/21.
//

import Foundation


class APIServiceLocal: NSObject {
    
    static let shared = APIServiceLocal()
    
    // MARK: UerPost
    /// Read file json
    /// - Parameter
    /// - Return
    /*public func parseUserPostJSON( completion: @escaping (IReqResponseUserPost) -> Void ) {
        let file = "userPostJson"
        ///Valdate if exists file or not
        guard let path = Bundle.main.path(forResource: file, ofType: "json") else { return }
        let url = URL(fileURLWithPath: path) ///Get url json
        var userPostViewModel: IReqResponseUserPost? ////Instancia el modelo codable
        do {
            let jsonData = try Data(contentsOf: url)
            userPostViewModel = try JSONDecoder().decode(IReqResponseUserPost.self, from: jsonData)
            if let userPostViewModel = userPostViewModel {
                completion(userPostViewModel)
            } else {
                print("Failed to pase")
            }
        } catch {
            print("Error: \(error)")
        }
    }*/
}



class APIService: NSObject {
    
    static let shared = APIService()
    
    //MARK: UserPost
    func apiUserPost(token: String, completion : @escaping ((Result<UserPost, Error>)) -> ()) {
        BCApiRest.apiUserPostBC(token) { ( object ) in
            completion(.success(object))
        } conCompletionIncorrecto: { (messageError) in
            completion(.failure(messageError as! Error))
        }
    }
    
    //MARK: Profile
    func apiProfile(email: String, token: String, completion : @escaping ((Result<UserPost, Error>)) -> ()) {
        BCApiRest.profile(email, token) { ( object ) in
            completion(.success(object))
        } conCompletionIncorrecto: { (messageError) in
            completion(.failure(messageError as! Error))
        }
    }
    
    //MARK: Likes
    func apiLike(type_id:Int, ref_id:Int, users_id:Int, isLiked:Bool, token:String, completion : @escaping ((Result<Operation, Error>)) -> ()) {
        BCApiRest.like(type_id, ref_id, users_id, isLiked, token) { ( object ) in
            completion(.success(object))
        } conCompletionIncorrecto: { (messageError) in
            completion(.failure(messageError as! Error))
        }
    }
    
    //MARK: Liked
    func apiLiked(ref_id:Int, users_id:Int, token:String, completion : @escaping ((Result<Operation, Error>)) -> ()) {
        BCApiRest.liked(ref_id, users_id, token) { ( object ) in
            completion(.success(object))
        } conCompletionIncorrecto: { (messageError) in
            completion(.failure(messageError as! Error))
        }
    }
    
    //MARK: POST VIEW CONTROLLER
    ///Operaciones
    /// - Update caption or content from post.
    func apiPostCaptionUpdate(caption: Caption, idpost: Int, token:String, completion : @escaping ((Result<Operation, Error>)) -> ()) {
        BCApiRest.postCaptionUpdate(caption, idpost, token) { ( object ) in
            completion(.success(object))
        } conCompletionIncorrecto: { (messageError) in
            completion(.failure(messageError as! Error))
        }
    }
}
