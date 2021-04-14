//
//  Alerts.swift
//  SwiftNetwork
//
//  Created by Eddy Donald Chinchay Lujan on 13/4/21.
//



import UIKit

class Alerts: NSObject {

    
    typealias acctionSheetCancelar = (()->Void)?
    
    
    class func mostrarAlertaConTitulo(titulo : String, conMensaje mensaje : String?, conNombreDeBotonCancelar cancelar : String, enControlador controller : UIViewController?, conCompletion completion : (() -> Void)?){
        
        let alertaController = UIAlertController(title: titulo, message: mensaje, preferredStyle: UIAlertController.Style.alert)
        
        let accionCancelar = UIAlertAction(title: cancelar, style: UIAlertAction.Style.cancel) { (action : UIAlertAction) in
            
            completion?()
        }
        
        alertaController.addAction(accionCancelar)
        
        if controller == nil {
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            appDelegate.window?.rootViewController?.present(alertaController, animated: true, completion: nil)
        }else{
            controller!.present(alertaController, animated: true, completion: nil)
        }
    }
    
}

