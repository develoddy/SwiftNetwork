//
//  ProfileBC.swift
//  SwiftNetwork
//
//  Created by Eddy Donald Chinchay Lujan on 18/5/21.
//

import UIKit

class GeneralBC: NSObject {
    
    ///static let shared = GeneralBC()
    
    ///VAMOS A LLAMAR A LA BASE DE DATOS PARA OBTENER EL OBJETO USERPOST
    ///ESTA FUNCION RECIBE POR PARAMETRO EL TOKEN
    ///RETURN OBJETO USERPOST O DE LO CONTRARIO UN MENSAJE DE ERROR.
    
    @discardableResult class
    public func apiUserPostBC(_ token: String?,
                              conCompletionCorrecto completioCorrecto:  @escaping Closures.userPost,
                              conCompletionIncorrecto completionIncorrecto: @escaping Closures.MensajeError) -> URLSessionDataTask? {
        
        let result = WebModelGeneral.startApiUserPost(token, conCompletionCorrecto: { (data) in
            completioCorrecto(data)
        }, error: { (messageError) in
            completionIncorrecto(messageError)
        })
        return result
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    /*
    ///This functions receives by parameter the token
    ///Call to WebModel - startApiToGetPostLikeData
    ///Return object codable iReqResponsePostLike, On the contrary mensajeError
    @discardableResult class
    func apiToGetPostLikeDataBC(_ token                                        : String?,
                                _ tabs                                        : String?,
                                conCompletionCorrecto completioCorrecto        : @escaping Closures.iReqResponsePostLike,
                                conCompletionIncorrecto completionIncorrecto   : @escaping Closures.MensajeError        ) -> URLSessionDataTask? {
        let result = WebModelGeneral.startApiToGetPostLikeData(token!, tabs, conCompletionCorrecto: { (objPostLike) in
            completioCorrecto(objPostLike)
        }, error: { (mensajeError) in
            completionIncorrecto(mensajeError)
        })
        return result
    }
    
    ///This functions receives by parameter the token
    ///Call to WebModel - startApiToGetPostCommentsData
    ///Return object codable IReqResponsePostComments, On the contrary mensajeError
    @discardableResult class
    func apiToGetPostCommentsDataBC(_ token                                        : String?  ,
                                    _ tabs                                         : String?  ,
                                    conCompletionCorrecto completioCorrecto        : @escaping Closures.iReqResponsePostComments,
                                    conCompletionIncorrecto completionIncorrecto   : @escaping Closures.MensajeError            ) -> URLSessionDataTask? {
        let result = WebModelGeneral.startApiToGetPostCommentsData(token!, tabs, conCompletionCorrecto: { (objPostComments) in
            completioCorrecto(objPostComments)
        }, error: { (mensajeError) in
            completionIncorrecto(mensajeError)
        })
        return result
    }
    
    ///User
    ///This functions receives by parameter the token
    ///Call to WebModel - startApiToGetPostCommentsData
    ///Return object codable IReqResponsePostComments, On the contrary mensajeError
    @discardableResult class
    func apiToGetUsersDataBC(_ token                                        : String?                                    ,
                             _ tabs                                         : String?                                    ,
                             conCompletionCorrecto completioCorrecto        : @escaping Closures.iReqResponseUser        ,
                             conCompletionIncorrecto completionIncorrecto   : @escaping Closures.MensajeError            ) -> URLSessionDataTask? {
        let result = WebModelGeneral.startApiToGetUsersData(token!, tabs, conCompletionCorrecto: { (objUsers) in
            completioCorrecto(objUsers)
        }, error: { (mensajeError) in
            completionIncorrecto(mensajeError)
        })
        return result
    }
   
    
    
    ///This functions receives by parameter the token
    ///Call to WebModel - startApiToGetPostCommentsData
    ///Return object codable IReqResponsePostComments, On the contrary mensajeError
    @discardableResult class
    func apiToGetUserPostDataBC(_ token                                        : String? ,
                                _ tabs                                         : String? ,
                                conCompletionCorrecto completioCorrecto        : @escaping Closures.iReqResponseUserPost    ,
                                conCompletionIncorrecto completionIncorrecto   : @escaping Closures.MensajeError            ) -> URLSessionDataTask? {
        let result = WebModelGeneral.startApiToGetUserPostData(token!,tabs, conCompletionCorrecto: { (objUserpost) in
            completioCorrecto(objUserpost)
        }, error: { (mensajeError) in
            completionIncorrecto(mensajeError)
        })
        return result
    }
 
     */
}
