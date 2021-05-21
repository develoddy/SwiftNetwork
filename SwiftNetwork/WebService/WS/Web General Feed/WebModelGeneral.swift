//
//  WebModelGeneral.swift
//  SwiftNetwork
//
//  Created by Eddy Donald Chinchay Lujan on 20/5/21.
//

import Foundation

class WebModelGeneral: NSObject {

    static let CDMWebModelURLBase : NSString = Constants.ApiRoutes.login as NSString

    //MARK:  A call is made to the backend
    
    ///This functions receives by parameter the token
    ///Call to WebSender - doGETTokenToURL sending by parameters :
    /// - Url, Path, Dic and token
    ///Return object codable iReqResponsePostLike, On the contrary mensajeError
    @discardableResult class func  startApiToGetPostLikeData(_ token: String?,
                                                             conCompletionCorrecto completionCorrecto : @escaping Closures.iReqResponsePostLike ,
                                                             error procesoIncorrecto : @escaping Closures.MensajeError) -> URLSessionDataTask? {
        let dic : [Any]? = nil
        let result = WebSender.doGETTokenToURL(conURL: self.CDMWebModelURLBase,
                                               conPath: "api/auth/likes" as NSString,
                                               conParametros: dic,
                                               conToken: token! as NSString) { (objRespuesta) in
            
            let diccionarioRespuesta = objRespuesta.respuestaJSON as? NSDictionary
            let arrayRespuesta       = diccionarioRespuesta?["error"]
            let mensajeError         = WebModelGeneral.obtenerMensajeDeError(paraData: diccionarioRespuesta)
            if arrayRespuesta == nil {
                if diccionarioRespuesta != nil && diccionarioRespuesta!.count != 0 {
                    let objUsuario = WebTranslatorGeneral.translateResponsePostLikeBE(diccionarioRespuesta!)
                    //print("translateResponsePostLikeBE:: \(objUsuario)")
                    completionCorrecto(objUsuario)
                }
            } else {
                if  arrayRespuesta as! String == Constants.Error.unauthorized {
                    let mensajeErrorFinal = (diccionarioRespuesta != nil && diccionarioRespuesta?.count == 0) ? Constants.LogInError.logInInvalidte: mensajeError
                    
                   procesoIncorrecto(mensajeErrorFinal)///Ko
               }
            }
        }
        return result
    }
    
    
    
    
    
    //MARK: - manejo de mensajes de error y status
    class func obtenerMensajeDeError(paraData data : NSDictionary?) -> String {
      
        var mensajeError = Constants.LogInError.mensajeError
        
        if data != nil && data?["data_error"] != nil  {
            let dataError = data?["data_error"] as? NSDictionary
            if dataError != nil && dataError?["msg"] != nil {
                mensajeError = dataError?["msg"] as! String
            }
        }
        return mensajeError
    }
}