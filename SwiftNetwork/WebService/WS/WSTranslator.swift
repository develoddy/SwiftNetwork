//
//  WebTranslator.swift
//  Blubinn
//
//  Created by Eddy Donald Chinchay Lujan on 6/4/21.
//

import UIKit


//WSTranslator
//class WebTranslatorLoginViewController: NSObject {
class WSTranslator: NSObject {
    
    //MARK: Translate Reponse User Post.
    ///Convert Object dicctionary a Json Codable IReqResponseUserPost
    ///Return Object Codable
    class func translateResponseUserPostBE(_ objDic  : NSDictionary                        ,
                                            completion: @escaping ((Result<UserPost, Error>)) -> Void) {
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
    
    //MARK: Translate Response Token
    class func translateResponseTokenBE(_ objDic  : NSDictionary,
                                         completion: @escaping ((Result<ResponseTokenBE, Error>)) -> Void) {
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
    
    //MARK: Translate Response Explore.
    class func translateResponseSearchnBE(_ objDic : NSDictionary) -> [Search] {
        var searchs = [Search]()
        do {
            let jsonData:NSData = try JSONSerialization.data(withJSONObject: objDic, options: JSONSerialization.WritingOptions.prettyPrinted) as NSData
            let jsonString = String(data: jsonData as Data, encoding: String.Encoding.utf8)
            
            let json = jsonString!.data(using: .utf8)!
            let jsonUser = try! JSONDecoder().decode(WebUserSearchData.self, from: json)
            for i in 0..<jsonUser.user.count {
                var search = Search()
                search.username = jsonUser.user[i].username
                search.name = jsonUser.user[i].name
                searchs.append(search)
            }
            return searchs
        } catch {
            print("Catch")
            return searchs
        }
    }

    //MARK: Translate Reponse LogOut
    ///Return Object mensaje logout.
    class func translateResponseLogOutBE(_ objDic : NSDictionary) -> ResponseLogOutBE {
        let objLogOutBE = ResponseLogOutBE()
        objLogOutBE.message = objDic["message"] as? String
        return objLogOutBE
    }
}
