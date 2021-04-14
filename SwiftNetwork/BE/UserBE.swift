//
//  UserBE.swift
//  Blubinn
//
//  Created by Eddy Donald Chinchay Lujan on 6/4/21.
//

import UIKit



class ResponseTokenBE: NSObject, NSCoding {
    
    var token       : String?
    var tokenType   : String?
    var expiresIn   : Int?
    
    override init() {
        super.init()
    }

    required init(coder aDecoder: NSCoder) {
        
        self.token      = aDecoder.decodeObject(forKey: "token")      as? String
        self.tokenType  = aDecoder.decodeObject(forKey: "tokenType")  as? String
        self.expiresIn  = aDecoder.decodeObject(forKey: "expiresIn")  as? Int
    }

    func encode(with aCoder: NSCoder) {
        
        aCoder.encode(self.token,       forKey: "usuario_id")
        aCoder.encode(self.tokenType,   forKey: "usuario_name")
        aCoder.encode(self.expiresIn,   forKey: "usuario_lastname")
    }
}

class UserBE: NSObject, NSCoding {
    
    var name                : String?
    var username            : String?
    var email               : String?
    var password            : String?
    
    override init() {
        super.init()
    }

    required init(coder aDecoder: NSCoder) {
        
        self.name                 = aDecoder.decodeObject(forKey: "name")               as? String
        self.username               = aDecoder.decodeObject(forKey: "username")             as? String
        self.email           = aDecoder.decodeObject(forKey: "email")         as? String
        self.password              = aDecoder.decodeObject(forKey: "password")                    as? String
    }

    func encode(with aCoder: NSCoder) {
        
        aCoder.encode(self.name,                  forKey: "usuario_id")
        aCoder.encode(self.username,                forKey: "usuario_name")
        aCoder.encode(self.email,            forKey: "usuario_lastname")
        aCoder.encode(self.password,               forKey: "email")
    }
}
