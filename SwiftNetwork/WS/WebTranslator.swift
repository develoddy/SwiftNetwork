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
        
        objBE.name                = objDic["name"] as? String
        objBE.username              = objDic["username"] as? String
        objBE.email          = objDic["email"] as? String
        objBE.password             = objDic["password"] as? String
        
        return objBE
        
    }
    
    class func translateResponseTokenBE(_ objDic : NSDictionary) -> ResponseTokenBE {
        
        let objTokenBE = ResponseTokenBE()
        
        objTokenBE.token = objDic["name"] as? String
        objTokenBE.tokenType = objDic["username"] as? String
        objTokenBE.expiresIn  = objDic["email"] as? Int
        
        return objTokenBE
    }
    
}
