//
//  SearchBC.swift
//  SwiftNetwork
//
//  Created by Eddy Donald Chinchay Lujan on 9/5/21.
//

import UIKit

class SearchBC: NSObject {
    
    @discardableResult class func search(_ objSearch: UserSearchBE,
                                         _ token: String?,
                                         conCompletionCorrecto completioCorrecto: @escaping Closures.SearchUser,
                                         conCompletionIncorrecto completionIncorrecto : @escaping Closures.MensajeError) -> URLSessionDataTask? {
        if objSearch.name?.count == 0 {
            completionIncorrecto("You need enter your name")
            return nil
        }
        
        let resultSearch = WebModel.startSearch(objSearch, token!, conCompletionCorrecto: { (objSearch) in
            completioCorrecto(objSearch)
        }, error: { (mensajeError) in
            print("mensajeError")
            completionIncorrecto(mensajeError)
        })
        
        return resultSearch
    }
}
