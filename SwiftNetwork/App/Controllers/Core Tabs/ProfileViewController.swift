//
//  ProfileViewController.swift
//  Blubinn
//
//  Created by Eddy Donald Chinchay Lujan on 31/3/21.
//

import UIKit

/// Profile view controller
final class ProfileViewController: UIViewController {
    
    private var collectionView: UICollectionView?
    
    private var userPosts = [UserPost]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        //setupView()
        configureNavigationBar()
        configureCollectionView()
        delegateCollectionView()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        collectionView?.frame = view.bounds
    }
    
    private func setupView() {
        title = "Profile"
    }
    
    private func configureNavigationBar() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "LogOut", style: .done, target: self, action: #selector(didTapSettingsButton))
    }
    
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
        
        //Cells register
        collectionView?.register(PhotoCollectionViewCell.self, forCellWithReuseIdentifier: PhotoCollectionViewCell.identifier)
        
        // Header
        collectionView?.register(ProfileInfoHeaderCollectionReusableView.self,
                                 forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                                 withReuseIdentifier: ProfileInfoHeaderCollectionReusableView.identifier)
        
        //
        collectionView?.register(ProfileTabsCollectionReusableView.self,
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
        // return userPosts.count
        return 30
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        //let model = userPosts[indexPath.row]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PhotoCollectionViewCell.identifier, for: indexPath) as! PhotoCollectionViewCell
        //cell.configure(with: model)
        cell.configure(debug: "test")
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        // get the model and open post controller
        //let model = userPosts[indexPath.row]
        
        let user = User(name: (first: "", last: ""),
                        username: "joe",
                        bio: "",
                        profilePicture: URL(string: "https://wwww.google.com")!,
                        birthDate: Date(),
                        gender: .male,
                        email: "",
                        counts: UserCount(followers: 1, following: 1, posts: 1),
                        joinDate: Date() )
        
        let post = UserPost(identifier: "",
                            postType: .photo,
                            thumbnailImage: URL(string: "https://wwww.google.com")!,
                            postURL: URL(string: "https://wwww.google.com")!,
                            caption: nil,
                            likeCount: [],
                            comments: [],
                            createDate: Date(),
                            taggedUsers: [],
                            owner: user)
        
        let vc = PostViewController(model: post)
        vc.title = post.postType.rawValue
        vc.navigationItem.largeTitleDisplayMode = .never
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        guard kind == UICollectionView.elementKindSectionHeader else {
            // Footer
            return UICollectionReusableView()
        }
        
        if indexPath.section == 1 {
            // Tabs header
            let tabControllerHeader = collectionView.dequeueReusableSupplementaryView(ofKind: kind,
                                                                         withReuseIdentifier: ProfileTabsCollectionReusableView.identifier,
                                                                         for: indexPath) as! ProfileTabsCollectionReusableView
            tabControllerHeader.delegate = self
            return tabControllerHeader
        }
        
        let profileHeader = collectionView.dequeueReusableSupplementaryView(ofKind: kind,
                                                                     withReuseIdentifier: ProfileInfoHeaderCollectionReusableView.identifier,
                                                                     for: indexPath) as! ProfileInfoHeaderCollectionReusableView
        profileHeader.delegate = self
        return profileHeader
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        if section == 0 {
            return CGSize(width: collectionView.width, height: collectionView.height/3)
        }
        // Size of section tabs
        return CGSize(width: collectionView.width,
                      height: 50)
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
}

// MARK: ProfileTabsCollectionReusableViewDelegate
extension ProfileViewController: ProfileTabsCollectionReusableViewDelegate {
    
    func didTapGridButtonTab() {
        // Reload collection view with data
    }
    
    func didTapTaggedButtonTab() {
        // Reload collection view with data
    }
    
    
}










