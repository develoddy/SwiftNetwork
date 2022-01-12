//
//  Token.swift
//  SwiftNetwork
//
//  Created by Eddy Donald Chinchay Lujan on 11/1/22.
//

import Foundation
import UIKit

class Token {
    
    static let shared = Token()
    
    public func getUserToken() -> ResponseTokenBE {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        guard let token = appDelegate.objUsuarioSesion else {
            return getUserToken()
        }
        return token
    }
}
