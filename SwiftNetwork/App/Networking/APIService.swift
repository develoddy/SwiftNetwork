//
//  APIService.swift
//  SwiftNetwork
//
//  Created by Eddy Donald Chinchay Lujan on 18/5/21.
//

import Foundation

//MARK: API SERVICE -> WEB SERVICE
class APIService: NSObject {
    
    static let shared = APIService()
    
    //MARK: UserPost
    func getUserPost( token: String, completion : @escaping ( ( Result<UserPostData, Error> ) ) -> () ) {
        BCApiRest.apiUserPostBC( token ) { ( object ) in
            completion(.success( object ) )
        } conCompletionIncorrecto: { ( messageError ) in
            completion(.failure( messageError as! Error ) )
        }
    }
    
    //MARK: Profile
    func getProfile( email: String,
                     token: String,
                     completion : @escaping ( ( Result<UserPostData, Error> ) ) -> () ) {
        BCApiRest.profile( email, token ) { ( object ) in
            completion(.success( object ) )
        } conCompletionIncorrecto: { ( messageError ) in
            completion(.failure( messageError as! Error ) )
        }
    }
    
    //MARK: Likes
    func apiLike(type_id:Int,
                 ref_id:Int,
                 users_id:Int,
                 isLiked:Bool,
                 token:String,
                 completion : @escaping (( Result<Operation, Error> ) ) -> () ) {
        BCApiRest.like( type_id, ref_id, users_id, isLiked, token ) { ( object ) in
            completion(.success( object ) )
        } conCompletionIncorrecto: { ( messageError ) in
            completion(.failure( messageError as! Error ) )
        }
    }
    
    //MARK: Liked
    func apiLiked(ref_id:Int,
                  users_id:Int,
                  token:String,
                  completion : @escaping ( ( Result<Operation, Error> ) ) -> () ) {
        BCApiRest.liked( ref_id, users_id, token ) { ( object ) in
            completion(.success( object ) )
        } conCompletionIncorrecto: { ( messageError ) in
            completion(.failure( messageError as! Error ) )
        }
    }
    
    //MARK: POST VIEW CONTROLLER
    /// - Update caption or content from post.
    func apiPostCaptionUpdate(caption: Caption,
                              idpost: Int,
                              token:String,
                              completion : @escaping ( ( Result<Operation, Error> ) ) -> () ) {
        BCApiRest.postCaptionUpdate( caption, idpost, token ) { ( object ) in
            completion(.success( object ) )
        } conCompletionIncorrecto: { ( messageError ) in
            completion(.failure( messageError as! Error ) )
        }
    }
}
