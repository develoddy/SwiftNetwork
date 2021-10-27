//
//  WebTranslator.swift
//  Blubinn
//
//  Created by Eddy Donald Chinchay Lujan on 6/4/21.
//

import UIKit

class WSTranslator: NSObject {
    
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
    
    

    //MARK: LOGOUT TRANSLATOR RESPONSE.
    ///Return Object mensaje logout.
    class func translateResponseLogOutBE(_ objDic: NSDictionary) -> ResponseLogOutBE {
        let objLogOutBE = ResponseLogOutBE()
        objLogOutBE.message = objDic["message"] as? String
        return objLogOutBE
    }
}
