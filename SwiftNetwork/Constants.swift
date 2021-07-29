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
    
    struct ProfileTabsCollectionReusableViewColor {
        static let padding: CGFloat = 8
    }
    
    struct Color {
        static let blue = UIColor(red: 0, green: 0.4824, blue: 1, alpha: 1.0) /* #007bff */
        static let blueLight = UIColor(red: 234/255, green: 244/255, blue: 255/255, alpha: 1.0) /* #eaf4ff */
        static let green = UIColor(red: 40/255, green: 167/255, blue: 69/255, alpha: 1.0) /* #28a745 */
        static let light = UIColor(red: 247/255, green: 249/255, blue: 250/255, alpha: 1.0) /* #f7f9fa */
        static let lightDark = UIColor(red: 91/255, green: 112/255, blue: 131/255, alpha: 1.0) /* #5b7083 */
        static let black = UIColor(red: 29/255, green: 29/255, blue: 31/255, alpha: 1.0) /* #1d1d1f */
            //UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 1.0) /* #000 */
        static let red = UIColor(red: 255/255, green: 30/255, blue: 86/255, alpha: 1.0) /* #ff1e56 */
        static let grayDark = UIColor(red: 50/255, green: 50/255, blue: 50/255, alpha: 1.0) /* #323232 */
        static let purple = UIColor(red: 0/255, green: 113/255, blue: 227/255, alpha: 1.0) /* #0071e3 */
            //UIColor(red: 0/255, green: 114/255, blue: 255/255, alpha: 1.0) /* #0072ff */
            //UIColor(red: 120/255, green: 104/255, blue: 230/255, alpha: 1.0) /* #7868e6 */
            //UIColor(red: 105/255, green: 48/255, blue: 195/255, alpha: 1.0) /* #6930c3 */
        static let dark = UIColor(red: 91/255, green: 112/255, blue: 131/255, alpha: 1.0) /* #5b7083 */
        static let darkLigth = UIColor(red: 235/255, green: 237/255, blue: 240/255, alpha: 1.0) /* #ebedf0 */
            //UIColor(red: 247/255, green: 249/255, blue: 250/255, alpha: 1.0) /* #f7f9fa */
            //UIColor(red: 250/255, green: 250/255, blue: 250/255, alpha: 1.0) /* #fafafa */
            
            //UIColor(red: 235/255, green: 238/255, blue: 240/255, alpha: 1.0) /* #ebeef0 */
        static let whiteLight =  UIColor(red: 232/255, green: 232/255, blue: 232/255, alpha: 1.0) /* #e8e8e8 */

    }
    
    struct Icon {
        static let photo = "photo"
        static let more = "ellipsis"
        static let filter = "line.horizontal.3.decrease"
    }
    
    struct fontSize {
        static let regular = UIFont.systemFont(ofSize: 14, weight: .regular)
        static let semibold = UIFont.systemFont(ofSize: 14, weight: .semibold)
    }
    
    struct storyCollections {
        static let createStory = "createStory"
        static let collections = "collections"
    }
}
