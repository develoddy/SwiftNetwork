//
//  ProfileBC.swift
//  SwiftNetwork
//
//  Created by Eddy Donald Chinchay Lujan on 18/5/21.
//

import UIKit

class GeneralBC: NSObject {
    
    ///This functions receives by parameter the token
    ///Call to WebModel - startApiToGetPostLikeData
    ///Return object codable iReqResponsePostLike, On the contrary mensajeError
    @discardableResult class
    func apiToGetPostLikeDataBC(_ token                                        : String?                                ,
                                conCompletionCorrecto completioCorrecto        : @escaping Closures.iReqResponsePostLike,
                                conCompletionIncorrecto completionIncorrecto   : @escaping Closures.MensajeError        ) -> URLSessionDataTask? {
        let result = WebModelGeneral.startApiToGetPostLikeData(token!, conCompletionCorrecto: { (objPostLike) in
            completioCorrecto(objPostLike)
        }, error: { (mensajeError) in
            completionIncorrecto(mensajeError)
        })
        return result
    }
    
    ///This functions receives by parameter the token
    ///Call to WebModel - startApiToGetPostLikeData
    ///Return object codable iReqResponsePostLike, On the contrary mensajeError
    /*@discardableResult class
    func apiToGetPostCommentsDataBC(_ token                                        : String?                                    ,
                                    conCompletionCorrecto completioCorrecto        : @escaping Closures.iReqResponsePostComments,
                                    conCompletionIncorrecto completionIncorrecto   : @escaping Closures.MensajeError            ) -> URLSessionDataTask? {
        
        return result
    }*/
}
