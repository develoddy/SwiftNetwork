//
//  SettingsViewController.swift
//  Blubinn
//
//  Created by Eddy Donald Chinchay Lujan on 31/3/21.
//

import SafariServices
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
        data.append([
            SettingCellModel(tile: "Edit Profile") { [weak self] in
                self?.didTapEditProfile()
            },
            SettingCellModel(tile: "Invite Fiends") { [weak self] in
                self?.didTapInviteFriends()
            },
            SettingCellModel(tile: "Save original Posts") { [weak self] in
                self?.didTapSaveOriginalPosts()
            }
        ])
        
        data.append([
            SettingCellModel(tile: "Terms of Serviced") { [weak self] in
                self?.openURL(type: .terms)
            },
            SettingCellModel(tile: "Privacy Policy") { [weak self] in
                self?.openURL(type: .privacy)
            },
            SettingCellModel(tile: "Help / FeedBack") { [weak self] in
                self?.openURL(type: .help)
            }
        ])
        
        data.append([
            SettingCellModel(tile: "Log Out") { [weak self] in
                self?.didTapLogOut()
            }
        ])
    }
    
    enum  SettingURLType {
        case terms, privacy, help
    }
    
    private func openURL(type: SettingURLType) {
        
        let urlString: String
        switch type {
        case .terms: urlString = "https://help.instagram.com/1215086795543252"
        case .privacy: urlString = "https://help.instagram.com/519522125107875"
        case .help: urlString = "https://help.instagram.com/478745558852511/?helpref=hc_fnav"
        }
        guard let url = URL(string: urlString) else {
            return
        }
        
        let vc = SFSafariViewController(url: url)
        present(vc, animated: true)
    }
    
    private func didTapSaveOriginalPosts() {
        
    }
    
    private func didTapEditProfile() {
        let vc = EditProfileViewController()
        vc.title = "Edit Profile"
        let navVC = UINavigationController(rootViewController: vc)
        navVC.modalPresentationStyle = .fullScreen
        present(navVC, animated: true)
        
    }
    
    private func didTapInviteFriends() {
        
    }
    
    private func didTapLogOut() {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let token = appDelegate.objUsuarioSesion?.token
        
        BCApiRest.logOut(token, conCompletionCorrecto: { (objUsuario) in
            
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
        cell.accessoryType = .disclosureIndicator
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        data[indexPath.section][indexPath.row].handler()
    }
}
