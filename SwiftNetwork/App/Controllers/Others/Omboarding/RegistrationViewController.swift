//
//  RegistrationViewController.swift
//  Blubinn
//
//  Created by Eddy Donald Chinchay Lujan on 31/3/21.
//

import UIKit

protocol SendEmailProtocol: AnyObject {
    func sendEmail(email: String)
}

class RegistrationViewController: UIViewController {
    
    static weak var shared: RegistrationViewController?
    weak var delegateEmail: SendEmailProtocol?
    
    private let nameField = UITextField()
    private let usernameField = UITextField()
    private let emailField = UITextField()
    private let passwordField = UITextField()
    private let registerButton = UIButton()
    
    
    //MARK: viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        configureNameField()
        configureUsernameField()
        configureEmailField()
        configurePasswordField()
        configureRegisterButton()
        delegatesFields()
        
        RegistrationViewController.shared = self
    }
    
    //MARK: viewDidLayoutSubviews
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        nameField.frame = CGRect(
            x       : 20,
            y       : view.safeAreaInsets.top+10,
            width   : view.width - 40,
            height  : 52
        )
        
        usernameField.frame = CGRect(
            x       : 20,
            y       : nameField.bottom+10,
            width   : view.width - 40,
            height  : 52
        )
        
        emailField.frame = CGRect(
            x       : 20,
            y       : usernameField.bottom+10,
            width   : view.width - 40,
            height  : 52
        )
        
        passwordField.frame = CGRect(
            x       : 20,
            y       : emailField.bottom+10,
            width   : view.width - 40,
            height  : 52
        )
        
        registerButton.frame = CGRect(
            x       : 20,
            y       : passwordField.bottom+10,
            width   : view.width - 40,
            height  : 52
        )
    }

    private func setupView() {
        view.backgroundColor = .systemBackground
        view.addSubview(nameField)
        view.addSubview(usernameField)
        view.addSubview(emailField)
        view.addSubview(passwordField)
        view.addSubview(registerButton)
    }
    
    private func configureNameField() {
        nameField.placeholder = "Name"
        nameField.text = "Pepito"
        nameField.returnKeyType = .next
        nameField.leftViewMode = .always
        nameField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 0))
        nameField.autocapitalizationType = .none
        nameField.autocorrectionType = .no
        nameField.layer.masksToBounds = true
        nameField.layer.cornerRadius = Constants.Constants.cornerRadius
        nameField.backgroundColor = .secondarySystemBackground
        nameField.layer.borderWidth = 1.0
        nameField.layer.borderColor = UIColor.secondaryLabel.cgColor
    }
    
    private func configureUsernameField() {
        usernameField.placeholder = "Username"
        usernameField.text = "Pepito"
        usernameField.returnKeyType = .next
        usernameField.leftViewMode = .always
        usernameField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 0))
        usernameField.autocapitalizationType = .none
        usernameField.autocorrectionType = .no
        usernameField.layer.masksToBounds = true
        usernameField.layer.cornerRadius = Constants.Constants.cornerRadius
        usernameField.backgroundColor = .secondarySystemBackground
        usernameField.layer.borderWidth = 1.0
        usernameField.layer.borderColor = UIColor.secondaryLabel.cgColor
    }
    
    private func configureEmailField() {
        emailField.placeholder = "Email"
        emailField.text = "pepito@gmail.com"
        emailField.returnKeyType = .next
        emailField.leftViewMode = .always
        emailField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 0))
        emailField.autocapitalizationType = .none
        emailField.autocorrectionType = .no
        emailField.layer.masksToBounds = true
        emailField.layer.cornerRadius = Constants.Constants.cornerRadius
        emailField.backgroundColor = .secondarySystemBackground
        emailField.layer.borderWidth = 1.0
        emailField.layer.borderColor = UIColor.secondaryLabel.cgColor
    }
    
    private func configurePasswordField() {
        passwordField.isSecureTextEntry = true
        passwordField.placeholder = "Password"
        passwordField.text = "secret"
        passwordField.returnKeyType = .continue
        passwordField.leftViewMode = .always
        passwordField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 0))
        passwordField.autocapitalizationType = .none
        passwordField.autocorrectionType = .no
        passwordField.layer.masksToBounds = true
        passwordField.layer.cornerRadius = Constants.Constants.cornerRadius
        passwordField.backgroundColor = .secondarySystemBackground
        passwordField.layer.borderWidth = 1.0
        passwordField.layer.borderColor = UIColor.secondaryLabel.cgColor
        
    }
    
    private func configureRegisterButton() {
        registerButton.setTitle("Sign In", for: .normal)
        registerButton.layer.masksToBounds = true
        registerButton.layer.cornerRadius = Constants.Constants.cornerRadius
        registerButton.backgroundColor = .systemGreen
        registerButton.setTitleColor(.white, for: .normal)
        registerButton.addTarget(self, action: #selector(didTapRegisterButton), for: .touchUpInside)
    }
    
    private func delegatesFields() {
        nameField.delegate = self
        usernameField.delegate = self
        emailField.delegate = self
        passwordField.delegate = self
    }
    
    
    @objc private func didTapRegisterButton() {
        nameField.becomeFirstResponder()
        usernameField.becomeFirstResponder()
        emailField.becomeFirstResponder()
        passwordField.becomeFirstResponder()
    
        let objUser = UserBE()
        objUser.name = nameField.text!
        objUser.username = usernameField.text!
        objUser.email = emailField.text!
        objUser.password = passwordField.text!
        
        var _email: String?
        _email =  objUser.email
        
        UserLoginBC.signIn(objUser, conCompletionCorrecto: { (objUsuario) in
            let actionSheet = UIAlertController(
                title           : Constants.SignUp.titleAlert    ,
                message         : Constants.SignUp.subTitleAlert ,
                preferredStyle  : .alert
            )
            actionSheet.addAction(UIAlertAction(title: "Ok",
                                                style: .default,
                                                handler: { _ in
                self.delegateEmail?.sendEmail(email: _email!)
                self.dismiss(animated: true, completion: nil)
            }))
            self.present(actionSheet, animated: true)
            
        }, conCompletionIncorrecto: {(mensajeError) in
            Alerts.showAlertErrorWhitTitle(
                titulo: Constants.LogInError.titleAlertVerificationFailed,
                conMensaje: mensajeError,
                conNombreDeBotonCancelar: "Aceptar",
                enControlador: self,
                conCompletion: nil
            )
        })
    }
}

extension RegistrationViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == nameField {
            usernameField.becomeFirstResponder()
        } else if textField == usernameField {
            emailField.becomeFirstResponder()
        } else {
            didTapRegisterButton()
        }
        return true
    }
    
}
