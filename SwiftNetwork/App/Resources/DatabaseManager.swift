//
//  DatabaseManager.swift
//  Blubinn
//
//  Created by Eddy Donald Chinchay Lujan on 31/3/21.
//

import UIKit

class DatabaseManager {
    
    static let shared = DatabaseManager()
    
    // MARK: Public
    
    /// Check if username and email is available
    /// - Parameter
    /// - email: String representing email
    /// - username: String representing username
    public func canCreateNewUser(name: String, email: String?, username: String?, completion: @escaping (Bool) -> Void ) {
        ///Call to API Verificy if existe user
        completion(true)
    }
    
    /// Insert new user data to database
    /// - Parameter
    /// - email: String representing email
    /// - username: String representing username
    public func insertNewUser(with name: String, email: String, username: String) {
        
    }
}
