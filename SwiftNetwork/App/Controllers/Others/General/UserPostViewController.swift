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
    
    private var viewModel = UserPostViewModel()
    
    //Core data
    //var managedObjects = [NSManagedObject]()
    
    //MARK: - Init
    init(author_ref_id:Int, email: String, token: String) {
        print("UserPost: \(author_ref_id) - \(email)")
        super.init(nibName: nil, bundle: nil)
        //loadUserpostData(email: email, token: token)
        fetchUserPost(author_ref_id: author_ref_id, email: email, token: token)
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
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    private func configureHeader() {
        collectionViewTwo.register(StoryFeaturedCollectionTableViewCell.self,forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,withReuseIdentifier: StoryFeaturedCollectionTableViewCell.identifier)
        
        collectionViewTwo.register(ProfileInfoHeaderCollectionReusableView.self,forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,withReuseIdentifier: ProfileInfoHeaderCollectionReusableView.identifier)
        
        collectionViewTwo.register(ProfileTabsCollectionReusableView.self,forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,withReuseIdentifier: ProfileTabsCollectionReusableView.identifier)
        
    }
    
    private func configureCollectionViewTwo() {
        collectionViewTwo.register(PhotoCollectionViewCell.self, forCellWithReuseIdentifier: PhotoCollectionViewCell.identifier)
        view.addSubview(collectionViewTwo)
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
        return viewModel.numberOfSections()
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
            return 0 ///Header
        }
        if section == 1 {
            return 0 ///Header
        }
        return viewModel.numberOfRowsInSection(section: section)
   
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
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
                let header = collectionView.dequeueReusableSupplementaryView(
                    ofKind: kind,withReuseIdentifier: ProfileInfoHeaderCollectionReusableView.identifier,
                    for: indexPath) as! ProfileInfoHeaderCollectionReusableView
                let model = viewModel.cellForRowAt(indexPath: indexPath)
                header.configureProfile(with: model)
                return header
            case 1:
                let storyHeader = collectionView.dequeueReusableSupplementaryView(ofKind: kind,withReuseIdentifier: StoryFeaturedCollectionTableViewCell.identifier,for: indexPath) as! StoryFeaturedCollectionTableViewCell
                if self.viewModel.story.count > 0 {
                    storyHeader.configure(model: self.viewModel.story)
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
        let model = viewModel.cellForRowAt(indexPath: indexPath)
        let vc = PostViewController(model: model)
        vc.navigationItem.largeTitleDisplayMode = .never
        navigationController?.pushViewController(vc, animated: true)
        vc.title = "Posts"
    }
}



// MARK: - ProfileInfoHeaderCollectionReusableViewDelegate
extension UserPostViewController: ProfileInfoHeaderCollectionReusableViewDelegate {
    func profileHeaderDidTapPostButton(_header: ProfileInfoHeaderCollectionReusableView) {
        self.collectionViewTwo.scrollToItem(at: IndexPath(row: 0, section: 1), at: .top, animated: true) ///Scroll to the posts
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
