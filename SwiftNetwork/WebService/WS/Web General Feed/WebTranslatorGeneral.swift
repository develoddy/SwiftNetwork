//
//  WebTranslatorGeneral.swift
//  SwiftNetwork
//
//  Created by Eddy Donald Chinchay Lujan on 20/5/21.
//

import Foundation

class WebTranslatorGeneral: NSObject {
    
    class func translateResponsePostLikeBE(_ objDic : NSDictionary) -> IReqResponsePostLike { // [PostLikeResponse]
        let iReqResponsePostLike = IReqResponsePostLike()
       
        ///Convert Object dicctionary a Json Codable IReqResponsePostLike
        ///Return Object Codable
        do {
            let jsonData:NSData = try JSONSerialization.data(withJSONObject  : objDic,
                                                             options: JSONSerialization.WritingOptions.prettyPrinted) as NSData
            let jsonString = String(data: jsonData as Data,
                                    encoding: String.Encoding.utf8)
            let json = jsonString!.data(using: .utf8)!
            let jsonPostLike = try! JSONDecoder().decode(IReqResponsePostLike.self, from: json)
            
            return jsonPostLike
        } catch {
            return iReqResponsePostLike
        }
    }
}
