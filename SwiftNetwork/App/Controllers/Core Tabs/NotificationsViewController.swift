//
//  NotificationsViewController.swift
//  Blubinn
//
//  Created by Eddy Donald Chinchay Lujan on 13/4/21.
//

import UIKit
enum UserNotificationType {
    case like(post: Userpost)
    case follow(state: FollowState)
}

struct UserNotification {
    let type: UserNotificationType
    let text: String
    let user: User
}

final class NotificationsViewController: UIViewController {
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.isHidden = false
        tableView.register(NotificationLikeEventTableViewCell.self, forCellReuseIdentifier: NotificationLikeEventTableViewCell.identifier)
        tableView.register(NotificationFollowEventTableViewCell.self, forCellReuseIdentifier: NotificationFollowEventTableViewCell.identifier)
        return tableView
    }()
    
    private let spinner: UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView(style: .large)
        spinner.hidesWhenStopped = true
        spinner.tintColor = .label
        return spinner
    }()
    
    private lazy var noNotificationsView = NoNotificationsView()
    
    private var models = [UserNotification]()
    
    // MARK: LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        //fetchNotifications()
        setupView()
        configureTableView()
        //addNoNotificationsView()
        //spinner.startAnimating()
        
        fetchUserPost()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
        spinner.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        spinner.center = view.center
    }
    
    ///Token
    public func getUserToken() -> ResponseTokenBE? {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        guard let token = appDelegate.objUsuarioSesion else {
            return getUserToken()
        }
        return token
    }
    
    ///Api Rest.
    ///Hacemos una llamada al Api rest.
    ///Una vez obtenido los datos que queremos, se lo enviamos a la funcion setuModel.
    private func fetchUserPost() {
        /*APIService.shared.getUserPost(token: getUserToken()?.token ?? "" ) {(result) in
            switch result {
            case .success(let model):
                model.userpost?.count != 0 ? self.setupModel(with: model.userpost ?? []) : print("Array Userpost está vacio...")
            case .failure(let error):
                print(error.localizedDescription)
            }
        }*/
    }
    
    ///Models
    ///Está función recibe  los datos para tratarlos y guardalos en el array Modelo.
    private func setupModel(with model: [Userpost] ) {
        for items in model {
            guard let user = items.userAuthor else { return }
            
            let model = UserNotification(
                type: .like(post: items),
                text: "Te mencionó en sus comentarios.",
                user: user)
            
            models.append(model)
        }
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    /*
    private func fetchNotifications() {
        for i in 0..<10 {
            let user = UserViewModel(
                name: "",
                last: "",//(first: "", last: ""),
                username: "@username",
                bio: "",
                profilePicture: URL(string: "http://127.0.0.1:8000/storage/app-new-publish/EddyLujan/images/img\(i+1).jpeg")!,
                dayOfBirth: Date(),
                gender: GenderViewModel(gender: "male"),//.male,
                publicEmail: "",
                counts: UserCountViewModel(followers: 1, following: 1, posts: 1),
                joinDate: Date(),
                countryId: 0,
                image: "",
                imageHeader: "",
                title: "",
                likes: "",
                dislikes: "",
                address: "",
                phone: "",
                userssId: 0,
                nivelId: 0,
                sentimentalId: 0,
                imagenBin: "",
                valor: "",
                id: 0
            )
            
            let post = UserPostViewModel(identifier: "",
                                postType: .photo,
                                thumbnailImage: URL(string: "http://127.0.0.1:8000/storage/app-new-publish/EddyLujan/images/img\(i+1).jpeg")!,
                                postURL: URL(string: "https://wwww.google.com")!,
                                caption: nil,
                                likeCount: [],
                                comments: [],
                                createDate: Date(),
                                taggedUsers: [],
                                owner: user)
            
            let model = UserNotification(
                type: i % 2 == 0 ? .like(post: post): .follow(state: .not_following),
                text: "He mentioned you in his comments.", user: user)
            
            self.models.append(model)
            
        }
    }*/
    
    private func addNoNotificationsView() {
        tableView.isHidden = true
        noNotificationsView.frame = CGRect(x: 0, y: 0, width: view.width/2, height: view.width/4)
        noNotificationsView.center = view.center
    }
    
    private func setupView() {
        navigationItem.title = "Notifications"
        view.backgroundColor = .systemBackground

        view.addSubview(tableView)
        view.addSubview(noNotificationsView)
        view.addSubview(spinner)
    }
    
    private func configureTableView() {
        tableView.backgroundColor = .secondarySystemFill
        tableView.delegate = self
        tableView.dataSource = self
    }
}

// MARK: TableView
extension NotificationsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return models.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = models[indexPath.row]
        switch model.type {
        case .like(_):
            let cell = tableView.dequeueReusableCell(withIdentifier: NotificationLikeEventTableViewCell.identifier, for: indexPath) as! NotificationLikeEventTableViewCell
            cell.configure(with: model)
            cell.delgate = self
            return cell
        
        case .follow:
            let cell = tableView.dequeueReusableCell(withIdentifier: NotificationFollowEventTableViewCell.identifier, for: indexPath) as! NotificationFollowEventTableViewCell
                cell.configure(with: model)
            cell.delgate = self
            return cell
        }
        //return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
}

extension NotificationsViewController: NotificationLikeEventTableViewCellDelegate {
    func didTapRelatedPostButton(model: UserNotification) {
//        switch model.type {
//        case .like(let post):
//            let vc = PostViewController(model: post)
//            vc.title = "Notificaciones"
//            vc.navigationItem.largeTitleDisplayMode = .never
//            navigationController?.pushViewController(vc, animated: true)
//        case .follow(_):
//            fatalError("Dev Issue: Should never get called")
//        }
    }
}

extension NotificationsViewController: NotificationFollowEventTableViewCellDelegate {
    func didTapFollowUnFollowButton(model: UserNotification) {
        print("Tapped button")
        // perform databse update
    }
}
