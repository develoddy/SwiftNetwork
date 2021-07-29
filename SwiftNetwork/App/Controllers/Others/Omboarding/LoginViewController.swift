//
//  LoginViewController.swift
//  Blubinn
//
//  Created by Eddy Donald Chinchay Lujan on 31/3/21.
//

import UIKit
import SafariServices
import TransitionButton

extension LoginViewController: SendEmailProtocol {
    func sendEmail(email: String) {
        usernameEmailField.text = email
        passwordField.text = ""
    }
}

class LoginViewController: UIViewController {

    var spinner = UIActivityIndicatorView()
    private let logoImageView = UIImageView()
    private let titleLabel = UILabel()
    private let headerView = UIView()
    private let usernameEmailField = UITextField()
    private let passwordField = UITextField()
    private let button =  TransitionButton(frame: CGRect(x: 0, y: 0, width: 250, height: 50)) ///Spinner
    private let loginButton = TransitionButton(frame: CGRect(x: 0, y: 0, width: 250, height: 50)) ///Spinner //UIButton()
    private let termsButton = UIButton()
    private let privacyButton = UIButton()
    private let createAccountButton = UIButton()
    ///New Interface
    private let titleLoginlabel = UILabel()
    private var emailLabel = UILabel()
    private let emailText = TextFieldWithPadding()
    private var passwordLabel = UILabel()
    private let passwordText = TextFieldWithPadding()
    
    let gradient = CAGradientLayer()
    
    //MARK: viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        
        configureHeaderView()
        configureTitleLabel()
        configureLogoImageView()
        ///Spinner
        configureLoginButton()
        configureTermsButton()
        configurePrivacyButton()
        configureCreateAccountButton()
        delegatesFields()
        ///Es para entrar directamente al perfil, lueglo se tiene que quitar esta funcion del viewLoad
        ///didTapLoginButton()
        
        configureEmailLabel()
        configureEmailText()
        
        configurePasswordLabel()
        configurePasswordText()
       
    }
    

    //MARK: viewDidLayoutSubviews
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        gradient.frame = view.bounds
        
        ///HeaderView
        headerView.frame = CGRect(
            x: 0,
            y: 0.0,
            width: view.width,
            height: view.height/3.0
        )
        
        let size = headerView.height/3
        ///LogoImageView
        logoImageView.frame = CGRect(
            x: (view.width-size)/2,
            y: (headerView.height-size)/2.5,
            width: size,
            height: size)
        logoImageView.layer.cornerRadius = logoImageView.height/2
        
        ///Title
        let titleLabelSize = titleLabel.sizeThatFits(view.frame.size)
        titleLabel.frame = CGRect(
            x: 20,
            y: logoImageView.bottom+35,
            width: view.width - 40,
            height: titleLabelSize.height).integral
        
        ///emailLabel
        let emailLabellSize = emailLabel.sizeThatFits(view.frame.size)
        emailLabel.frame = CGRect(
            x: 25,
            y: headerView.bottom + 20,
            width: view.width - 50,
            height: emailLabellSize.height).integral
        
        ///emailText
        let emailTextlSize = emailText.sizeThatFits(view.frame.size)
        emailText.frame = CGRect(
            x: 25,
            y: emailLabel.bottom+5,
            width: view.width - 50,
            height: emailTextlSize.height).integral
        
        ///PasswordLabel
        let passwordLabelize = passwordLabel.sizeThatFits(view.frame.size)
        passwordLabel.frame = CGRect(
            x: 25,
            y: emailText.bottom+20,
            width: view.width - 50,
            height: passwordLabelize.height).integral
        
        ///PassworsText
        let passwordTextlSize = passwordText.sizeThatFits(view.frame.size)
        passwordText.frame = CGRect(
            x: 25,
            y: passwordLabel.bottom+5,
            width: view.width - 50,
            height: passwordTextlSize.height).integral
        
        ///Button Login
        loginButton.layer.masksToBounds = true
        loginButton.frame = CGRect(
            x: 25,
            y: passwordText.bottom + 20,
            width: view.width - 50,
            height: 52.0)
        loginButton.layer.cornerRadius = loginButton.height/2
        
        ///CreateAccount
        createAccountButton.frame = CGRect(
            x: 25,
            y: loginButton.bottom + 10,
            width: view.width - 50,
            height: 52.0)
        
        ///TermsButton
        termsButton.frame = CGRect(
            x: 10,
            y: view.height-view.safeAreaInsets.bottom-100,
            width: view.width - 20,
            height: 50)
        
        ///PrivacyButton
        privacyButton.frame = CGRect(
            x: 10,
            y: view.height-view.safeAreaInsets.bottom-50,
            width: view.width - 20,
            height: 50)
    }
    
    func setupView() {
        view.backgroundColor = .systemBackground
        view.addSubview(headerView)
        view.addSubview(logoImageView)
        ///TextFields
        view.addSubview(emailLabel)
        view.addSubview(emailText)
        view.addSubview(passwordLabel)
        view.addSubview(passwordText)
        ///UIbuttons
        view.addSubview(loginButton)
        view.addSubview(termsButton)
        view.addSubview(privacyButton)
        view.addSubview(createAccountButton)
    }
    
    func configureHeaderView() {
        headerView.clipsToBounds = true
        //gradient.colors = [UIColor(red: 51/255, green: 51/255, blue: 153/255, alpha: 1.0).cgColor, UIColor(red: 255/255, green: 0/255, blue: 204/255, alpha: 1.0).cgColor]
        gradient.colors = [UIColor.systemBackground.cgColor,
                           UIColor.systemBackground.cgColor]
        gradient.locations = [0.0, 0.6, 0.8]
        gradient.frame = view.bounds
        headerView.layer.insertSublayer(gradient, at: 0)
        
        headerView.addSubview(logoImageView)
        headerView.addSubview(titleLabel)
    }
    
    func configureLogoImageView() {
        logoImageView.backgroundColor = Constants.Color.purple
        logoImageView.layer.masksToBounds = true
    }
    
    func configureTitleLabel() {
        titleLabel.text = "Log in to Noori"
        titleLabel.textColor = Constants.Color.black
        titleLabel.textAlignment = .center
        titleLabel.font = .systemFont(ofSize: 36, weight: .bold)
    }
    
    private func configureEmailLabel() {
        emailLabel.text      = "EMAIL"
        emailLabel.font      = UIFont.systemFont(ofSize: 12, weight: UIFont.Weight.regular)
        emailLabel.textColor = Constants.Color.purple
    }
    
    private func configureEmailText() {
        emailText.placeholder = "Username or Email"
        emailText.text = "eddylujann@gmail.com"
        emailText.returnKeyType = .next
        emailText.leftViewMode = .always
        emailText.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 0))
        emailText.autocapitalizationType = .none
        emailText.autocorrectionType = .no
        emailText.layer.masksToBounds = true
        emailText.backgroundColor = Constants.Color.darkLigth
    }
    
    private func configurePasswordLabel() {
        passwordLabel.text      = "PASSWORD"
        passwordLabel.font      = UIFont.systemFont(ofSize: 12, weight: UIFont.Weight.regular)
        passwordLabel.textColor = Constants.Color.purple
    }
    
    private func configurePasswordText() {
        passwordText.isSecureTextEntry = true
        passwordText.placeholder = "Password"
        passwordText.text = "secret"
        passwordText.returnKeyType = .continue
        passwordText.leftViewMode = .always
        passwordText.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 0))
        passwordText.autocapitalizationType = .none
        passwordText.autocorrectionType = .no
        passwordText.layer.masksToBounds = true
        passwordText.backgroundColor = Constants.Color.darkLigth
    }
    
    ///Spinner
    func configureSpinnerButton() {
        button.center = view.center
        button.backgroundColor = .systemPink
        button.setTitle("Continue", for: .normal)
        button.layer.cornerRadius = 12
        button.addTarget(self, action: #selector(runSpinnerValidationLogin), for: .touchUpInside)
        button.spinnerColor = .white
        view.addSubview(button)
    }
    
    ///LogIn
    func configureLoginButton() {
         ///Spinner //UIButton()
        loginButton.center = view.center
        loginButton.backgroundColor = Constants.Color.purple
        loginButton.setTitle("Log In", for: .normal)
        loginButton.layer.masksToBounds = true
        loginButton.layer.cornerRadius = Constants.Constants.cornerRadius
        loginButton.addTarget(self, action: #selector(didTapLoginButton), for: .touchUpInside)
        loginButton.spinnerColor = .white
    }
    
    func configureTermsButton() {
        termsButton.setTitle("Terms of Serviced", for: .normal)
        termsButton.setTitleColor(Constants.Color.dark, for: .normal)
        termsButton.addTarget(self, action: #selector(didTapTermsButton), for: .touchUpInside)
    }
    
    func configurePrivacyButton() {
        privacyButton.setTitle("Privacy Polocy", for: .normal)
        privacyButton.setTitleColor(Constants.Color.dark, for: .normal)
        privacyButton.addTarget(self, action: #selector(didTapPrivacyButton), for: .touchUpInside)
    }
    
    func configureCreateAccountButton() {
        createAccountButton.setTitleColor(.label, for: .normal)
        createAccountButton.setTitle("", for: .normal)
        createAccountButton.setTitleColor(Constants.Color.black, for: .normal)
        createAccountButton.titleLabel?.font = .systemFont(ofSize: 16, weight: .semibold)
        createAccountButton.addTarget(self, action: #selector(didTapCreateAccountButton), for: .touchUpInside)
    }
    
    private func delegatesFields() {
        emailText.delegate = self
        passwordText.delegate = self
    }
    
    @objc private func runSpinnerValidationLogin(validate: Bool) {
        if validate {
            DispatchQueue.main.asyncAfter(deadline: .now()+4) {
                self.loginButton.stopAnimation(animationStyle: .expand, revertAfterDelay: 1) {
                    let vc = TabBarController()
                    vc.modalPresentationStyle = .fullScreen
                    self.present(vc, animated: true)
                }
            }
        } else {
            self.loginButton.stopAnimation(animationStyle: .normal, revertAfterDelay: 1) {
                self.view.layer.opacity = 1
                Alerts.showAlertErrorWhitTitle(
                    titulo: Constants.LogInError.titleAlertVerificationFailed,
                    conMensaje: "¡Email or password is incorrrect!",
                    conNombreDeBotonCancelar: "Aceptar",
                    enControlador: self,
                    conCompletion: nil)
            }
        }
    }
    
    @objc private func didTapLoginButton() {
        
        passwordText.resignFirstResponder()
        emailText.resignFirstResponder()

        guard let usernameEmail = emailText.text, let password = passwordText.text else {
            return
        }
        
        ///Hacer todar el spinner y opacar el view
        loginButton.startAnimation()
        ///view.layer.opacity = 0.5
        
        AuthManager.shared.login(email: usernameEmail, password: password) { success in
            DispatchQueue.main.async {
                if success {
                    ///Success login
                    self.runSpinnerValidationLogin(validate: true)
                } else {
                    ///Error ocurred
                    self.runSpinnerValidationLogin(validate: false)
                }
            }
        }
        /*spinner = UIActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
        spinner.center = view.center
        spinner.style = UIActivityIndicatorView.Style.large
        spinner.color = .red
        spinner.hidesWhenStopped = true
        
        view.addSubview(spinner)
        spinner.startAnimating()*/
    }
    @objc private func didTapTermsButton() {}
    @objc private func didTapPrivacyButton() {}
    @objc private func didTapCreateAccountButton() {
        spinner.stopAnimating()
        let vc = RegistrationViewController()
        vc.delegateEmail = self
        vc.title = "Create Account"
        present(UINavigationController(rootViewController: vc), animated: true)
    }
    
    
    ///Animate button
    private func animateView(_ viewToAnimate: UIView) {
        UIView.animate(withDuration: 0.15, delay: 0, usingSpringWithDamping: 0.2, initialSpringVelocity: 0.5, options: .curveEaseIn) {
            viewToAnimate.transform = CGAffineTransform(scaleX: 0.92, y: 0.92)
        } completion: { (_) in
            print("Animation complete")
        }
    }
}


extension LoginViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == emailText {
            passwordText.becomeFirstResponder()
        } else if textField == passwordText {
            didTapLoginButton()
        }
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField.text?.count == 0  {
            print("Esta vacio....")
            loginButton.isEnabled = false
        } else {
            print("Esta lleno....")
        }
    }
    
}
