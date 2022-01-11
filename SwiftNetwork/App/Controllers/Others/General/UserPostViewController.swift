//
//  UserPostViewController.swift
//  SwiftNetwork
//
//  Created by Eddy Donald Chinchay Lujan on 28/10/21.
//

import UIKit
import CoreData

class UserPostViewController: UIViewController {
    
    let collectionViewTwo = ProfileCollectionsViews.collectionViewTwo()
    
    var cellHeader : UICollectionReusableView?
    
    var models = [Userpost]()
    
<<<<<<< HEAD
    //Core data
    //var managedObjects = [NSManagedObject]()
    
    //MARK: - Init
    init(author_ref_id:Int, email: String, token: String) {
        print("UserPost: \(author_ref_id) - \(email)")
        super.init(nibName: nil, bundle: nil)
        //loadUserpostData(email: email, token: token)
        fetchUserPost(author_ref_id: author_ref_id, email: email, token: token)
=======
    private var user: User?
    
    private var story = [Storyfeatured]()
    
    //MARK: Init
    init(email: String, token: String) {
        super.init(nibName: nil, bundle: nil)
        fetchUserPost(email: email, token: token)
        
>>>>>>> parent of 684acd5... Post update caption
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        configureHeader()
        configureCollectionViewTwo()
        //configureSpinner()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.collectionViewTwo.frame = view.bounds
    }
    
    private func setupView() {
        view.backgroundColor = .systemBackground
    }
    
    ///Configure spinner
//    private func configureSpinner() {
//        CustomLoader.instance.viewColor = UIColor.systemBackground
//        CustomLoader.instance.setAlpha = 0.8
//        CustomLoader.instance.gifName = Constants.Spinner.spinner
//        showSpinner()
//    }
    
    ///Spinner
    ///Muestra el spiner mientras los datos de van cargando...
//    private func showSpinner() {
//        CustomLoader.instance.showLoader()
//    }
    
    
    
    
<<<<<<< HEAD
    ///Llamamos al viewModel para traer los datos.
    /*private func loadUserpostData(email:String, token: String) {
        viewModel.fetchUserpostData(email: email, token: token) { ( result ) in
            switch result {
            case .success(_/*let model*/):
                self.collectionViewTwo.delegate = self
                self.collectionViewTwo.dataSource = self
                DispatchQueue.main.async {
                    CustomLoader.instance.hideLoader()
                    self.collectionViewTwo.reloadData()
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }*/
    
    
    func fetchUserPost(author_ref_id: Int, email:String, token: String)  {
        viewModel.fetchUserPostData(author_ref_id: author_ref_id, email: email) { (result) in
            switch result {
            case .success(_):
                self.collectionViewTwo.delegate = self
                self.collectionViewTwo.dataSource = self
                //DispatchQueue.main.async {
                  //  CustomLoader.instance.hideLoader()
                    //self.collectionViewTwo.reloadData()
                //}
=======
    ///Api Rest.
    ///En esta función llamamos al Api rest para traes los datos de la DataBase,
    ///Desde handleNotAuthenticated ontenemos tanto el token como el email del usario que está conectado a la App.
    private func fetchUserPost(email: String, token: String) {
        APIService.shared.apiProfile(email: email, token: token ) {(result) in
            switch result {
            case .success(let model):
                model.userpost?.count != 0 ? self.setupModel(with: model.userpost ?? []) : print("Array Userpost está vacio...")
>>>>>>> parent of 684acd5... Post update caption
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    ///Models
    ///Está función revcibe los datos para tratarlos y guardalos en el array Modelo.
    ///Recorremos el array del modelo userpost.
    ///El modelo pintara los datos del user post acorde al email.
    private func setupModel(with model: [Userpost] ) {
        for items in model {
            let userpost = Userpost(id: items.id, title: items.title, content: items.content, lat: items.lat, lng: items.lng, startAt: items.startAt, finishAt: items.finishAt, receptorTypeID: items.receptorRefID, authorRefID: items.authorRefID, receptorRefID: items.receptorRefID, posttTypeID: items.posttTypeID, nivelID: items.nivelID, createdAt: items.createdAt, updatedAt: items.updatedAt, idPostType: items.idPostType, comments: items.comments, likes: items.likes, taggeds: items.taggeds, userAuthor: items.userAuthor, postImage: items.postImage, postType: items.postType, storyfeatured: items.storyfeatured )
            models.append(userpost)
            
            guard let user = items.userAuthor, let story = items.storyfeatured else { return }
            self.user = user
            self.story.append(contentsOf: story)
        }
        
        DispatchQueue.main.async {
            CustomLoader.instance.hideLoader()
            self.collectionViewTwo.reloadData()
        }
    }
    
    private func configureHeader() {
        collectionViewTwo.register(StoryFeaturedCollectionTableViewCell.self,forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,withReuseIdentifier: StoryFeaturedCollectionTableViewCell.identifier)
        
        collectionViewTwo.register(ProfileInfoHeaderCollectionReusableView.self,forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,withReuseIdentifier: ProfileInfoHeaderCollectionReusableView.identifier)
        
        collectionViewTwo.register(ProfileTabsCollectionReusableView.self,forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,withReuseIdentifier: ProfileTabsCollectionReusableView.identifier)
        
    }
    
    private func configureCollectionViewTwo() {
        collectionViewTwo.delegate = self
        collectionViewTwo.dataSource = self
        collectionViewTwo.register(PhotoCollectionViewCell.self, forCellWithReuseIdentifier: PhotoCollectionViewCell.identifier)
        view.addSubview(collectionViewTwo)
        collectionViewTwo.reloadData()
    }
    
    public func getUserToken() -> ResponseTokenBE? {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        guard let token = appDelegate.objUsuarioSesion else {
            return getUserToken()
        }
        return token
    }
}


extension UserPostViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 3
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
            return 0 ///Header
        }
        if section == 1 {
            return 0 ///Header
        }
<<<<<<< HEAD
        return viewModel.numberOfRowsInSection(section: section)
   
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
=======
        return  models.count ///Collections photos
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let model = models[indexPath.row]
>>>>>>> parent of 684acd5... Post update caption
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PhotoCollectionViewCell.identifier, for: indexPath) as! PhotoCollectionViewCell
        let model = viewModel.cellForRowAt(indexPath: indexPath)
        let postImages = viewModel.fetchPostImageData(post: model)
        cell.setCellWithValuesOf(with: postImages)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (view.frame.width/3)-1, height: 150)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 10, left: 0, bottom: 10, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard kind == UICollectionView.elementKindSectionHeader else { return UICollectionReusableView() }
        switch indexPath.section {
            case 0:
<<<<<<< HEAD
                let header = collectionView.dequeueReusableSupplementaryView(
                    ofKind: kind,withReuseIdentifier: ProfileInfoHeaderCollectionReusableView.identifier,
                    for: indexPath) as! ProfileInfoHeaderCollectionReusableView
                let model = viewModel.cellForRowAt(indexPath: indexPath)
                header.configureProfile(with: model)
=======
                let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind,withReuseIdentifier: ProfileInfoHeaderCollectionReusableView.identifier,for: indexPath) as! ProfileInfoHeaderCollectionReusableView
                if self.user != nil {
                    guard let user = self.user else { return UICollectionReusableView() }
                    if self.user?.email == self.getUserToken()?.usertoken?.email {
                        header.configureProfile(with: user)
                        header.delegate = self
                    } else {
                        header.configureUser(with: user)
                        header.delegate = self
                    }
                }
>>>>>>> parent of 684acd5... Post update caption
                return header
            case 1:
                let storyHeader = collectionView.dequeueReusableSupplementaryView(ofKind: kind,withReuseIdentifier: StoryFeaturedCollectionTableViewCell.identifier,for: indexPath) as! StoryFeaturedCollectionTableViewCell
                if self.story.count > 0 {
                    storyHeader.configure(model: self.story)
                }
                return storyHeader
            case 2:
                let tabsHeader = collectionView.dequeueReusableSupplementaryView(ofKind: kind,withReuseIdentifier: ProfileTabsCollectionReusableView.identifier,for: indexPath) as! ProfileTabsCollectionReusableView
                    tabsHeader.delegate = self
                return tabsHeader
            default: fatalError()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        if section == 0 { // Header
            return CGSize(width: collectionView.width, height: collectionView.height/2.5)
        }
        if section == 1 { // Story
            return CGSize(width: collectionView.width, height: 90)
        }
        return CGSize(width: collectionView.width, height: 50) // Tabs
    }
    
    ///Select o click on photo
    ///Se empuja al PostViewController
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
<<<<<<< HEAD
        let model = viewModel.cellForRowAt(indexPath: indexPath)
=======
        let model = models[indexPath.row]
>>>>>>> parent of 684acd5... Post update caption
        let vc = PostViewController(model: model)
        vc.navigationItem.largeTitleDisplayMode = .never
        navigationController?.pushViewController(vc, animated: true)
        vc.title = "Posts"
    }
}



// MARK: - ProfileInfoHeaderCollectionReusableViewDelegate
extension UserPostViewController: ProfileReusableViewProtocol {
    
    func didTapPostButton(_header: ProfileInfoHeaderCollectionReusableView) {
        self.collectionViewTwo.scrollToItem(at: IndexPath(row: 0, section: 1), at: .top, animated: true) ///Scroll to the posts
    }
    
    func didTapFollowersButton(_header: ProfileInfoHeaderCollectionReusableView) {
        var mockData = [UserRelationship]()
        for x in 0..<10 {
            mockData.append(UserRelationship(username: "@joer", namm: "Joe Smith", type: x % 2 == 0 ? .following: .not_following))
        }
        let vc = ListViewController(data: mockData)
        vc.title = "Follower"
        vc.navigationItem.largeTitleDisplayMode = .never
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func didTapFollowingButton(_header: ProfileInfoHeaderCollectionReusableView) {
        var mockData = [UserRelationship]()
        for x in 0..<10 {
            mockData.append(UserRelationship(username: "@joer", namm: "Joe Smith", type: x % 2 == 0 ? .following: .not_following))
        }
        let vc = ListViewController(data: mockData)
        vc.title = "Following"
        vc.navigationItem.largeTitleDisplayMode = .never
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func didTapEditProfileButton(_header: ProfileInfoHeaderCollectionReusableView) {
        let vc = EditProfileViewController()
        vc.title = "Edit Profile"
        present(UINavigationController(rootViewController: vc), animated: true)
    }
    
    func didTapEditProfileButton(_post: ProfileInfoHeaderCollectionReusableView) {
        let vc = PublishPostViewController()
        vc.modalPresentationStyle = .fullScreen
        vc.navigationItem.largeTitleDisplayMode = .never
        present(UINavigationController(rootViewController: vc), animated: true)
    }
}


// MARK: - ProfileTabsCollectionReusableViewDelegate
extension UserPostViewController: ProfileTabsCollectionReusableViewDelegate {
    func didTapGridButtonTab() {
        print("didTapGridButtonTab")
        // Reload collection view with data
        //self.fetchUserPost(tabs: self.grid)
        //models = [UserpostViewModel]()
        collectionViewTwo.reloadData()
    }
    
    func didTapTaggedButtonTab() {
        print("didTapTaggedButtonTab")
        //Reload collection view with data
        //self.fetchUserPost(tabs: self.tagged)
        //models = [UserpostViewModel]()
        collectionViewTwo.reloadData()
    }
}
