//
//  APIService.swift
//  SwiftNetwork
//
//  Created by Eddy Donald Chinchay Lujan on 18/5/21.
//

import Foundation

// Define a protocol containing the signature of a function to fetch data
protocol APIServiceProtocol: AnyObject {
    func getUserPost(token: String, completion : @escaping ((Result<UserPostData, Error>)) -> ())
    func getProfile(email: String, token: String, completion : @escaping ((Result<UserPostData, Error>)) -> ())
    func apiLike(type_id: Int, ref_id: Int, users_id: Int, isLiked: Bool, token: String, completion : @escaping ((Result<Operation, Error>)) -> ())
    func apiLiked(ref_id: Int, users_id: Int, token: String, completion : @escaping ((Result<Operation, Error>)) -> ())
    func apiPostCaptionUpdate( caption: Caption, idpost: Int, token: String, completion : @escaping ((Result<Operation, Error>)) -> ())
}


// MARK: APIService
// Declare the FakeAPIService class an make it conform to the FakeAPIServiceProtocol.
// Doing this we can easily assign this protocol in the PictureListViewController
class APIService: APIServiceProtocol {
    func getUserPost(token: String, completion: @escaping ((Result<UserPostData, Error>)) -> ()) {
        BCApiRest.apiUserPostBC( token ) { ( object ) in
            completion(.success( object ) )
        } conCompletionIncorrecto: { ( messageError ) in
            completion(.failure( messageError as! Error ) )
        }
    }
    
    func getProfile(email: String, token: String, completion: @escaping ((Result<UserPostData, Error>)) -> ()) {
        BCApiRest.profile( email, token ) { ( object ) in
            completion(.success( object ) )
        } conCompletionIncorrecto: { ( messageError ) in
            completion(.failure( messageError as! Error ) )
        }
    }
    
    func apiLike(type_id: Int, ref_id: Int, users_id: Int, isLiked: Bool, token: String, completion: @escaping ((Result<Operation, Error>)) -> ()) {
        BCApiRest.like( type_id, ref_id, users_id, isLiked, token ) { ( object ) in
            completion(.success( object ) )
        } conCompletionIncorrecto: { ( messageError ) in
            completion(.failure( messageError as! Error ) )
        }
    }
    
    func apiLiked(ref_id: Int, users_id: Int, token: String, completion: @escaping ((Result<Operation, Error>)) -> ()) {
        BCApiRest.liked( ref_id, users_id, token ) { ( object ) in
            completion(.success( object ) )
        } conCompletionIncorrecto: { ( messageError ) in
            completion(.failure( messageError as! Error ) )
        }
    }
    
    func apiPostCaptionUpdate(caption: Caption, idpost: Int, token: String, completion: @escaping ((Result<Operation, Error>)) -> ()) {
        BCApiRest.postCaptionUpdate( caption, idpost, token ) { ( object ) in
            completion(.success( object ) )
        } conCompletionIncorrecto: { ( messageError ) in
            completion(.failure( messageError as! Error ) )
        }
    }
}





/*

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
    func getProfile( email: String, token: String, completion : @escaping ( ( Result<UserPostData, Error> ) ) -> () ) {
        BCApiRest.profile( email, token ) { ( object ) in
            completion(.success( object ) )
        } conCompletionIncorrecto: { ( messageError ) in
            completion(.failure( messageError as! Error ) )
        }
    }
    
    //MARK: Likes
    func apiLike( type_id: Int, ref_id: Int, users_id: Int, isLiked: Bool, token: String, completion : @escaping (( Result<Operation, Error> ) ) -> () ) {
        BCApiRest.like( type_id, ref_id, users_id, isLiked, token ) { ( object ) in
            completion(.success( object ) )
        } conCompletionIncorrecto: { ( messageError ) in
            completion(.failure( messageError as! Error ) )
        }
    }
    
    //MARK: Liked
    func apiLiked( ref_id: Int, users_id: Int, token: String, completion : @escaping ( ( Result<Operation, Error> ) ) -> () ) {
        BCApiRest.liked( ref_id, users_id, token ) { ( object ) in
            completion(.success( object ) )
        } conCompletionIncorrecto: { ( messageError ) in
            completion(.failure( messageError as! Error ) )
        }
    }
    
    //MARK: POST VIEW CONTROLLER
    /// - Update caption or content from post.
    func apiPostCaptionUpdate( caption: Caption, idpost: Int, token: String, completion : @escaping ( ( Result<Operation, Error> ) ) -> () ) {
        BCApiRest.postCaptionUpdate( caption, idpost, token ) { ( object ) in
            completion(.success( object ) )
        } conCompletionIncorrecto: { ( messageError ) in
            completion(.failure( messageError as! Error ) )
        }
    }
}


*/
