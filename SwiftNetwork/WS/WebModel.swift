//
//  WebModel.swift
//  Blubinn
//
//  Created by Eddy Donald Chinchay Lujan on 6/4/21.
//


import UIKit

class WebModel: NSObject {

    static let CDMWebModelURLBase : NSString = Constants.ApiRoutes.login as NSString

    @discardableResult class func iniciarSesion(_ objUser : UserBE,
                                                conCompletionCorrecto completionCorrecto : @escaping Closures.Login,
                                                error procesoIncorrecto : @escaping Closures.MensajeError) -> URLSessionDataTask? {
        
        let dic : [String : Any] = ["email"         : objUser.email!,
                                    "password"      : objUser.password!,
                                    "typedevice"    : 1,
                                    "tokendevice"   : "Se debe enviar el token push del dispositivo"]
        
        return WebSender.doPOSTToURL(conURL: self.CDMWebModelURLBase, conPath: "api/auth/login" as NSString, conParametros: dic) { (objRespuesta) in
            
            let diccionarioRespuesta = objRespuesta.respuestaJSON as? NSDictionary
            let arrayRespuesta = diccionarioRespuesta!["error"]
            let mensajeError = WebModel.obtenerMensajeDeError(paraData: diccionarioRespuesta)
            
            if arrayRespuesta == nil {
                if diccionarioRespuesta != nil && diccionarioRespuesta!.count != 0 {
                    let objUsuario = WebTranslator.translateResponseTokenBE(diccionarioRespuesta! )
                    completionCorrecto(objUsuario)
                }
            } else {
                if  arrayRespuesta as! String == Constants.Error.unauthorized {
                    let mensajeErrorFinal = (diccionarioRespuesta != nil && diccionarioRespuesta?.count == 0) ? Constants.LogInError.logInInvalidte : mensajeError
                   procesoIncorrecto(mensajeErrorFinal)
               }
            }
        }
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

