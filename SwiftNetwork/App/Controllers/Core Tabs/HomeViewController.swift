//
//  HomeViewController.swift
//  Blubinn
//
//  Created by Eddy Donald Chinchay Lujan on 31/3/21.
//

import UIKit

class HomeViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        handleNotAuthenticated()
    }
    
    private func setupView() {
        title = "Home"
        view.backgroundColor = .systemBackground
    }
    
    private func handleNotAuthenticated() {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let token = appDelegate.objUsuarioSesion?.token
        
        if token == nil {
            print("IF home")
            let vc = LoginViewController()
            vc.modalPresentationStyle = .fullScreen
            self.present(vc, animated: false)
        } else {
            print("ElSE Home")
        }
    }
}
