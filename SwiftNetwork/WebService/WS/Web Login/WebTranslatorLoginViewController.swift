//
//  WebTranslator.swift
//  Blubinn
//
//  Created by Eddy Donald Chinchay Lujan on 6/4/21.
//

import UIKit
class WebTranslatorLoginViewController: NSObject {
    
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
    

}
