//
//  WebTranslator.swift
//  Blubinn
//
//  Created by Eddy Donald Chinchay Lujan on 6/4/21.
//

import UIKit
class WebTranslatorLoginViewController: NSObject {
    
    static let shared = WebTranslatorLoginViewController()
    
    
    /*class func translateUsuarioBE(_ objDic : NSDictionary) -> UserBE {
        let objBE = UserBE()
        objBE.name = objDic["name"] as? String
        objBE.username = objDic["username"] as? String
        objBE.email = objDic["email"] as? String
        objBE.password = objDic["password"] as? String
        return objBE
    }
    
    class func translateResponseTokenBE(_ objDic : NSDictionary) -> ResponseTokenBE {
        
        let objTokenBE = ResponseTokenBE()
        objTokenBE.token = objDic["token"] as? String
        objTokenBE.tokenType = objDic["token_type"] as? String
        objTokenBE.expiresIn  = objDic["expires_in"] as? Int
        return objTokenBE
    }*/
 
    
    public func translateResponseTokenBE(_ objDic : NSDictionary, completion: @escaping ((Result<ResponseTokenBE, Error>)) -> Void) {
        
        var responseTokenBE: ResponseTokenBE?
        do {
            let jsonData:NSData = try JSONSerialization.data(withJSONObject: objDic,
                                                             options: JSONSerialization.WritingOptions.prettyPrinted) as NSData
            guard let jsonString = String(data: jsonData as Data, encoding: String.Encoding.utf8) else {
                return
            }
            guard let json = jsonString.data(using: .utf8) else {
                return
            }
            responseTokenBE = try JSONDecoder().decode(ResponseTokenBE.self, from: json)
            if let responseTokenBE = responseTokenBE {
                completion(.success(responseTokenBE))
            } else {
                print("Failed to pase")
                completion(.failure(Error.self as! Error) )
            }
        } catch {
            print("--- translateResponseUserPostBE ::::: error")
        }
        
    }
    
    class func translateResponseLogOutBE(_ objDic : NSDictionary) -> ResponseLogOutBE {
        let objLogOutBE = ResponseLogOutBE()
        objLogOutBE.message = objDic["message"] as? String
        return objLogOutBE
    }
}
