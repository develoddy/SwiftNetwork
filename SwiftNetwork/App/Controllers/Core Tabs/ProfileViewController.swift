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
    
    private var collectionView: UICollectionView?
    
    private var userPosts = [UserPostViewModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        //setupView()
        handleNotAuthenticated()
        configureNavigationBar()
        configureCollectionView()
        delegateCollectionView()
        setupModel()
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        collectionView?.frame = view.bounds
    }
    
    private func setupView() {
        title = "Profile"
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
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "LogOut", style: .done, target: self, action: #selector(didTapSettingsButton))
    }
    
    ///Configure collections
    private func configureCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        
        layout.minimumLineSpacing = 1
        layout.minimumInteritemSpacing = 1
        
        layout.sectionInset = UIEdgeInsets(top: 0, left: 1, bottom: 0, right: 1)
        let size = (view.width-4)/3
        layout.itemSize = CGSize(width: size, height: size)
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView?.backgroundColor = .systemBackground //.red
        collectionView?.showsVerticalScrollIndicator = false
        
        ///Photos grid collectionsView
        collectionView?.register(
            PhotoCollectionViewCell.self,
            forCellWithReuseIdentifier: PhotoCollectionViewCell.identifier)
        
        
        ///Header collections
        collectionView?.register(
            ProfileInfoHeaderCollectionReusableView.self,
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
            withReuseIdentifier: ProfileInfoHeaderCollectionReusableView.identifier)
        
        ///Tabs collections
        collectionView?.register(
            ProfileTabsCollectionReusableView.self,
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
            withReuseIdentifier: ProfileTabsCollectionReusableView.identifier)
        
        
        guard let collectionView = collectionView else {
            return
        }
        view.addSubview(collectionView)
    }
    
    private func delegateCollectionView() {
        collectionView?.delegate = self
        collectionView?.dataSource = self
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
        if section == 0 {
            return 0
        }
        return userPosts.count
    }
    
    ///PhotoCollectionViewCell
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let model = userPosts[indexPath.row]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PhotoCollectionViewCell.identifier, for: indexPath) as! PhotoCollectionViewCell
        cell.configure(with: model)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        guard kind == UICollectionView.elementKindSectionHeader else {
            // Footer
            return UICollectionReusableView()
        }
        
        if indexPath.section == 1 {
            ///Tabs
            let tabControllerHeader = collectionView.dequeueReusableSupplementaryView(
                ofKind: kind,
                withReuseIdentifier: ProfileTabsCollectionReusableView.identifier,
                for: indexPath) as! ProfileTabsCollectionReusableView
            tabControllerHeader.delegate = self
            return tabControllerHeader
        }
        ///Header
        let profileHeader = collectionView.dequeueReusableSupplementaryView(
            ofKind: kind,
            withReuseIdentifier: ProfileInfoHeaderCollectionReusableView.identifier,
            for: indexPath) as! ProfileInfoHeaderCollectionReusableView
        profileHeader.delegate = self
        return profileHeader
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        if section == 0 {
            return CGSize(width: collectionView.width, height: collectionView.height/1.3) //3
        }
        // Size of section tabs
        return CGSize(width: collectionView.width, height: 50)
    }
    
    ///Select o click on photo
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        // get the model and open post controller
        let model = userPosts[indexPath.row]
        let vc = PostViewController(model: model)
        vc.navigationItem.largeTitleDisplayMode = .never
        navigationController?.pushViewController(vc, animated: true)
        vc.title = "Posts" ///model.postType.rawValue
    }
    
    
}


// MARK: ProfileInfoHeaderCollectionReusableViewDelegate
extension ProfileViewController: ProfileInfoHeaderCollectionReusableViewDelegate {
    
    func profileHeaderDidTapPostButton(_header: ProfileInfoHeaderCollectionReusableView) {
        // scroll to the posts
        collectionView?.scrollToItem(at: IndexPath(row: 0, section: 1), at: .top, animated: true)
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
        vc.title = "Create Post"
        vc.modalPresentationStyle = .fullScreen
        vc.navigationItem.largeTitleDisplayMode = .never
        //present(vc, animated: true)
        present(UINavigationController(rootViewController: vc), animated: true)
    }
}

// MARK: ProfileTabsCollectionReusableViewDelegate
extension ProfileViewController: ProfileTabsCollectionReusableViewDelegate {
    
    func didTapGridButtonTab() {
        // Reload collection view with data
        
        DispatchQueue.main.async{
            self.setupModel()
            self.collectionView?.reloadData()
        }
    }
    
    func didTapTaggedButtonTab() {
        // Reload collection view with data
        /*switch ind {
        case SelectedScope.photos.rawValue :
            
        case SelectedScope.tagged.rawValue :
        }*/
        
        
        self.userPosts = [UserPostViewModel]()
        
        var likes = [PostLikeViewModel]()
        for i in 0..<2 {
            let data = PostLikeViewModel(
                username: "jor \(i)",
                postIdentifier: "",
                text: "Mi primera publicacion para el test de la App.",
                likes: i)
            likes.append(data)
        }
        
        var comments = [PostCommentsViewModel]()
        for x in 0..<2 {
            comments.append(
                PostCommentsViewModel(
                    id: x+1,
                    username: "@save",
                    type_id: 0,
                    ref_id: 0,
                    userss_id: 0,
                    content: "Great post!",
                    comentario_id: 0,
                    createdAt: Date(),
                    likes: []
                    
                    /*identifier: "123\(x)",
                    username: "@save",
                    text: "Great post!",
                    createDate: Date(),
                    likes: []*/
                )
            )
        }
        
        let user = UserViewModel(
            name: (first: "", last: ""),
            username: "@username",
            bio: "",
            profilePicture: URL(string: "https://wwww.google.com")!,
            dayOfBirth: Date(),
            gender: .male,
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
            /**name: (first: "", last: ""),
            username: "joe",
            bio: "",
            profilePicture: URL(string: "https://wwww.google.com")!,
            birthDate: Date(),
            gender: .male,
            email: "",
            counts: UserCount(followers: 1, following: 1, posts: 1),
            joinDate: Date()**/
        
        )
        
        for i in 0..<5 {
            let post = UserPostViewModel(
                identifier: "",
                postType: .photo,
                thumbnailImage: URL(
                    string: "http://127.0.0.1:8000/storage/app-new-publish/EddyLujan/images/img\(i+1).jpeg")!,
                postURL: URL(string: "https://wwww.google.com")!,
                caption: "Esto es un titlo del post para un ejemplo en el Iphone de hacer proueba y test",
                likeCount: likes,
                comments: comments,
                createDate: Date(),
                taggedUsers: [],
                owner: user)
            
            userPosts.append(post)
            
        }
        

        DispatchQueue.main.async{
            self.collectionView?.reloadData()
        }
    }
}

extension ProfileViewController {
    
    ///Call APIService
    ///Loop through the data and save it to the Model object
    private func fetchPostLikeData() -> [PostLikeViewModel] {
        var likes = [PostLikeViewModel]()
        APIService.shared.apiToGetPostLikeData(token: handleNotAuthenticated()) {(iReqResponsePostLike) in
            let count = iReqResponsePostLike.data!.count
            for i in 0..<count {
                let data = PostLikeViewModel(
                    username        : iReqResponsePostLike.data![i].username!   ,
                    postIdentifier  : iReqResponsePostLike.data![i].text!       ,
                    text            : iReqResponsePostLike.data![i].text!       ,
                    likes           : iReqResponsePostLike.data![i].likes!      )
                likes.append(data)
            }
            print(likes)
        }
        return likes
    }
    ///Call APIService
    private func fetchPostCommentsData() -> [UserViewModel] {
        var user = [UserViewModel]()
        return user
    }
    ///Call APIService
    private func fetchUserData() -> [PostCommentsViewModel] {
        var comments = [PostCommentsViewModel]()
        return comments
    }
    ///Call APIService
    private func fetchUserPostData() -> [UserPostViewModel] {
        var userPosts = [UserPostViewModel]()
        return userPosts
    }
    
    
    
    
    
    
    private func setupModel() {
        
        /*var likes = [PostLike]()
        for i in 0..<5 {
            let data = PostLike(
                username: "jor \(i)",
                postIdentifier: "",
                text: "Mi primera publicacion para el test de la App.",
                likes: i)
            likes.append(data)
        }*/
        
        
        
        
        
      
        var comments = [PostCommentsViewModel]()
        for x in 0..<4 {
            comments.append(
                PostCommentsViewModel(
                    id: x+1,
                    username: "@save",
                    type_id: 0,
                    ref_id: 0,
                    userss_id: 0,
                    content: "Great post!",
                    comentario_id: 0,
                    createdAt: Date(),
                    likes: []
                    /*identifier: "123\(x)",
                    username: "@save",
                    text: "Great post!",
                    createDate: Date(),
                    likes: []*/
                )
            )
        }
        
        let user = UserViewModel(
            name: (first: "", last: ""),
            username: "@username",
            bio: "",
            profilePicture: URL(string: "https://wwww.google.com")!,
            dayOfBirth: Date(),
            gender: .male,
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
            /**name: (first: "", last: ""),
            username: "joe",
            bio: "",
            profilePicture: URL(string: "https://wwww.google.com")!,
            birthDate: Date(),
            gender: .male,
            email: "",
            counts: UserCount(followers: 1, following: 1, posts: 1),
            joinDate: Date()**/
        )
        
        
        
        ///Call fetchPostLikeData
        let likes = fetchPostLikeData()
        
        for i in 0..<10 {
            let post = UserPostViewModel(
                identifier: "",
                postType: .photo,
                thumbnailImage: URL(
                    string: "http://127.0.0.1:8000/storage/app-new-publish/EddyLujan/images/img\(i+1).jpeg")!,
                postURL: URL(string: "https://wwww.google.com")!,
                caption: "Esto es un titlo del post para un ejemplo en el Iphone de hacer proueba y test",
                likeCount: likes,
                comments: comments,
                createDate: Date(),
                taggedUsers: [],
                owner: user)
            
            userPosts.append(post)
        }
        
    }
}










