//
//  UserBE.swift
//  Blubinn
//
//  Created by Eddy Donald Chinchay Lujan on 6/4/21.
//

import UIKit

class ResponseLogOutBE: NSObject, NSCoding {
    var message : String?
    
    override init() {
        super.init()
    }

    required init(coder aDecoder: NSCoder) {
        self.message = aDecoder.decodeObject(forKey: "message") as? String
    }

    func encode(with aCoder: NSCoder) {
        aCoder.encode(self.message, forKey: "message")
    }
}

class ResponseTokenBE: NSObject, NSCoding {
    var token       : String?
    var tokenType   : String?
    var expiresIn   : Int?
    var user:       UserBE?
    
    override init() {
        super.init()
    }

    required init(coder aDecoder: NSCoder) {
        self.token      = aDecoder.decodeObject(forKey: "token")      as? String
        self.tokenType  = aDecoder.decodeObject(forKey: "tokenType")  as? String
        self.expiresIn  = aDecoder.decodeObject(forKey: "expiresIn")  as? Int
        self.user  = aDecoder.decodeObject(forKey: "user")  as? UserBE
    }

    func encode(with aCoder: NSCoder) {
        aCoder.encode(self.token,       forKey: "token")
        aCoder.encode(self.tokenType,   forKey: "tokenType")
        aCoder.encode(self.expiresIn,   forKey: "expiresIn")
        aCoder.encode(self.user,   forKey: "user")
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
        self.name      = aDecoder.decodeObject(forKey: "name")     as? String
        self.username  = aDecoder.decodeObject(forKey: "username") as? String
        self.email     = aDecoder.decodeObject(forKey: "email")    as? String
        self.password  = aDecoder.decodeObject(forKey: "password") as? String
    }

    func encode(with aCoder: NSCoder) {
        aCoder.encode(self.name,     forKey: "name")
        aCoder.encode(self.username, forKey: "username")
        aCoder.encode(self.email,    forKey: "email")
        aCoder.encode(self.password, forKey: "password")
    }
}


/*
 
 En su caso, utilice el siguiente código.

 class Blog: Codable {
    var blogName: String?
 }
 Ahora crea su objeto. Por ejemplo:

 var blog = Blog()
 blog.blogName = "My Blog"
 Ahora codifíquelo así:

 if let encoded = try? JSONEncoder().encode(blog) {
     UserDefaults.standard.set(encoded, forKey: "blog")
 }
 y decodificarlo así:

 if let blogData = UserDefaults.standard.data(forKey: "blog"),
     let blog = try? JSONDecoder().decode(Blog.self, from: blogData) {
 }
 
 
 */
