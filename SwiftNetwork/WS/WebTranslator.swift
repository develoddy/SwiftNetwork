//
//  WebTranslator.swift
//  Blubinn
//
//  Created by Eddy Donald Chinchay Lujan on 6/4/21.
//

import UIKit
class WebTranslator: NSObject {
    
    class func translateUsuarioBE(_ objDic : NSDictionary) -> UserBE {
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
    }
    
    class func translateResponseLogOutBE(_ objDic : NSDictionary) -> ResponseLogOutBE {
        let objLogOutBE = ResponseLogOutBE()
        objLogOutBE.message = objDic["message"] as? String
        return objLogOutBE
    }
    
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
}
