//
//  WebTranslatorGeneral.swift
//  SwiftNetwork
//
//  Created by Eddy Donald Chinchay Lujan on 20/5/21.
//

import Foundation

class WebTranslatorGeneral: NSObject {
    
    class func translateResponsePostLikeBE(_ objDic : NSDictionary) -> IReqResponsePostLike { // [PostLikeResponse]
        //let iReqResponsePostLike = IReqResponsePostLike()
       
        ///Convert Object dicctionary a Json Codable IReqResponsePostLike
        ///Return Object Codable
        var respuestaJSON: Any?
        do {
            let jsonData:NSData = try JSONSerialization.data(withJSONObject: objDic, options: JSONSerialization.WritingOptions.prettyPrinted) as NSData
            let jsonString = String(data: jsonData as Data, encoding: String.Encoding.utf8)
            let json = jsonString!.data(using: .utf8)!
            /*let jsonPostLike*/ respuestaJSON  = try! JSONDecoder().decode(IReqResponsePostLike.self, from: json)
            
            return respuestaJSON as! IReqResponsePostLike //jsonPostLike
        } catch {
            return respuestaJSON as! IReqResponsePostLike
        }
    }
    
    ///Convert Object dicctionary a Json Codable IReqResponsePostComments
    ///Return Object Codable
    class func translateResponsePostCommentsBE(_ objDic : NSDictionary) -> IReqResponsePostComments {
        //let iReqResponsePostComments = IReqResponsePostComments()
        var respuestaJSON: Any?
        do {
            let jsonData:NSData = try JSONSerialization.data(withJSONObject: objDic, options: JSONSerialization.WritingOptions.prettyPrinted) as NSData
            let jsonString = String(data: jsonData as Data, encoding: String.Encoding.utf8)
            let json = jsonString!.data(using: .utf8)!
            /*let jsonPostComments*/ respuestaJSON = try! JSONDecoder().decode(IReqResponsePostComments.self, from: json)
            ///print(respuestaJSON)
            return respuestaJSON as! IReqResponsePostComments //jsonPostComments
        } catch {
            return respuestaJSON as! IReqResponsePostComments
        }
    }
    
    ///Convert Object dicctionary a Json Codable IReqResponseUser
    ///Return Object Codable
    class func translateResponseUsersBE(_ objDic : NSDictionary) -> IReqResponseUser {
        var iReqResponseUser = IReqResponseUser()
        do {
            let jsonData:NSData = try JSONSerialization.data(withJSONObject: objDic, options: JSONSerialization.WritingOptions.prettyPrinted) as NSData
            let jsonString = String(data: jsonData as Data, encoding: String.Encoding.utf8)
            let json = jsonString!.data(using: .utf8)!
            iReqResponseUser = try! JSONDecoder().decode(IReqResponseUser.self, from: json)
            return iReqResponseUser
        } catch {
            return iReqResponseUser
        }
    }
    
    ///Convert Object dicctionary a Json Codable IReqResponseUserPost
    ///Return Object Codable
    class func translateResponseUserPostBE(_ objDic : NSDictionary) -> IReqResponseUserPost {

        var iReqResponseUserPost = IReqResponseUserPost()
        do {
            let jsonData:NSData = try JSONSerialization.data(withJSONObject: objDic, options: JSONSerialization.WritingOptions.prettyPrinted) as NSData
            let jsonString = String(data: jsonData as Data, encoding: String.Encoding.utf8)
            let json = jsonString!.data(using: .utf8)!
            iReqResponseUserPost = try! JSONDecoder().decode(IReqResponseUserPost.self, from: json)
            return iReqResponseUserPost
        } catch {
            return iReqResponseUserPost
        }
    }
}
