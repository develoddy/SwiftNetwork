//
//  SearchBE.swift
//  SwiftNetwork
//
//  Created by Eddy Donald Chinchay Lujan on 9/5/21.
//

import UIKit


// MARK:  User
class UserSearchBE: NSObject, NSCoding {
    var name: String?

    override init() {
        super.init()
    }

    required init(coder aDecoder: NSCoder) {
        self.name = aDecoder.decodeObject(forKey: "name") as? String
    }

    func encode(with aCoder: NSCoder) {
        aCoder.encode(self.name, forKey: "name")
    }
}

// MARK:  -IReqResponseSearchBE
class IReqResponseSearchBE: NSObject, NSCoding {
    var user: [UserSearchBE]?

    override init() {
        super.init()
    }
    
    required init(coder aDecoder: NSCoder) {
        self.user = aDecoder.decodeObject(forKey: "user") as? [UserSearchBE]
    }

    func encode(with aCoder: NSCoder) {
        aCoder.encode(self.user, forKey: "user")
    }
}




