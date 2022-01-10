
//
//  WebTranslator.swift
//  Blubinn
//
//  Created by Eddy Donald Chinchay Lujan on 6/4/21.
//

import UIKit

class WSTranslator: NSObject {
    
    //MARK: SYNC USER POST TRANSLATOR RESPONSE.
    /// Vamos a llamar al backend para traer los datos de User Post para sicronoziarl con core data.
    class func translateResponseSyncUserPostBE(_ objDic: NSDictionary, completion: @escaping ((Result<[UserpostServerModel], Error>)) -> Void) {
        do {
            let jsonData:NSData = try JSONSerialization.data(withJSONObject: objDic, options: JSONSerialization.WritingOptions.prettyPrinted) as NSData
            guard let jsonString = String(data: jsonData as Data, encoding: String.Encoding.utf8) else { return }
            guard let json = jsonString.data(using: .utf8) else { return }
            let model = try JSONDecoder().decode(APIResponse<[UserpostServerModel]>.self, from: json)
            
            /*print("--------------------- translateResponseSyncUserPostBE ----------------")
            for item in model.userpost {
                print(item.id)
            }
            print("--------------------- translateResponseSyncUserPostBE ----------------")*/
            completion(.success(model.userpost))
        } catch {
            print("--- Coding Error o discrepancia entre propiedades de Lravel y Swift ==> translateResponseSyncUserPostBE ==> error")
        }
    }
    
    
    //MARK: USERPOST TRANSLATOR RESPONSE.
    ///Convert Object dicctionary a Json Codable UserPost
    ///Return Object Codable
    class func translateResponseUserPostBE(_ objDic: NSDictionary, completion: @escaping ((Result<UserPost, Error>)) -> Void) {
        var userPost: UserPost?
        do {
            let jsonData:NSData = try JSONSerialization.data(withJSONObject: objDic, options: JSONSerialization.WritingOptions.prettyPrinted) as NSData
            guard let jsonString = String(data: jsonData as Data, encoding: String.Encoding.utf8) else { return }
            guard let json = jsonString.data(using: .utf8) else { return }
            userPost = try JSONDecoder().decode(UserPost.self, from: json)
            if let userPost = userPost {
                completion(.success(userPost))
            } else {
                completion(.failure(Error.self as! Error) )
                print("Failed to pase")
            }
        } catch {
            print("--- translateResponseUserPostBE ::::: error")
        }
    }
    
    //MARK: PROFILE TRANSLATOR RESPONSE.
    ///Convert Object dicctionary a Json Codable Explore
    ///Return Object Codable
    class func translateResponseProfileBE(_ objDic: NSDictionary, completion: @escaping ((Result<UserPost, Error>)) -> Void) {
        var userPost: UserPost?
        do {
            let jsonData:NSData = try JSONSerialization.data(withJSONObject: objDic, options: JSONSerialization.WritingOptions.prettyPrinted) as NSData
            guard let jsonString = String(data: jsonData as Data, encoding: String.Encoding.utf8) else { return }
            guard let json = jsonString.data(using: .utf8) else { return }
            userPost = try JSONDecoder().decode(UserPost.self, from: json)
            if let userPost = userPost {
                completion(.success(userPost))
            } else {
                completion(.failure(Error.self as! Error) )
                print("Failed to pase")
            }
        } catch {
            print("--- translateResponseExploreBE ::::: error")
        }
    }
    
    //MARK: PROFILE TRANSLATOR RESPONSE.
    ///Convert Object dicctionary a Json Codable Explore
    ///Return Object Codable
    class func translateResponseLikeBE(_ objDic: NSDictionary, completion: @escaping ((Result<Operation, Error>)) -> Void) {
        var operation: Operation?
        do {
            let jsonData:NSData = try JSONSerialization.data(withJSONObject: objDic, options: JSONSerialization.WritingOptions.prettyPrinted) as NSData
            guard let jsonString = String(data: jsonData as Data, encoding: String.Encoding.utf8) else { return }
            guard let json = jsonString.data(using: .utf8) else { return }
            operation = try JSONDecoder().decode(Operation.self, from: json)
            if let operation = operation {
                completion(.success(operation))
            } else {
                completion(.failure(Error.self as! Error) )
                print("Failed to pase")
            }
        } catch {
            print("--- translateResponseExploreBE ::::: error")
            completion(.failure(Error.self as! Error) )
        }
    }
    
    //MARK: EXPLORE TRANSLATOR RESPONSE.
    ///Convert Object dicctionary a Json Codable Explore
    ///Return Object Codable
    class func translateResponseExploreBE(_ objDic: NSDictionary, completion: @escaping ((Result<UserPost, Error>)) -> Void) {
        var userPost: UserPost?
        do {
            let jsonData:NSData = try JSONSerialization.data(withJSONObject: objDic, options: JSONSerialization.WritingOptions.prettyPrinted) as NSData
            guard let jsonString = String(data: jsonData as Data, encoding: String.Encoding.utf8) else { return }
            guard let json = jsonString.data(using: .utf8) else { return }
            userPost = try JSONDecoder().decode(UserPost.self, from: json)
            
            if let userPost = userPost {
                completion(.success(userPost))
            } else {
                completion(.failure(Error.self as! Error) )
                print("Failed to pase")
            }
        } catch {
            print("--- translateResponseExploreBE ::::: error")
        }
    }
    
    //MARK: TOKEN TRANSLATOR RESPONSE.
    class func translateResponseTokenBE(_ objDic: NSDictionary, completion: @escaping ((Result<ResponseTokenBE, Error>)) -> Void) {
        var responseTokenBE: ResponseTokenBE?
        do {
            let jsonData:NSData = try JSONSerialization.data(withJSONObject: objDic, options: JSONSerialization.WritingOptions.prettyPrinted) as NSData
            guard let jsonString = String(data: jsonData as Data, encoding: String.Encoding.utf8) else { return }
            guard let json = jsonString.data(using: .utf8) else { return }
            responseTokenBE = try JSONDecoder().decode(ResponseTokenBE.self, from: json)
            if let responseTokenBE = responseTokenBE {
                completion(.success(responseTokenBE))
            } else {
                completion(.failure(Error.self as! Error) )
                print("Failed to pase")
            }
        } catch {
            print("--- translateResponseTokenBE ::::: error")
        }
    }
    
    //MARK: LIKED TRANSLATOR RESPONSE.
    ///Convert Object dicctionary a Json Codable Explore
    ///Return Object Codable
    class func translateResponseLikedBE(_ objDic: NSDictionary, completion: @escaping ((Result<Operation, Error>)) -> Void) {
        var operation: Operation?
        do {
            let jsonData:NSData = try JSONSerialization.data(withJSONObject: objDic, options: JSONSerialization.WritingOptions.prettyPrinted) as NSData
            guard let jsonString = String(data: jsonData as Data, encoding: String.Encoding.utf8) else { return }
            guard let json = jsonString.data(using: .utf8) else { return }
            operation = try JSONDecoder().decode(Operation.self, from: json)
            if let operation = operation {
                completion(.success(operation))
            } else {
                completion(.failure(Error.self as! Error) )
                print("Failed to pase")
            }
        } catch {
            print("--- translateResponseExploreBE ::::: error")
            completion(.failure(Error.self as! Error) )
        }
    }
    
    

    //MARK: LOGOUT TRANSLATOR RESPONSE.
    ///Return Object mensaje logout.
    class func translateResponseLogOutBE(_ objDic: NSDictionary) -> ResponseLogOutBE {
        let objLogOutBE = ResponseLogOutBE()
        objLogOutBE.message = objDic["message"] as? String
        return objLogOutBE
    }
}
