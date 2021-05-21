//
//  WebTranslatorSearchViewController.swift
//  SwiftNetwork
//
//  Created by Eddy Donald Chinchay Lujan on 21/5/21.
//

import Foundation

class WebTranslatorSearchViewController : NSObject {
    
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
