//
//  Constants.swift
//  Blubinn
//
//  Created by Eddy Donald Chinchay Lujan on 11/11/2020.
//

import  UIKit
struct Constants {
    
    struct SignUpAlertMessage {
        static let title = "Mensaje"
        static let mensaje = "Se ha detectado que algunos de los campos están vacío. Rellenadlos por favor."
    }
    
    struct BirthdayAlertMessage {
        static let title = "Mensaje"
        static let mensaje = "Se ha detectado que el campo fecha está vacío. Rellenad el campo con tu fecha de nacimiento, por favor."
    }
    
    struct Error {
        static let unauthorized = "Unauthorized"
    }
    
    struct LogInError {
        static let logInInvalidte = "Login Invalido"
        static let titleAlertVerificationFailed = "Verification Failed"
        static let mensajeError = "The email or password you entered is incorrect."
    }
    
    struct SignUp {
        static let titleAlert = "Sign Up"
        static let subTitleAlert = "User successfully registered"
        static let buttonOkAlert = "User successfully registered"
    }
    
    struct  ApiRoutes {
        static let login = "http://127.0.0.1:8000"
    }
    
    struct Method {
        static let httpPost = "POST"
        static let httpGet = "GET"
        static let httpPut = "PUT"
    }
    
    struct Constants {
        static let cornerRadius: CGFloat = 9
    }
    
    struct ProfileInfoHeaderCollectionReusableViewColor {
        static let colorPink = UIColor(red: 244/255, green: 41/255, blue: 108/255, alpha: 1.0) /* #f4296c */
    }
    
    struct ProfileTabsCollectionReusableViewColor {
        static let padding: CGFloat = 8
        static let colorPink = UIColor(red: 244/255, green: 41/255, blue: 108/255, alpha: 1.0) /* #f4296c */
    }
    
    struct ColorText {
        static let shifter = UIColor(red: 244/255, green: 41/255, blue: 108/255, alpha: 1.0) /* #f4296c */
    }
    
    struct ColorButton {
        static let shifter = UIColor(red: 244/255, green: 41/255, blue: 108/255, alpha: 1.0) /* #f4296c */
    }
}
