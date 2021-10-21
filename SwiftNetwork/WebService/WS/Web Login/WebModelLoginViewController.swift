//
//  WebModel.swift
//  Blubinn
//
//  Created by Eddy Donald Chinchay Lujan on 6/4/21.
//


import UIKit

class WebModelLoginViewController: NSObject {

    static let CDMWebModelURLBase : NSString = Constants.ApiRoutes.login as NSString
    
    @discardableResult class func sesionSignOut(_ token : String,
                                               conCompletionCorrecto completionCorrecto : @escaping Closures.LogOut,
                                                error procesoIncorrecto : @escaping Closures.MensajeError) -> URLSessionDataTask? {
        return WebSender.doPOSTTLogOutURL(conURL: self.CDMWebModelURLBase, conPath: "api/auth/logout" as NSString, conParametros: token) { (objRespuesta) in
            
            let diccionarioRespuesta = objRespuesta.respuestaJSON as? NSDictionary
            let arrayRespuesta = diccionarioRespuesta!["error"]
            let mensajeError = WebModelLoginViewController.obtenerMensajeDeError(paraData: diccionarioRespuesta)
            
            if arrayRespuesta == nil {
                if diccionarioRespuesta != nil && diccionarioRespuesta!.count != 0 {
                    let objUsuario = WebTranslatorLoginViewController.translateResponseLogOutBE(diccionarioRespuesta!)
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

    @discardableResult class func iniciarSesion(
        _ objUser : UserBE,
        conCompletionCorrecto completionCorrecto : @escaping Closures.Login,
        error procesoIncorrecto : @escaping Closures.MensajeError) -> URLSessionDataTask? {
        
        let dic : [String : Any] = [
            "email"         : objUser.email!    ,
            "password"      : objUser.password! ,
            "typedevice"    : 1                 ,
            "tokendevice"   : "Se debe enviar el token push del dispositivo"]
        
        return WebSender.doPOSTToURL(conURL: self.CDMWebModelURLBase, conPath: "api/auth/login" as NSString, conParametros: dic) { (objRespuesta) in
            
            let diccionarioRespuesta = objRespuesta.respuestaJSON as? NSDictionary
            let arrayRespuesta = diccionarioRespuesta!["error"]
            let mensajeError = WebModelLoginViewController.obtenerMensajeDeError(paraData: diccionarioRespuesta)
            
            if arrayRespuesta == nil {
                if diccionarioRespuesta != nil && diccionarioRespuesta!.count != 0 {
                    ///let objUsuario = WebTranslatorLoginViewController.translateResponseTokenBE(diccionarioRespuesta!)
                    ///completionCorrecto(objUsuario)
                    
                    guard let diccionarioRespuesta = diccionarioRespuesta else {
                        return
                    }
                    WebTranslatorLoginViewController.shared.translateResponseTokenBE(diccionarioRespuesta) { (result) in
                        switch result {
                        case .success(let userPost):
                            completionCorrecto(userPost)
                        case .failure(let error):
                            print(error.localizedDescription)
                        }
                    }
                }
            } else {
                if  arrayRespuesta as! String == Constants.Error.unauthorized {
                    let mensajeErrorFinal = (diccionarioRespuesta != nil && diccionarioRespuesta?.count == 0) ? Constants.LogInError.logInInvalidte : mensajeError
                   procesoIncorrecto(mensajeErrorFinal)
               }
            }
        }
    }
    
    
    
    @discardableResult class func sesionSignIn(_ objUser : UserBE,
                                                conCompletionCorrecto completionCorrecto : @escaping Closures.Login,
                                                error procesoIncorrecto : @escaping Closures.MensajeError) -> URLSessionDataTask? {
        let dic : [String : Any] = [
            "name"          : objUser.name!     ,
            "username"      : objUser.username! ,
            "email"         : objUser.email!    ,
            "password"      : objUser.password! ,
            "typedevice"    : 1                 ,
            "tokendevice"   : "Se debe enviar el token push del dispositivo"
        ]
        
        return WebSender.doPOSTToURL(conURL: self.CDMWebModelURLBase, conPath: "api/auth/signup" as NSString, conParametros: dic) { (objRespuesta) in
            
            let diccionarioRespuesta = objRespuesta.respuestaJSON as? NSDictionary
            let arrayRespuesta = diccionarioRespuesta!["error"]
            let mensajeError = WebModelLoginViewController.obtenerMensajeDeError(paraData: diccionarioRespuesta)
            
            if arrayRespuesta == nil {
                if diccionarioRespuesta != nil && diccionarioRespuesta!.count != 0 {
                    guard let diccionarioRespuesta = diccionarioRespuesta else {
                        return
                    }
                    WebTranslatorLoginViewController.shared.translateResponseTokenBE(diccionarioRespuesta) { (result) in
                        switch result {
                            case .success(let userPost):
                                completionCorrecto(userPost)
                            case .failure(let error):
                                print(error.localizedDescription)
                        }
                    }
                    ///let objUsuario =  WebTranslatorLoginViewController.shared.translateResponseTokenBE(diccionarioRespuesta)
                    ///completionCorrecto(objUsuario)
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

