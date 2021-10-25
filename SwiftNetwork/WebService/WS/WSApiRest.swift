//
//  WebModel.swift
//  Blubinn
//
//  Created by Eddy Donald Chinchay Lujan on 6/4/21.
//


import UIKit

// Class BECodable

// Class BCApiRest

// Class WSApiRest
// Class WSTranslator

//class WebModelLoginViewController: NSObject {

class WSApiRest: NSObject {
    
    static let CDMWebModelURLBase : NSString = Constants.ApiRoutes.login as NSString
    
    //MARK: Session Sign out
    ///Llamaremos al backend.
    ///Recibe por parametros el tokekn de la App.
    @discardableResult
    class func sesionSignOut(_ token                                 : String                         ,
                             conCompletionCorrecto completionCorrecto: @escaping Closures.LogOut      ,
                             error procesoIncorrecto                 : @escaping Closures.MensajeError) -> URLSessionDataTask? {
        let dic : [Any]? = nil
        return WSender.doPOSTTokenToURL(conURL: self.CDMWebModelURLBase, conPath: "api/auth/logout" as NSString, conParametros: dic,  conToken: token) { (objRespuesta) in
            let diccionarioRespuesta = objRespuesta.respuestaJSON as? NSDictionary
            let arrayRespuesta = diccionarioRespuesta!["error"]
            let mensajeError = WSApiRest.obtenerMensajeDeError(paraData: diccionarioRespuesta)
            if arrayRespuesta == nil {
                if diccionarioRespuesta != nil && diccionarioRespuesta!.count != 0 {
                    let objUsuario = WSTranslator.translateResponseLogOutBE(diccionarioRespuesta!)
                    completionCorrecto(objUsuario)
                }
            } else if  arrayRespuesta as! String == Constants.Error.unauthorized {
                let mensajeErrorFinal = (diccionarioRespuesta != nil && diccionarioRespuesta?.count == 0) ? Constants.LogInError.logInInvalidte : mensajeError
                   procesoIncorrecto(mensajeErrorFinal)
            }
        }
    }
    
    //MARK: Iniciar Session
    ///Llamaremos al backend.
    ///Recibe por parametros el tokekn de la App.
    @discardableResult
    class func iniciarSesion(_ objUser                                : UserBE                         ,
                             conCompletionCorrecto completionCorrecto : @escaping Closures.Login       ,
                             error procesoIncorrecto                  : @escaping Closures.MensajeError) -> URLSessionDataTask? {
        let dic : [String : Any] = ["email"         : objUser.email!                                ,
                                    "password"      : objUser.password!                             ,
                                    "typedevice"    : 1                                             ,
                                    "tokendevice"   : "Se debe enviar el token push del dispositivo"]
        return WSender.doPOSTToURL(conURL: self.CDMWebModelURLBase, conPath: "api/auth/login" as NSString, conParametros: dic) { (objRespuesta) in
            let diccionarioRespuesta = objRespuesta.respuestaJSON as? NSDictionary
            let arrayRespuesta = diccionarioRespuesta!["error"]
            let mensajeError = WSApiRest.obtenerMensajeDeError(paraData: diccionarioRespuesta)
            if arrayRespuesta == nil {
                if diccionarioRespuesta != nil && diccionarioRespuesta!.count != 0 {
                    guard let diccionarioRespuesta = diccionarioRespuesta else { return }
                    WSTranslator.translateResponseTokenBE(diccionarioRespuesta) { (result) in
                        switch result {
                        case .success(let userPost): completionCorrecto(userPost)
                        case .failure(let error): print(error.localizedDescription)
                        }
                    }
                }
            } else if arrayRespuesta as! String == Constants.Error.unauthorized {
                    let mensajeErrorFinal = (diccionarioRespuesta != nil && diccionarioRespuesta?.count == 0) ? Constants.LogInError.logInInvalidte : mensajeError
                   procesoIncorrecto(mensajeErrorFinal)
            }
        }
    }
    
    //MARK: Session Sign in
    ///Llamaremos al backend.
    ///Recibe por parametros el tokekn de la App.
    @discardableResult
    class func sesionSignIn(_ objUser                                : UserBE                         ,
                            conCompletionCorrecto completionCorrecto : @escaping Closures.Login       ,
                            error procesoIncorrecto                  : @escaping Closures.MensajeError) -> URLSessionDataTask? {
        let dic : [String : Any] = ["name"          : objUser.name!                                 ,
                                    "username"      : objUser.username!                             ,
                                    "email"         : objUser.email!                                ,
                                    "password"      : objUser.password!                             ,
                                    "typedevice"    : 1                                             ,
                                    "tokendevice"   : "Se debe enviar el token push del dispositivo"]
        
        return WSender.doPOSTToURL(conURL: self.CDMWebModelURLBase, conPath: "api/auth/signup" as NSString, conParametros: dic) { (objRespuesta) in
            let diccionarioRespuesta = objRespuesta.respuestaJSON as? NSDictionary
            let arrayRespuesta = diccionarioRespuesta!["error"]
            let mensajeError = WSApiRest.obtenerMensajeDeError(paraData: diccionarioRespuesta)
            if arrayRespuesta == nil {
                if diccionarioRespuesta != nil && diccionarioRespuesta!.count != 0 {
                    guard let diccionarioRespuesta = diccionarioRespuesta else { return }
                    WSTranslator.translateResponseTokenBE(diccionarioRespuesta) { (result) in
                        switch result {
                            case .success(let userPost): completionCorrecto(userPost)
                            case .failure(let error): print(error.localizedDescription)
                        }
                    }
                }
            } else if arrayRespuesta as! String == Constants.Error.unauthorized {
                    let mensajeErrorFinal = (diccionarioRespuesta != nil && diccionarioRespuesta?.count == 0) ? Constants.LogInError.logInInvalidte : mensajeError
                   procesoIncorrecto(mensajeErrorFinal)
            }
        }
    }

    //MARK: Start Api User Post.
    ///Parametros Token & UserPost
    @discardableResult class
    func startApiUserPost(_ token                                 : String?                        ,
                          conCompletionCorrecto completionCorrecto: @escaping Closures.userPost    ,
                          error procesoIncorrecto                 : @escaping Closures.MensajeError) -> URLSessionDataTask? {
        let dic : [Any]? = nil ///let dic : [String : Any] = [ "tabs": tabs as Any ]
        let result = WSender.doGETTokenToURL(conURL       : WSApiRest.CDMWebModelURLBase    ,
                                               conPath      : "api/auth/home/userpost" as NSString  ,
                                               conParametros: dic                                   ,
                                               conToken     : token ?? ""                           ) { (objRespuesta) in
            let diccionarioRespuesta = objRespuesta.respuestaJSON as? NSDictionary
            let arrayRespuesta       = diccionarioRespuesta?["error"]
            //let mensajeError         = WebModelGeneral.obtenerMensajeDeError(paraData: diccionarioRespuesta)
            let mensajeError         = WSApiRest.obtenerMensajeDeError(paraData: diccionarioRespuesta)
            if arrayRespuesta == nil {
                if diccionarioRespuesta != nil && diccionarioRespuesta!.count != 0 {
                    guard let diccionarioRespuesta = diccionarioRespuesta else { return }
                    WSTranslator.translateResponseUserPostBE(diccionarioRespuesta) { ( result ) in
                        switch result {
                        case .success(let userPost): completionCorrecto(userPost)
                        case .failure(let error): print(error.localizedDescription)
                        }
                    }
                }
            } else if  arrayRespuesta as! String == Constants.Error.unauthorized {
                let mensajeErrorFinal = (diccionarioRespuesta != nil && diccionarioRespuesta?.count == 0) ? Constants.LogInError.logInInvalidte: mensajeError
                procesoIncorrecto(mensajeErrorFinal)
            }
        }
        return result
    }
    
    //MARK: A call is made to the backend
    ///Explore
    ///Parametros Token y Object UserSearchBE
    @discardableResult class func startSearch(_ objSearch                              : UserSearchBE                   ,
                                              _ token                                  : String?                        ,
                                              conCompletionCorrecto completionCorrecto : @escaping Closures.SearchUser  ,
                                              error procesoIncorrecto                  : @escaping Closures.MensajeError) -> URLSessionDataTask? {
        let dic : [String : Any] = ["name"       : objSearch.name ?? ""                          ,
                                    "typedevice" : 1                                             ,
                                    "tokendevice": "Se debe enviar el token push del dispositivo"]
        let resultSearch = WSender.doPOSTTokenToURL(conURL       : self.CDMWebModelURLBase            ,
                                                      conPath      : "api/auth/home/search" as NSString ,
                                                      conParametros: dic                                ,
                                                      conToken     : token ?? ""                        ) { ( objRespuesta ) in
            let diccionarioRespuesta = objRespuesta.respuestaJSON as? NSDictionary
            let arrayRespuesta       = diccionarioRespuesta?["error"]
            let mensajeError         = WSApiRest.obtenerMensajeDeError(paraData: diccionarioRespuesta)
            if arrayRespuesta == nil {
                if diccionarioRespuesta != nil && diccionarioRespuesta!.count != 0 {
                    let objUsuario = WSTranslator.translateResponseSearchnBE(diccionarioRespuesta!)
                    completionCorrecto(objUsuario)
                }
            } else if  arrayRespuesta as! String == Constants.Error.unauthorized {
                let mensajeErrorFinal = (diccionarioRespuesta != nil && diccionarioRespuesta?.count == 0) ? Constants.LogInError.logInInvalidte: mensajeError
                   procesoIncorrecto(mensajeErrorFinal)
            }
        }
        return resultSearch
    }
    
    //MARK: Manejo de mensajes de error y status.
    ///Return object mensaje error.
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
