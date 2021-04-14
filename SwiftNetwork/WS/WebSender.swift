//
//  WebSender.swift
//  Blubinn
//
//  Created by Eddy Donald Chinchay Lujan on 6/4/21.
//



import UIKit

class WebSender: NSObject {
    
    
    //MARK:- Configuración
    
    class func crearCabeceraPeticion() -> NSDictionary {
        
        let diccionarioHeader = NSMutableDictionary()
        diccionarioHeader.setObject("application/json", forKey: "Content-Type" as NSCopying)
        diccionarioHeader.setObject("application/json; charset=UTF-8", forKey: "Content-Type" as NSCopying)
        diccionarioHeader.setObject("application/json", forKey: "Accept" as NSCopying)
        
        return diccionarioHeader
    }
    
    class func crearCabeceraPeticionConToken(_ aToken : NSString) -> NSDictionary {
        
        let diccionarioHeader = NSMutableDictionary()
        diccionarioHeader.setObject("application/json", forKey: "Content-Type" as NSCopying)
        diccionarioHeader.setObject("application/json; charset=UTF-8", forKey: "Content-Type" as NSCopying)
        diccionarioHeader.setObject("application/json", forKey: "Accept" as NSCopying)
        diccionarioHeader.setObject("Token \(aToken)", forKey: "Authorization" as NSCopying)
        
        return diccionarioHeader
    }
    
    class func crearCabeceraPeticionConCookie(_ aCookie : NSString) -> NSDictionary {
        
        let diccionarioHeader = NSMutableDictionary()
        
        diccionarioHeader.setObject("application/json; charset=UTF-8", forKey: "Content-Type" as NSCopying)
        diccionarioHeader.setObject("application/json", forKey: "Accept" as NSCopying)
        diccionarioHeader.setObject("Bearer \(aCookie)", forKey: "Cookie" as NSCopying)
        
        return diccionarioHeader
    }
    
    
    
    //MARK: - Tratado de respuesta
    
    
    class func obtenerRespuestaEnJSONConData(_ data : Data) -> Any? {
        
        do{
            return try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.allowFragments) as Any
        } catch {
            return nil
        }
    }
    

    class func obtenerRespuestaServicio(paraData data           : Data?         ,
                                        conResponse response    : URLResponse?  ,
                                        conError error          : NSError?      ) -> WebResponse {
        var respuesta : Any? = nil
        if error == nil && data != nil {
            respuesta = self.obtenerRespuestaEnJSONConData(data!)
        }
        
        //print("WebSender - respuesta servicio:  \(respuesta!)")
        let urlResponse = response as? HTTPURLResponse
        let headerFields : NSDictionary? = urlResponse?.allHeaderFields as NSDictionary?
        let objRespuesta = WebResponse()
        
        objRespuesta.respuestaJSON      = respuesta
        objRespuesta.statusCode         = urlResponse?.statusCode
        objRespuesta.respuestaNSData    = data
        objRespuesta.error              = error
        objRespuesta.datosCabecera      = headerFields
        objRespuesta.token              = headerFields?["_token"] as? NSString
        objRespuesta.cookie             = headerFields?["_token"] as? NSString
        
        return objRespuesta
    }
    
    
    
    
    //MARK: - Consumo de servicios con cookie
    
    
    @discardableResult class func doPOSTCookieToURL(conURL url                  : NSString                              ,
                                                    conPath path                : NSString                              ,
                                                    conParametros parametros    : Any?                                  ,
                                                    conCookie cookie            : NSString                              ,
                                                    conCompletion completion    : @escaping (_ objRespuesta : WebResponse) -> Void) -> URLSessionDataTask {
        
        let configuracionSesion = URLSessionConfiguration.default
        configuracionSesion.httpAdditionalHeaders = self.crearCabeceraPeticionConCookie(cookie) as? [AnyHashable: Any]
        
        let sesion = URLSession.init(configuration: configuracionSesion)
        
        let urlServicio = URL(string: "\(url)/\(path)")
        let request = NSMutableURLRequest(url: urlServicio!)
        request.addValue("application/json; charset=UTF-8", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        if parametros != nil {
            do {
                request.httpBody = try JSONSerialization.data(withJSONObject: parametros!, options: JSONSerialization.WritingOptions.prettyPrinted)
            } catch {}
        }
        
        request.httpMethod = Constants.Method.httpPost //"POST"
        
        let postDataTask = sesion.dataTask(with: request as URLRequest) { (data, response, error) in
            DispatchQueue.main.async(execute: {
                let objRespuesta = self.obtenerRespuestaServicio(paraData: data, conResponse: response, conError: error as NSError?)
                completion(objRespuesta)
            })
        }
        postDataTask.resume()
        return postDataTask
    }
    
    
    
    
    
    @discardableResult class func doGETCookieToURL(conURL url               : NSString                              ,
                                                   conPath path             : NSString                              ,
                                                   conParametros parametros : Any?                                  ,
                                                   conCookie cookie         : NSString                              ,
                                                   conCompletion completion : @escaping (_ objRespuesta : WebResponse) -> Void) -> URLSessionDataTask {
        
        let configuracionSesion = URLSessionConfiguration.default
        configuracionSesion.httpAdditionalHeaders = self.crearCabeceraPeticionConCookie(cookie) as? [AnyHashable: Any]
        
        let sesion = URLSession.init(configuration: configuracionSesion)
        
        let urlServicio = URL(string: "\(url)/\(path)")
        let request = NSMutableURLRequest(url: urlServicio!)
        request.addValue("application/json; charset=UTF-8", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        if parametros != nil {
            do {
                request.httpBody = try JSONSerialization.data(withJSONObject: parametros!, options: JSONSerialization.WritingOptions.prettyPrinted)
            } catch {}
        }
        
        request.httpMethod = Constants.Method.httpGet //"GET"
        
        let postDataTask = sesion.dataTask(with: request as URLRequest) { (data, response, error) in
            DispatchQueue.main.async(execute: {
                let objRespuesta = self.obtenerRespuestaServicio(paraData: data, conResponse: response, conError: error as NSError?)
                completion(objRespuesta)
            })
        }
        postDataTask.resume()
        return postDataTask
    }
    
    
    
    
    
    @discardableResult class func doPUTCookieToURL(conURL url               : NSString                          ,
                                                   conPath path             : NSString                          ,
                                                   conParametros parametros : Any?                              ,
                                                   conCookie cookie         : NSString                          ,
                                                   conCompletion completion : @escaping (_ objRespuesta : WebResponse) -> Void) -> URLSessionDataTask {
        
        let configuracionSesion = URLSessionConfiguration.default
        configuracionSesion.httpAdditionalHeaders = self.crearCabeceraPeticionConCookie(cookie) as? [AnyHashable: Any]
        
        let sesion = URLSession.init(configuration: configuracionSesion)
        
        let urlServicio = URL(string: "\(url)/\(path)")
        let request = NSMutableURLRequest(url: urlServicio!)
        request.addValue("application/json; charset=UTF-8", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        
        if parametros != nil {
            do {
                request.httpBody = try JSONSerialization.data(withJSONObject: parametros!, options: JSONSerialization.WritingOptions.prettyPrinted)
            } catch {}
        }
        
        request.httpMethod = Constants.Method.httpPut //"PUT"
        
        let postDataTask = sesion.dataTask(with: request as URLRequest) { (data, response, error) in
            DispatchQueue.main.async(execute: {
                let objRespuesta = self.obtenerRespuestaServicio(paraData: data, conResponse: response, conError: error as NSError?)
                completion(objRespuesta)
            })
        }
        postDataTask.resume()
        return postDataTask
    }
    
    
    
    
    //MARK: - Consumo de servicios con token
    

    @discardableResult class func doPOSTTokenToURL(conURL url               : NSString                              ,
                                                   conPath path             : NSString                              ,
                                                   conParametros parametros : Any?                                  ,
                                                   conToken token           : NSString                              ,
                                                   conCompletion completion : @escaping (_ objRespuesta : WebResponse) -> Void) -> URLSessionDataTask {
        
        let configuracionSesion = URLSessionConfiguration.default
        configuracionSesion.httpAdditionalHeaders = self.crearCabeceraPeticionConToken(token) as? [AnyHashable: Any]
        
        let sesion = URLSession.init(configuration: configuracionSesion)
        
        let urlServicio = URL(string: "\(url)/\(path)")
        let request = NSMutableURLRequest(url: urlServicio!)
        request.addValue("application/json; charset=UTF-8", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        if parametros != nil {
            do {
                request.httpBody = try JSONSerialization.data(withJSONObject: parametros!, options: JSONSerialization.WritingOptions.prettyPrinted)
            } catch {}
        }
        
        request.httpMethod = Constants.Method.httpPost //"POST"
        
        let postDataTask = sesion.dataTask(with: request as URLRequest) { (data, response, error) in
            DispatchQueue.main.async(execute: {
                let objRespuesta = self.obtenerRespuestaServicio(paraData: data, conResponse: response, conError: error as NSError?)
                completion(objRespuesta)
            })
        }
        postDataTask.resume()
        return postDataTask
    }
    
    
    
    @discardableResult class func doGETTokenToURL(conURL url                : NSString                              ,
                                                  conPath path              : NSString                              ,
                                                  conParametros parametros  : Any?                                  ,
                                                  conToken token            : NSString                              ,
                                                  conCompletion completion  : @escaping (_ objRespuesta : WebResponse) -> Void) -> URLSessionDataTask {
        
        let configuracionSesion = URLSessionConfiguration.default
        configuracionSesion.httpAdditionalHeaders = self.crearCabeceraPeticionConToken(token) as? [AnyHashable: Any]
        
        let sesion = URLSession.init(configuration: configuracionSesion)
        
        let urlServicio = URL(string: "\(url)/\(path)")
        let request = NSMutableURLRequest(url: urlServicio!)
        request.addValue("application/json; charset=UTF-8", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        if parametros != nil {
            do {
                request.httpBody = try JSONSerialization.data(withJSONObject: parametros!, options: JSONSerialization.WritingOptions.prettyPrinted)
            } catch {}
        }
        
        request.httpMethod = Constants.Method.httpGet //"GET"
        
        let postDataTask = sesion.dataTask(with: request as URLRequest) { (data, response, error) in
            DispatchQueue.main.async(execute: {
                let objRespuesta = self.obtenerRespuestaServicio(paraData: data, conResponse: response, conError: error as NSError?)
                completion(objRespuesta)
            })
        }
        postDataTask.resume()
        return postDataTask
    }
    
    
    @discardableResult class func doPUTTokenToURL(conURL url                : NSString                              ,
                                                  conPath path              : NSString                              ,
                                                  conParametros parametros  : Any?                                  ,
                                                  conToken token            : NSString                              ,
                                                  conCompletion completion  : @escaping (_ objRespuesta : WebResponse) -> Void) -> URLSessionDataTask {
        
        let configuracionSesion = URLSessionConfiguration.default
        configuracionSesion.httpAdditionalHeaders = self.crearCabeceraPeticionConToken(token) as? [AnyHashable: Any]
        
        let sesion = URLSession.init(configuration: configuracionSesion)
        
        let urlServicio = URL(string: "\(url)/\(path)")
        let request = NSMutableURLRequest(url: urlServicio!)
        request.addValue("application/json; charset=UTF-8", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        if parametros != nil {
            do {
                request.httpBody = try JSONSerialization.data(withJSONObject: parametros!, options: JSONSerialization.WritingOptions.prettyPrinted)
            } catch {}
        }
        
        request.httpMethod = Constants.Method.httpPut //"PUT"
        
        let postDataTask = sesion.dataTask(with: request as URLRequest) { (data, response, error) in
            DispatchQueue.main.async(execute: {
                let objRespuesta = self.obtenerRespuestaServicio(paraData: data, conResponse: response, conError: error as NSError?)
                completion(objRespuesta)
            })
        }
        postDataTask.resume()
        return postDataTask
    }
    
    
    
    
    //MARK: - Consumo de servicios simple
    
    
    
    @discardableResult class func doPOSTToURL(conURL url                : NSString                               ,
                                              conPath path              : NSString                               ,
                                              conParametros parametros  : Any?                                   ,
                                              conCompletion completion  : @escaping (_ objRespuesta : WebResponse) -> Void) -> URLSessionDataTask {
        
        let configuracionSesion = URLSessionConfiguration.default
        configuracionSesion.httpAdditionalHeaders = self.crearCabeceraPeticion() as? [AnyHashable: Any]
        
        let sesion = URLSession.init(configuration: configuracionSesion)
        
        let urlServicio = URL(string: "\(url)/\(path)")
        let request = NSMutableURLRequest(url: urlServicio!)
        request.addValue("application/json; charset=UTF-8", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        if parametros != nil {
            do {
                request.httpBody = try JSONSerialization.data(withJSONObject: parametros!                                   ,
                                                              options       : JSONSerialization.WritingOptions.prettyPrinted)
            } catch {}
        }
        
        request.httpMethod = Constants.Method.httpPost
        
        let postDataTask = sesion.dataTask(with: request as URLRequest) { (data, response, error) in
            DispatchQueue.main.async(execute: {
                let objRespuesta = self.obtenerRespuestaServicio(paraData: data, conResponse: response, conError: error as NSError?)
                completion(objRespuesta)
            })
        }
        postDataTask.resume()
        return postDataTask
    }
    
    
    
    
    
    @discardableResult class func doGETToURL(conURL url                 : NSString                              ,
                                             conPath path               : NSString                              ,
                                             conParametros parametros   : Any?                                  ,
                                             conCompletion completion   : @escaping (_ objRespuesta : WebResponse) -> Void) -> URLSessionDataTask {
        
        let configuracionSesion = URLSessionConfiguration.default
        configuracionSesion.httpAdditionalHeaders = self.crearCabeceraPeticion() as? [AnyHashable: Any]
        
        let sesion = URLSession.init(configuration: configuracionSesion)
        
        let urlServicio = URL(string: "\(url)/\(path)")
        let request = NSMutableURLRequest(url: urlServicio!)
        request.addValue("application/json; charset=UTF-8", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        if parametros != nil {
            do {
                request.httpBody = try JSONSerialization.data(withJSONObject: parametros!, options: JSONSerialization.WritingOptions.prettyPrinted)
            } catch {}
        }
        
        request.httpMethod = Constants.Method.httpGet //"GET"
        
        let postDataTask = sesion.dataTask(with: request as URLRequest) { (data, response, error) in
            DispatchQueue.main.async(execute: {
                let objRespuesta = self.obtenerRespuestaServicio(paraData: data, conResponse: response, conError: error as NSError?)
                completion(objRespuesta)
            })
        }
        postDataTask.resume()
        return postDataTask
    }

    
    
    
    @discardableResult class func doPUTToURL(conURL url                 : NSString                              ,
                                             conPath path               : NSString                              ,
                                             conParametros parametros   : Any?                                  ,
                                             conCompletion completion   : @escaping (_ objRespuesta : WebResponse) -> Void) -> URLSessionDataTask {
        
        let configuracionSesion = URLSessionConfiguration.default
        configuracionSesion.httpAdditionalHeaders = self.crearCabeceraPeticion() as? [AnyHashable: Any]
        
        let sesion = URLSession.init(configuration: configuracionSesion)
        
        let urlServicio = URL(string: "\(url)/\(path)")
        let request = NSMutableURLRequest(url: urlServicio!)
        request.addValue("application/json; charset=UTF-8", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        if parametros != nil {
            do {
                request.httpBody = try JSONSerialization.data(withJSONObject: parametros!, options: JSONSerialization.WritingOptions.prettyPrinted)
            } catch {}
        }
        
        request.httpMethod = Constants.Method.httpPut //"PUT"
        
        let postDataTask = sesion.dataTask(with: request as URLRequest) { (data, response, error) in
            DispatchQueue.main.async(execute: {
                let objRespuesta = self.obtenerRespuestaServicio(paraData: data, conResponse: response, conError: error as NSError?)
                completion(objRespuesta)
            })
        }
        postDataTask.resume()
        return postDataTask
    }
}

