//
//  WebModelSearchViewController.swift
//  SwiftNetwork
//
//  Created by Eddy Donald Chinchay Lujan on 21/5/21.
//

import Foundation

class WebModelSearchViewController: NSObject {
    
    static let CDMWebModelURLBase : NSString = Constants.ApiRoutes.login as NSString
    
    //MARK: A call is made to the backend
    @discardableResult class func  startSearch(_ objSearch : UserSearchBE,
                                               _ token: String?,
                                               conCompletionCorrecto completionCorrecto : @escaping Closures.SearchUser,
                                               error procesoIncorrecto : @escaping Closures.MensajeError) -> URLSessionDataTask? {
        
        let dic : [String : Any] = [ "name": objSearch.name!,
                                     "typedevice": 1,
                                     "tokendevice": "Se debe enviar el token push del dispositivo"]
        
        let resultSearch = WebSender.doPOSTTokenToURL(conURL: self.CDMWebModelURLBase,
                                                      conPath: "api/auth/listNameUser" as NSString,
                                                      conParametros: dic,
                                                      conToken: token! as NSString) { (objRespuesta) in
    
            let diccionarioRespuesta = objRespuesta.respuestaJSON as? NSDictionary
            let arrayRespuesta       = diccionarioRespuesta?["error"]
            let mensajeError         = WebModelSearchViewController.obtenerMensajeDeError(paraData: diccionarioRespuesta)
            if arrayRespuesta == nil {
                if diccionarioRespuesta != nil && diccionarioRespuesta!.count != 0 {
                    let objUsuario = WebTranslatorSearchViewController.translateResponseSearchnBE(diccionarioRespuesta!)
                    completionCorrecto(objUsuario)///Success
                }
            } else {
                if  arrayRespuesta as! String == Constants.Error.unauthorized {
                    let mensajeErrorFinal = (diccionarioRespuesta != nil && diccionarioRespuesta?.count == 0) ? Constants.LogInError.logInInvalidte: mensajeError
                   procesoIncorrecto(mensajeErrorFinal)///Ko
               }
            }
        }
        return resultSearch
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
