//
//  SettingsViewController.swift
//  Blubinn
//
//  Created by Eddy Donald Chinchay Lujan on 31/3/21.
//

import UIKit

struct SettingCellModel {
    let tile: String
    let handler: ( () -> Void )
}

/// View Controller to show user settings
class SettingsViewController: UIViewController {
    
    private let tableView: UITableView = {
        let table = UITableView(frame: .zero, style: .grouped)
        table.translatesAutoresizingMaskIntoConstraints = false
        table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        return table
    }()
    
    private var data = [ [ SettingCellModel ] ]()
    
    //MARK: viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        configureTableView()
        configureModels()
    }
    
    //MARK: viewDidLayoutSubviews
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }
    
    private func setupView() {
        view.backgroundColor = .systemBackground
        view.addSubview(tableView)
    }
    
    private func configureTableView() {
        tableView.backgroundColor = .secondarySystemFill
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    private func configureModels() {
        let section = [
            SettingCellModel(tile: "Log Out") { [weak self] in
                self?.didTapLogOut()
            }
        ]
        data.append(section)
    }
    
    private func didTapLogOut() {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let token = appDelegate.objUsuarioSesion?.token
        
        UserLoginBC.logOut(token, conCompletionCorrecto: { (objUsuario) in
            
            let actionSheet = UIAlertController(
                title           : Constants.SignUp.titleAlert    ,
                message         : Constants.SignUp.subTitleAlert ,
                preferredStyle  : .actionSheet
            )
            actionSheet.addAction(UIAlertAction(title: "Cancel",
                                                style: .cancel,
                                                handler: nil))
            actionSheet.addAction(UIAlertAction(title: "Log Out",
                                                style: .destructive,
                                                handler: { _ in
                let vc = LoginViewController()
                vc.modalPresentationStyle = .fullScreen
                self.present(vc, animated: true, completion: {
                    self.navigationController?.popViewController(animated: false)
                    self.tabBarController?.selectedIndex = 0
                })
            }))
            actionSheet.popoverPresentationController?.sourceView = self.tableView
            actionSheet.popoverPresentationController?.sourceRect = self.tableView.bounds
            self.present(actionSheet, animated: true)
            
        }, conCompletionIncorrecto: {(mensajeError) in
            print("ELSE - ")
        })
    }
}


extension SettingsViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = data[indexPath.section][indexPath.row].tile
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        data[indexPath.section][indexPath.row].handler()
    }
}
