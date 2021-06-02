//
//  LoginViewController.swift
//  Blubinn
//
//  Created by Eddy Donald Chinchay Lujan on 31/3/21.
//

import UIKit
import SafariServices

extension LoginViewController: SendEmailProtocol {
    func sendEmail(email: String) {
        usernameEmailField.text = email
        passwordField.text = ""
    }
}

class LoginViewController: UIViewController {
    
    private let titleLabel = UILabel()
    private let headerView = UIView()
    private let usernameEmailField = UITextField()
    private let passwordField = UITextField()
    private let loginButton = UIButton()
    private let termsButton = UIButton()
    private let privacyButton = UIButton()
    private let createAccountButton = UIButton()
    
    let gradient = CAGradientLayer()
    
    //MARK: viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        configureTitleLabel()
        configureHeaderView()
        configureUsernameEmailField()
        configurePasswordField()
        configureLoginButton()
        configureTermsButton()
        configurePrivacyButton()
        configureCreateAccountButton()
        delegatesFields()
        ///Es para entrar directamente al perfil, lueglo se tiene que quitar esta funcion del viewLoad
        didTapLoginButton()
    }
    
    //MARK: viewDidLayoutSubviews
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        gradient.frame = view.bounds
        
        headerView.frame = CGRect(
            x: 0,
            y: 0.0,
            width: view.width,
            height: view.height/3.0
        )
        
        usernameEmailField.frame = CGRect(
            x: 25,
            y: headerView.bottom + 20,
            width: view.width - 50,
            height: 52.0
        )
        
        passwordField.frame = CGRect(
            x: 25,
            y: usernameEmailField.bottom + 10,
            width: view.width - 50,
            height: 52.0
        )
        
        loginButton.frame = CGRect(
            x: 25,
            y: passwordField.bottom + 10,
            width: view.width - 50,
            height: 52.0
        )
        
        createAccountButton.frame = CGRect(
            x: 25,
            y: loginButton.bottom + 10,
            width: view.width - 50,
            height: 52.0
        )
        
        termsButton.frame = CGRect(
            x: 10,
            y: view.height-view.safeAreaInsets.bottom-100,
            width: view.width - 20,
            height: 50
        )
        
        privacyButton.frame = CGRect(
            x: 10,
            y: view.height-view.safeAreaInsets.bottom-50,
            width: view.width - 20,
            height: 50
        )
    }
    
    func setupView() {
        view.backgroundColor = .systemBackground
        view.addSubview(headerView)
        view.addSubview(usernameEmailField)
        view.addSubview(passwordField)
        view.addSubview(loginButton)
        view.addSubview(termsButton)
        view.addSubview(privacyButton)
        view.addSubview(createAccountButton)
    }
    
    func configureTitleLabel() {
        titleLabel.text = "Logotipo"
        titleLabel.textColor = .white
        titleLabel.textAlignment = .center
        titleLabel.font = UIFont.boldSystemFont(ofSize: 34.0)
        titleLabel.frame = CGRect(
            x: 20,
            y: view.width/3,
            width: view.width - 40,
            height: 50
        )
    }
    
    func configureHeaderView() {
        headerView.clipsToBounds = true
        gradient.colors = [UIColor(red: 51/255, green: 51/255, blue: 153/255, alpha: 1.0).cgColor, UIColor(red: 255/255, green: 0/255, blue: 204/255, alpha: 1.0).cgColor]
        gradient.locations = [0.0, 0.6, 0.8]
        gradient.frame = view.bounds
        headerView.layer.insertSublayer(gradient, at: 0)
        headerView.addSubview(titleLabel)
    }
    
    func configureUsernameEmailField() {
        usernameEmailField.placeholder = "Username or Email"
        usernameEmailField.text = "eddylujann@gmail.com"
        usernameEmailField.returnKeyType = .next
        usernameEmailField.leftViewMode = .always
        usernameEmailField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 0))
        usernameEmailField.autocapitalizationType = .none
        usernameEmailField.autocorrectionType = .no
        usernameEmailField.layer.masksToBounds = true
        usernameEmailField.layer.cornerRadius = Constants.Constants.cornerRadius
        usernameEmailField.backgroundColor = .secondarySystemBackground
        usernameEmailField.layer.borderWidth = 1.0
        usernameEmailField.layer.borderColor = UIColor.secondaryLabel.cgColor
    }
    
    func configurePasswordField() {
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
    
    func configureLoginButton() {
        loginButton.setTitle("Log In", for: .normal)
        loginButton.layer.masksToBounds = true
        loginButton.layer.cornerRadius = Constants.Constants.cornerRadius
        loginButton.backgroundColor = .black
        loginButton.setTitleColor(.white, for: .normal)
        loginButton.addTarget(self, action: #selector(didTapLoginButton), for: .touchUpInside)
    }
    
    func configureTermsButton() {
        termsButton.setTitle("Terms of Serviced", for: .normal)
        termsButton.setTitleColor(.secondaryLabel, for: .normal)
        termsButton.addTarget(self, action: #selector(didTapTermsButton), for: .touchUpInside)
    }
    
    func configurePrivacyButton() {
        privacyButton.setTitle("Privacy Polocy", for: .normal)
        privacyButton.setTitleColor(.secondaryLabel, for: .normal)
        privacyButton.addTarget(self, action: #selector(didTapPrivacyButton), for: .touchUpInside)
    }
    
    func configureCreateAccountButton() {
        createAccountButton.setTitleColor(.label, for: .normal)
        createAccountButton.setTitle("New User? Create an Account", for: .normal)
        createAccountButton.addTarget(self, action: #selector(didTapCreateAccountButton), for: .touchUpInside)
    }
    
    private func delegatesFields() {
        usernameEmailField.delegate = self
        passwordField.delegate = self
    }
    
    @objc private func didTapLoginButton() {
        passwordField.resignFirstResponder()
        usernameEmailField.resignFirstResponder()
        
        /**
        let objUser = UserBE()
        objUser.email = usernameEmailField.text!
        objUser.password = passwordField.text!
        
        UserLoginBC.logIn(objUser, conCompletionCorrecto: { (objUsuario) in
            let vc = TabBarController()
            vc.modalPresentationStyle = .fullScreen
            self.present(vc, animated: true)
        }, conCompletionIncorrecto: {(mensajeError) in
            
            Alerts.showAlertErrorWhitTitle(
                titulo: Constants.LogInError.titleAlertVerificationFailed,
                conMensaje: mensajeError,
                conNombreDeBotonCancelar: "Aceptar",
                enControlador: self,
                conCompletion: nil
            )
        })
         **/
        
        guard let usernameEmail = usernameEmailField.text, let password = passwordField.text else {
            return
        }
        
        AuthManager.shared.login(email: usernameEmail, password: password) { success in
            DispatchQueue.main.async {
                if success {
                    /// User logged in
                    let vc = TabBarController()
                    vc.modalPresentationStyle = .fullScreen
                    self.present(vc, animated: true)
                } else {
                    ///Error ocurred
                    Alerts.showAlertErrorWhitTitle(
                        titulo: Constants.LogInError.titleAlertVerificationFailed,
                        conMensaje: "¡Email or password is incorrrect!",
                        conNombreDeBotonCancelar: "Aceptar",
                        enControlador: self,
                        conCompletion: nil)
                }
            }
        }
        
        
    }
    @objc private func didTapTermsButton() {}
    @objc private func didTapPrivacyButton() {}
    @objc private func didTapCreateAccountButton() {
        let vc = RegistrationViewController()
        vc.delegateEmail = self
        vc.title = "Create Account"
        present(UINavigationController(rootViewController: vc), animated: true)
    }
    
}


extension LoginViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == usernameEmailField {
            passwordField.becomeFirstResponder()
        } else if textField == passwordField {
            didTapLoginButton()
        }
        return true
    }
    
}
