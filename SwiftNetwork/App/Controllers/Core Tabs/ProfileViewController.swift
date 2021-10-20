//
//  ProfileViewController.swift
//  Blubinn
//
//  Created by Eddy Donald Chinchay Lujan on 31/3/21.
//

import UIKit

enum SelectedScope: Int {
    case photos = 0
    case tagged = 1
}

/// Profile view controller
final class ProfileViewController: UIViewController {
    
    // private var collectionView: UICollectionView?
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 16
        layout.scrollDirection = .vertical
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = .clear
        return cv
    }()
    
    private var postLikeViewModel = [LikeViewModel]()
    
    private var postCommentsViewModel = [CommentViewModel]()
    
    //private var userViewModel = UserViewModel()
    
    private var userPostViewModel = [UserpostViewModel]()
    
    var spinner = UIActivityIndicatorView()
    
    var VW_overlay: UIView = UIView()
    
    let backgroundImageView: UIImageView = {
       let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.image = UIImage(named: "eddy")
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    
    let imagesCellId = "imagesCellId"
    let albumsCellId = "albumsCellId"

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        configureNavigationBar()
        //configureCollectionView()
        setupLayouts()
        setupRemaningNavItems()
        //setupModel(tabs: "grid")
        setupSpinner()
        ///Spinner
        //VW_overlay = UIView(frame: UIScreen.main.bounds)
        //VW_overlay.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.5)
    }
    
    private func setupSpinner() {
        spinner = UIActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
        spinner.center = view.center
        spinner.style = UIActivityIndicatorView.Style.large
        spinner.color = Constants.Color.general
        spinner.hidesWhenStopped = true
        view.addSubview(spinner)
        spinner.startAnimating()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        collectionView.frame = view.bounds
    }
    
    private func setupView() {
        view.backgroundColor = .systemBackground
        collectionView.delegate = self
        collectionView.dataSource = self
        
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "xx")
        collectionView.register(PhotoCollectionViewCell.self, forCellWithReuseIdentifier: PhotoCollectionViewCell.identifier)
        
        ///Header collections
//        collectionView.register(
//            ProfileInfoHeaderCollectionReusableView.self,
//            forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
//            withReuseIdentifier: ProfileInfoHeaderCollectionReusableView.identifier)
//
//        ///Tabs collections
//        collectionView.register(
//            ProfileTabsCollectionReusableView.self,
//            forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
//            withReuseIdentifier: ProfileTabsCollectionReusableView.identifier)
//
//        ///Tabs collections
//        collectionView.register(
//            ProfileTabsCollectionReusableView2.self,
//            forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
//            withReuseIdentifier: ProfileTabsCollectionReusableView2.identifier)
        
        
        //view.addSubview(backgroundImageView)
        view.addSubview(collectionView)
    }
    
    private func setupLayouts() {
        
        /*backgroundImageView.translatesAutoresizingMaskIntoConstraints = false
        let constraints1 = [
            backgroundImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0),
            backgroundImageView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0),
            backgroundImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0),
            backgroundImageView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0)
        ]
        NSLayoutConstraint.activate(constraints1)*/
        
        
        
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        let constraints2 = [
            collectionView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0),
            collectionView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0),
            collectionView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0)
        ]
        NSLayoutConstraint.activate(constraints2)
    }
    
    private func handleNotAuthenticated() -> String {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let token = appDelegate.objUsuarioSesion?.token
      
        if token == nil {
            let vc = LoginViewController()
            vc.modalPresentationStyle = .fullScreen
            self.present(vc, animated: false)
        }
        return token!
    }
    
    private func configureNavigationBar() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            title: "LogOut",
            style: .done,
            target: self,
            action: #selector(didTapSettingsButton))
    }
    
    ///Configure collections
    private func configureCollectionView() {
//        let layout = UICollectionViewFlowLayout()
//        layout.scrollDirection = .vertical
//        layout.minimumLineSpacing = 1
//        layout.minimumInteritemSpacing = 1
//        layout.sectionInset = UIEdgeInsets(top: 0, left: 1, bottom: 0, right: 1)
//        let size = (view.width-4)/3
//        layout.itemSize = CGSize(width: size, height: size)
//        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
//        collectionView?.backgroundColor = .systemBackground //.red
//        collectionView?.showsVerticalScrollIndicator = false
//
//        ///Photos grid collectionsView
//        collectionView?.register(
//            PhotoCollectionViewCell.self,
//            forCellWithReuseIdentifier: PhotoCollectionViewCell.identifier)
        
//        ///Header collections
//        collectionView?.register(
//            ProfileInfoHeaderCollectionReusableView.self,
//            forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
//            withReuseIdentifier: ProfileInfoHeaderCollectionReusableView.identifier)
//
//        ///Tabs collections
//        collectionView?.register(
//            ProfileTabsCollectionReusableView.self,
//            forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
//            withReuseIdentifier: ProfileTabsCollectionReusableView.identifier)
//
//        ///Tabs collections
//        collectionView?.register(
//            ProfileTabsCollectionReusableView2.self,
//            forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
//            withReuseIdentifier: ProfileTabsCollectionReusableView2.identifier)
        
//        guard let collectionView = collectionView else {
//            return
//        }
//        view.addSubview(collectionView)
    }
    
    
    
    @objc func didTapSettingsButton() {
        let vc = SettingsViewController()
        vc.title = "Setting"
        navigationController?.pushViewController(vc, animated: true)
    }
}


extension ProfileViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        //if section == 0 {return 0} print ("count:  \(userPostViewModel.count)")
        
        if section == 1 {
            print (userPostViewModel.count)
            return userPostViewModel.count  //9
        }
        return 1
    }
    
    ///PhotoCollectionViewCell
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.section == 1 {
            let model = userPostViewModel[indexPath.row]
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PhotoCollectionViewCell.identifier , for: indexPath) as!  PhotoCollectionViewCell
            //cell.configure(with: model)
            return cell
        }
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "xx", for: indexPath)
        cell.backgroundColor = .systemGreen
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.section == 1 {
            return CGSize(width: (view.frame.width/3)-16, height: 100)
        }
        return CGSize(width: view.frame.width, height: 300)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        if section == 1 {
            return UIEdgeInsets(top: 10, left: 8, bottom: 10, right: 8)
        }
        return UIEdgeInsets(top: 10, left: 0, bottom: 10, right: 0)
    }
    
    
    
//    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
//        //guard kind == UICollectionView.elementKindSectionHeader else {
//            // Footer
//            //return UICollectionReusableView()
//        //}
//        ///Si el array del objeto es 1 o superior
//        if userPostViewModel.count > 0 {
//            ///Header
//            if indexPath.section == 0 {
//                let model = userPostViewModel[indexPath.row]
//                if kind == UICollectionView.elementKindSectionHeader {
//                    let profileHeader = collectionView.dequeueReusableSupplementaryView(
//                    ofKind: kind,
//                    withReuseIdentifier: ProfileInfoHeaderCollectionReusableView.identifier,
//                    for: indexPath) as! ProfileInfoHeaderCollectionReusableView
//                    profileHeader.configure(model: model)
//                    profileHeader.delegate = self
//                    return profileHeader
//                }
//            }
//
//            ///Tabs
//            let tabControllerHeader = collectionView.dequeueReusableSupplementaryView(
//                ofKind: kind,
//                withReuseIdentifier: ProfileTabsCollectionReusableView.identifier,
//                for: indexPath) as! ProfileTabsCollectionReusableView
//                tabControllerHeader.delegate = self
//                return tabControllerHeader
//
//        } else { ///Simula la carga
//            let tabControllerHeader = collectionView.dequeueReusableSupplementaryView(
//            ofKind: kind,
//            withReuseIdentifier: ProfileTabsCollectionReusableView2.identifier,
//            for: indexPath) as! ProfileTabsCollectionReusableView2
//            return tabControllerHeader
//        }
//    }
//
//
//
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
//        if section == 0 {
//            return CGSize(width: collectionView.width, height: collectionView.height/2)
//        }
//        // Size of section tabs
//        return CGSize(width: collectionView.width, height: 50)
//    }
    
    
    
    

    ///Select o click on photo
//    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        collectionView.deselectItem(at: indexPath, animated: true)
//        // get the model and open post controller
//        let model = userPostViewModel[indexPath.row]
//        let vc = PostViewController(model: model)
//        vc.navigationItem.largeTitleDisplayMode = .never
//        navigationController?.pushViewController(vc, animated: true)
//        vc.title = "Posts" ///model.postType.rawValue
//    }
}

// MARK: - ProfileInfoHeaderCollectionReusableViewDelegate
extension ProfileViewController: ProfileInfoHeaderCollectionReusableViewDelegate {
    
    func profileHeaderDidTapPostButton(_header: ProfileInfoHeaderCollectionReusableView) {
        // scroll to the posts
        collectionView.scrollToItem(at: IndexPath(row: 0, section: 1), at: .top, animated: true)
    }
    
    func profileHeaderDidTapFollowersButton(_header: ProfileInfoHeaderCollectionReusableView) {
        var mockData = [UserRelationship]()
        for x in 0..<10 {
            mockData.append(UserRelationship(username: "@joer", namm: "Joe Smith", type: x % 2 == 0 ? .following: .not_following))
        }
        let vc = ListViewController(data: mockData)
        vc.title = "Follower"
        vc.navigationItem.largeTitleDisplayMode = .never
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func profileHeaderDidTapFollowingButton(_header: ProfileInfoHeaderCollectionReusableView) {
        var mockData = [UserRelationship]()
        for x in 0..<10 {
            mockData.append(UserRelationship(username: "@joer", namm: "Joe Smith", type: x % 2 == 0 ? .following: .not_following))
        }
        let vc = ListViewController(data: mockData)
        vc.title = "Following"
        vc.navigationItem.largeTitleDisplayMode = .never
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func profileHeaderDidTapEditProfileButton(_header: ProfileInfoHeaderCollectionReusableView) {
        let vc = EditProfileViewController()
        vc.title = "Edit Profile"
        present(UINavigationController(rootViewController: vc), animated: true)
    }
    
    func profileWritePostDidTapEditProfileButton(_post: ProfileInfoHeaderCollectionReusableView) {
        let vc = PublishPostViewController()
        vc.modalPresentationStyle = .fullScreen
        vc.navigationItem.largeTitleDisplayMode = .never
        present(UINavigationController(rootViewController: vc), animated: true)///present(vc, animated: true)
    }
}

// MARK: - ProfileTabsCollectionReusableViewDelegate
extension ProfileViewController: ProfileTabsCollectionReusableViewDelegate {
    func didTapGridButtonTab() {
        // Reload collection view with data
        userPostViewModel = [UserpostViewModel]()
        //self.setupModel(tabs: "grid")
    }
    
    func didTapTaggedButtonTab() {
        //Reload collection view with data
        userPostViewModel = [UserpostViewModel]()
        //setupModel(tabs: "tagged")
    }
}

// MARK: - ProfileViewController

/*
extension ProfileViewController {
    ///Call APIService
    ///Loop through the data and save it to the Model object //fetchUserPostData
    public func setupModel(tabs: String) {
        let group = DispatchGroup()
        group.enter()
        group.enter()
        group.enter()
        group.enter()
        
        var iReqResponseFeaturePosLike: IReqResponseFeaturePosLike?
        var iReqResponsePostComments: IReqResponsePostComments?
        var iReqResponseUser: IReqResponseUser?
        var iReqResponseUserPost: IReqResponseUserPost?
        
        ///Call to API apiToGetPostLikeData
        APIService.shared.apiToGetPostLikeData(token: handleNotAuthenticated(), tabs: tabs) {(result) in
            defer {
                group.leave()
            }
            switch result {
                case .success(let model):
                    iReqResponseFeaturePosLike = model
                case .failure(let error):
                    print(error.localizedDescription)
            }
        }
        
        ///Call to API apiToGetPostCommentsData
        APIService.shared.apiToGetPostCommentsData(token: handleNotAuthenticated(), tabs: tabs) {(result) in
            defer {
                group.leave()
            }
            switch result {
            case .success(let model):
                iReqResponsePostComments = model
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
        
        ///Call to API apiToGetUsersData
        APIService.shared.apiToGetUsersData(token: handleNotAuthenticated(), tabs: tabs) { (result) in
            defer {
                group.leave()
            }
            switch result {
            case .success(let model):
                iReqResponseUser = model
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
        
        ///Call to API apiToGetUserPostViewModelData
        APIService.shared.apiToGetUserPostViewModelData(token: handleNotAuthenticated(), tabs: tabs) { (result) in
            defer {
                group.leave()
            }
            
            switch result {
            case .success(let model):
                iReqResponseUserPost = model
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
        
        ///Configure Models
        group.notify(queue: .main) {
            guard let iPostLike = iReqResponseFeaturePosLike?.postlikes?.items,
                  let iPostComments = iReqResponsePostComments?.postComments,
                  let iReqResponseUser = iReqResponseUser?.user,
                  let iReqResponseUserPost = iReqResponseUserPost?.userpost else {
                return
            }
            self.configureModels(
                iPostLike: iPostLike,
                iPostComments: iPostComments,
                iReqResponseUser: iReqResponseUser,
                iReqResponseUserPost: iReqResponseUserPost)
        }
    }
    
    ///configureModels
    func configureModels(iPostLike: [IPostLike],
                         iPostComments: [PostComments],
                         iReqResponseUser: UserClass,
                         iReqResponseUserPost: [Userpost]) {
        
        ///Insert data in the model [PostLikeViewModel]()
        for items in iPostLike {
            postLikeViewModel.append(
                PostLikeViewModel(username: items.username!,
                                  postIdentifier: items.postIdentifier!,
                                  text: items.text!,
                                  likes: items.likes!))
        }
        
        ///Insert data in the model UserViewModel()
        for items in iPostComments {
            postCommentsViewModel.append(
                PostCommentsViewModel(id: items.id,
                                      username: items.username,
                                      typeId: items.typeId,
                                      refId: items.refId,
                                      userssId: items.userssId,
                                      content: items.content,
                                      comentarioId: items.comentarioId,
                                      createdAt: items.createdAt,
                                      likes: []))
        }
        
        ///Insert data in the model [PostCommentsViewModel]()
        userViewModel.name = iReqResponseUser.name
        userViewModel.last = iReqResponseUser.last
        userViewModel.username = iReqResponseUser.username
        userViewModel.bio = iReqResponseUser.name
        userViewModel.profilePicture = URL(string: iReqResponseUser.profilePicture!)
        userViewModel.dayOfBirth = Date()
        userViewModel.gender = GenderViewModel(gender: "male")
        userViewModel.publicEmail = iReqResponseUser.publicEmail
        userViewModel.counts = UserCountViewModel(followers: 1, following: 1, posts: 1)
        userViewModel.joinDate = Date()
        userViewModel.countryId = 0
        userViewModel.image =  iReqResponseUser.image
        userViewModel.imageHeader = iReqResponseUser.imageHeader
        userViewModel.title = iReqResponseUser.title
        userViewModel.likes =  iReqResponseUser.likes
        userViewModel.dislikes = iReqResponseUser.dislikes
        userViewModel.address = iReqResponseUser.address
        userViewModel.phone = iReqResponseUser.phone
        userViewModel.userssId = 0
        userViewModel.nivelId = 0
        userViewModel.sentimentalId = 0
        userViewModel.imagenBin = iReqResponseUser.imagenBin
        userViewModel.valor = iReqResponseUser.valor
        userViewModel.id = 0
    
        ///Insert data in the model [UserPostViewModel]()
        for items in iReqResponseUserPost {
            userPostViewModel.append(
                UserPostViewModel(
                    identifier: items.identifier!,
                    postType: .photo,
                    thumbnailImage: URL(string: items.thumbnailImage!)!,
                    postURL: URL(string: items.thumbnailImage!)!,
                    caption: items.caption,
                    likeCount: postLikeViewModel, /// [PostLikeViewModel]
                    comments: postCommentsViewModel, ///[PostCommentsViewModel]
                    createDate: Date(),
                    taggedUsers: [], ///UserViewModel
                    owner: userViewModel))
        }
        
        ///Cuando el objeto UserPostVieewModel termine de cargar los datos, entonces el spiner se detendrá y mostrara la view.
        spinner.stopAnimating()
        VW_overlay.isHidden = true
      
        DispatchQueue.main.async{
            self.collectionView.reloadData()
        }
    }
}
*/

extension ProfileViewController {
    private func setupRemaningNavItems() {
        let followButton = UIButton(type: .system)
        followButton.setTitle("eddylujann", for: .normal)
        followButton.titleLabel?.font = .systemFont(ofSize: 26, weight: .black )
        followButton.tintColor = Constants.Color.black
        //followButton.frame = CGRect(x: 0, y: 0, width: 34, height: 34)
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: followButton)
        navigationController?.navigationBar.backgroundColor = .white
        navigationController?.navigationBar.isTranslucent = false
    }
}
