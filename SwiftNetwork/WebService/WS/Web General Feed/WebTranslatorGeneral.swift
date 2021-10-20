//
//  WebTranslatorGeneral.swift
//  SwiftNetwork
//
//  Created by Eddy Donald Chinchay Lujan on 20/5/21.
//

import Foundation

class WebTranslatorGeneral: NSObject {
    
    static let shared = WebTranslatorGeneral()
    
    ///Convert Object dicctionary a Json Codable IReqResponseUserPost
    ///Return Object Codable
    //class func translateResponseUserPostBE(_ objDic : NSDictionary) -> UserPost {
    //public func parseUserPostJSON(_ objDic : NSDictionary, completion: @escaping (UserPost) -> Void ) {
    public func translateResponseUserPostBE(_ objDic : NSDictionary, completion: @escaping ((Result<UserPost, Error>)) -> Void) {
        var userPost: UserPost?
        do {
            let jsonData:NSData = try JSONSerialization.data(withJSONObject: objDic,
                                                             options: JSONSerialization.WritingOptions.prettyPrinted) as NSData
            //let jsonString = String(data: jsonData as Data, encoding: String.Encoding.utf8)
            guard let jsonString = String(data: jsonData as Data, encoding: String.Encoding.utf8) else {
                return
            }
            //let json = jsonString.data(using: .utf8)
            guard let json = jsonString.data(using: .utf8) else {
                return
            }
            userPost = try JSONDecoder().decode(UserPost.self, from: json)
            if let userPost = userPost {
                ///print(userPost)
                completion(.success(userPost))
            } else {
                print("Failed to pase")
                completion(.failure(Error.self as! Error) )
            }
        } catch {
            print("--- translateResponseUserPostBE ::::: error")
        }
        
    }
    
    
    
   
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    /*public func parseUserPostJSON( completion: @escaping (IReqResponseUserPost) -> Void ) {
        let file = "userPostJson"
        ///Valdate if exists file or not
     
        guard let path = Bundle.main.path(forResource: file, ofType: "json") else { return }
        let url = URL(fileURLWithPath: path) ///Get url json
        var userPostViewModel: IReqResponseUserPost? ////Instancia el modelo codable
        do {
            let jsonData = try Data(contentsOf: url)
            userPostViewModel = try JSONDecoder().decode(IReqResponseUserPost.self, from: jsonData)
            if let userPostViewModel = userPostViewModel {
                completion(userPostViewModel)
            } else {
                print("Failed to pase")
            }
        } catch {
            print("Error: \(error)")
        }
    }*/
    
    /*
     
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
     
     */
    
    
    
    
    
    
    
    /*
    
    class func translateResponsePostLikeBE(_ objDic : NSDictionary) -> IReqResponseFeaturePosLike  { // IReqResponsePostLike
        //let iReqResponsePostLike = IReqResponsePostLike()
       
        ///Convert Object dicctionary a Json Codable IReqResponsePostLike
        ///Return Object Codable
        var respuestaJSON: Any?
        do {
            let jsonData:NSData = try JSONSerialization.data(withJSONObject: objDic, options: JSONSerialization.WritingOptions.prettyPrinted) as NSData
            let jsonString = String(data: jsonData as Data, encoding: String.Encoding.utf8)
            let json = jsonString!.data(using: .utf8)!
            respuestaJSON  = try! JSONDecoder().decode(IReqResponseFeaturePosLike.self, from: json)
            return respuestaJSON as! IReqResponseFeaturePosLike //jsonPostLike
        } catch {
            return respuestaJSON as! IReqResponseFeaturePosLike
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
 
 
    */
}
