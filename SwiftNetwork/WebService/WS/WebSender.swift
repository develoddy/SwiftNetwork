//
//  WebSender.swift
//  Blubinn
//
//  Created by Eddy Donald Chinchay Lujan on 6/4/21.
//



import UIKit

class WebSender: NSObject {
    
    //MARK:  Consumption of services with cookie
    
    ///Post
    @discardableResult class func doPOSTCookieToURL(conURL url                  : NSString                              ,
                                                    conPath path                : NSString                              ,
                                                    conParametros parametros    : Any?                                  ,
                                                    conCookie cookie            : NSString                              ,
                                                    conCompletion completion    : @escaping (_ objRespuesta : WebResponse) -> Void) -> URLSessionDataTask {
        let configuracionSesion = URLSessionConfiguration.default
        configuracionSesion.httpAdditionalHeaders = self.createHeaderRequestWithCookie(cookie) as? [AnyHashable: Any]
        
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
        
        request.httpMethod = Constants.Method.httpPost
        let postDataTask = sesion.dataTask(with: request as URLRequest) { (data, response, error) in
            DispatchQueue.main.async(execute: {
                let objRespuesta = self.getServiceResponse(paraData: data, conResponse: response, conError: error as NSError?)
                completion(objRespuesta)
            })
        }
        postDataTask.resume()
        return postDataTask
    }
    
    ///Get
    @discardableResult class func doGETCookieToURL(conURL url               : NSString                              ,
                                                   conPath path             : NSString                              ,
                                                   conParametros parametros : Any?                                  ,
                                                   conCookie cookie         : NSString                              ,
                                                   conCompletion completion : @escaping (_ objRespuesta : WebResponse) -> Void) -> URLSessionDataTask {
        let configuracionSesion = URLSessionConfiguration.default
        configuracionSesion.httpAdditionalHeaders = self.createHeaderRequestWithCookie(cookie) as? [AnyHashable: Any]
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
        
        request.httpMethod = Constants.Method.httpGet
        let postDataTask = sesion.dataTask(with: request as URLRequest) { (data, response, error) in
            DispatchQueue.main.async(execute: {
                let objRespuesta = self.getServiceResponse(paraData: data, conResponse: response, conError: error as NSError?)
                completion(objRespuesta)
            })
        }
        postDataTask.resume()
        return postDataTask
    }
    
    ///Put
    @discardableResult class func doPUTCookieToURL(conURL url               : NSString                          ,
                                                   conPath path             : NSString                          ,
                                                   conParametros parametros : Any?                              ,
                                                   conCookie cookie         : NSString                          ,
                                                   conCompletion completion : @escaping (_ objRespuesta : WebResponse) -> Void) -> URLSessionDataTask {
        let configuracionSesion = URLSessionConfiguration.default
        configuracionSesion.httpAdditionalHeaders = self.createHeaderRequestWithCookie(cookie) as? [AnyHashable: Any]
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
        
        request.httpMethod = Constants.Method.httpPut
        let postDataTask = sesion.dataTask(with: request as URLRequest) { (data, response, error) in
            DispatchQueue.main.async(execute: {
                let objRespuesta = self.getServiceResponse(paraData: data, conResponse: response, conError: error as NSError?)
                completion(objRespuesta)
            })
        }
        postDataTask.resume()
        return postDataTask
    }
    
    
    
    
    //MARK: - Consumption of services with token
    
    ///Post
    @discardableResult class func doPOSTTokenToURL(conURL url: NSString,
                                                   conPath path: NSString,
                                                   conParametros parametros: Any?,
                                                   conToken token: NSString,
                                                   conCompletion completion: @escaping (_ objRespuesta: WebResponse) -> Void) -> URLSessionDataTask {
        let configuracionSesion = URLSessionConfiguration.default
        configuracionSesion.httpAdditionalHeaders = self.createHeaderRequestWithToken(token) as? [AnyHashable: Any]
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
        
        request.httpMethod = Constants.Method.httpPost
        let postDataTask = sesion.dataTask(with: request as URLRequest) { (data, response, error) in
            DispatchQueue.main.async(execute: {
                let objRespuesta = self.getServiceResponse(paraData: data, conResponse: response, conError: error as NSError?)
                completion(objRespuesta)
            })
        }
        postDataTask.resume()
        return postDataTask
    }
    
    
    ///Get
    @discardableResult class
    func doGETTokenToURL(conURL url                : NSString                              ,
                         conPath path              : NSString                              ,
                         conParametros parametros  : Any?                                  ,
                         conToken token            : NSString                              ,
                         conCompletion completion  : @escaping (_ objRespuesta : WebResponse) -> Void) -> URLSessionDataTask {
        
        let configuracionSesion = URLSessionConfiguration.default
        configuracionSesion.httpAdditionalHeaders = self.createHeaderRequestWithToken(token) as? [AnyHashable: Any]
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
        
        request.httpMethod = Constants.Method.httpGet
        let postDataTask = sesion.dataTask(with: request as URLRequest) { (data, response, error) in
            DispatchQueue.main.async(execute: {
                let objRespuesta = self.getServiceResponse(paraData: data, conResponse: response, conError: error as NSError?)
                completion(objRespuesta)
            })
        }
        postDataTask.resume()
        return postDataTask
    }
    
    ///Put
    @discardableResult class func doPUTTokenToURL(conURL url                : NSString                              ,
                                                  conPath path              : NSString                              ,
                                                  conParametros parametros  : Any?                                  ,
                                                  conToken token            : NSString                              ,
                                                  conCompletion completion  : @escaping (_ objRespuesta : WebResponse) -> Void) -> URLSessionDataTask {
        let configuracionSesion = URLSessionConfiguration.default
        configuracionSesion.httpAdditionalHeaders = self.createHeaderRequestWithToken(token) as? [AnyHashable: Any]
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
        
        request.httpMethod = Constants.Method.httpPut
        let postDataTask = sesion.dataTask(with: request as URLRequest) { (data, response, error) in
            DispatchQueue.main.async(execute: {
                let objRespuesta = self.getServiceResponse(paraData: data, conResponse: response, conError: error as NSError?)
                completion(objRespuesta)
            })
        }
        postDataTask.resume()
        return postDataTask
    }
    
    
    
    
    //MARK: - Consumption Simple service

    ///Post
    @discardableResult class func doPOSTToURL(conURL url                : NSString                               ,
                                              conPath path              : NSString                               ,
                                              conParametros parametros  : Any?                                   ,
                                              conCompletion completion  : @escaping (_ objRespuesta : WebResponse) -> Void) -> URLSessionDataTask {
        let configuracionSesion = URLSessionConfiguration.default
        configuracionSesion.httpAdditionalHeaders = self.createHeaderRequest() as? [AnyHashable: Any]
        let sesion = URLSession.init(configuration: configuracionSesion)
        let urlServicio = URL(string: "\(url)/\(path)")
        let request = NSMutableURLRequest(url: urlServicio!)
        request.addValue("application/json; charset=UTF-8", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        if parametros != nil {
            do {
                request.httpBody = try JSONSerialization.data(withJSONObject: parametros! ,options: JSONSerialization.WritingOptions.prettyPrinted)
            } catch {}
        }
        
        request.httpMethod = Constants.Method.httpPost
        let postDataTask = sesion.dataTask(with: request as URLRequest) { (data, response, error) in
            DispatchQueue.main.async(execute: {
                let objRespuesta = self.getServiceResponse(paraData: data, conResponse: response, conError: error as NSError?)
                completion(objRespuesta)
            })
        }
        postDataTask.resume()
        return postDataTask
    }
    
    
    @discardableResult class func doPOSTTLogOutURL(conURL url           : NSString                               ,
                                              conPath path              : NSString                               ,
                                              conParametros token       : String?                                ,
                                              conCompletion completion  : @escaping (_ objRespuesta : WebResponse) -> Void) -> URLSessionDataTask {
        let configuracionSesion = URLSessionConfiguration.default
        configuracionSesion.httpAdditionalHeaders = self.createHeaderRequest() as? [AnyHashable: Any]
        let sesion = URLSession.init(configuration: configuracionSesion)
        let urlServicio = URL(string: "\(url)/\(path)")
        let request = NSMutableURLRequest(url: urlServicio!)
        request.addValue("application/json; charset=UTF-8", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.addValue("bearer" + token!, forHTTPHeaderField: "Authorization")
        
        request.httpMethod = Constants.Method.httpPost
        let postDataTask = sesion.dataTask(with: request as URLRequest) { (data, response, error) in
            DispatchQueue.main.async(execute: {
                let objRespuesta = self.getServiceResponse(paraData: data, conResponse: response, conError: error as NSError?)
                completion(objRespuesta)
            })
        }
        postDataTask.resume()
        return postDataTask
    }
    
    ///Get
    @discardableResult class func doGETToURL(conURL url                 : NSString                              ,
                                             conPath path               : NSString                              ,
                                             conParametros parametros   : Any?                                  ,
                                             conCompletion completion   : @escaping (_ objRespuesta : WebResponse) -> Void) -> URLSessionDataTask {
        let configuracionSesion = URLSessionConfiguration.default
        configuracionSesion.httpAdditionalHeaders = self.createHeaderRequest() as? [AnyHashable: Any]
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
        
        request.httpMethod = Constants.Method.httpGet
        let postDataTask = sesion.dataTask(with: request as URLRequest) { (data, response, error) in
            DispatchQueue.main.async(execute: {
                let objRespuesta = self.getServiceResponse(paraData: data, conResponse: response, conError: error as NSError?)
                completion(objRespuesta)
            })
        }
        postDataTask.resume()
        return postDataTask
    }
    
    ///Putt
    @discardableResult class func doPUTToURL(conURL url                 : NSString                              ,
                                             conPath path               : NSString                              ,
                                             conParametros parametros   : Any?                                  ,
                                             conCompletion completion   : @escaping (_ objRespuesta : WebResponse) -> Void) -> URLSessionDataTask {
        let configuracionSesion = URLSessionConfiguration.default
        configuracionSesion.httpAdditionalHeaders = self.createHeaderRequest() as? [AnyHashable: Any]
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
        
        request.httpMethod = Constants.Method.httpPut
        let postDataTask = sesion.dataTask(with: request as URLRequest) { (data, response, error) in
            DispatchQueue.main.async(execute: {
                let objRespuesta = self.getServiceResponse(paraData: data, conResponse: response, conError: error as NSError?)
                completion(objRespuesta)
            })
        }
        postDataTask.resume()
        return postDataTask
    }
    
    
    //MARK:- Configurations headers
    
    class func createHeaderRequest() -> NSDictionary {
        let diccionarioHeader = NSMutableDictionary()
        diccionarioHeader.setObject("application/json", forKey: "Content-Type" as NSCopying)
        diccionarioHeader.setObject("application/json; charset=UTF-8", forKey: "Content-Type" as NSCopying)
        diccionarioHeader.setObject("application/json", forKey: "Accept" as NSCopying)
        return diccionarioHeader
    }

    class func createHeaderRequestWithToken(_ aToken : NSString) -> NSDictionary {
        let diccionarioHeader = NSMutableDictionary()
        diccionarioHeader.setObject("application/json", forKey: "Content-Type" as NSCopying)
        diccionarioHeader.setObject("application/json; charset=UTF-8", forKey: "Content-Type" as NSCopying)
        diccionarioHeader.setObject("application/json", forKey: "Accept" as NSCopying)
        diccionarioHeader.setObject("Bearer \(aToken)", forKey: "Authorization" as NSCopying)
        return diccionarioHeader
    }
    
    class func createHeaderRequestWithCookie(_ aCookie : NSString) -> NSDictionary {
        let diccionarioHeader = NSMutableDictionary()
        diccionarioHeader.setObject("application/json; charset=UTF-8", forKey: "Content-Type" as NSCopying)
        diccionarioHeader.setObject("application/json", forKey: "Accept" as NSCopying)
        diccionarioHeader.setObject("Bearer \(aCookie)", forKey: "Cookie" as NSCopying)
        return diccionarioHeader
    }
    
    
    //MARK: - Tratado de respuesta
    
    class func detResponseInJSONWithData(_ data : Data) -> Any? {
        do {
            return try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.allowFragments) as Any
        } catch {
            return nil
        }
    }
    
    class func getServiceResponse(paraData data           : Data?         ,
                                  conResponse response    : URLResponse?  ,
                                  conError error          : NSError?      )  -> WebResponse {
        var respuesta : Any? = nil
        if error == nil && data != nil {
            respuesta = self.detResponseInJSONWithData(data!)
        }
        
        ///print("respuesta \(respuesta)")
        let urlResponse = response as? HTTPURLResponse
        let headerFields : NSDictionary? = urlResponse?.allHeaderFields as NSDictionary?
        let objResponse = WebResponse()
        
        objResponse.respuestaJSON      = respuesta
        objResponse.statusCode         = urlResponse?.statusCode
        objResponse.respuestaNSData    = data
        objResponse.error              = error
        objResponse.datosCabecera      = headerFields
        objResponse.token              = headerFields?["_token"] as? NSString
        objResponse.cookie             = headerFields?["_token"] as? NSString
        return objResponse
    }
}
