//
//  ExploreViewController.swift
//  Blubinn
//
//  Created by Eddy Donald Chinchay Lujan on 13/4/21.
//

import UIKit

class ExplorerViewController: UIViewController {
    
    private let searchBar: UISearchBar = {
       let searchBar = UISearchBar()
        searchBar.backgroundColor =  .secondarySystemBackground
        searchBar.placeholder = "Search"
        return searchBar
    }()
    
    private var models = [UserPost]()
    
    private var collectionView: UICollectionView?
    
    private var tabbdSearchCollectionsView: UICollectionView?
    
    private let dismmeView: UIView = {
        let view = UIView()
        view.backgroundColor = .black
        view.alpha = 0.4
        view.isHidden = true
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        configureSearchBar()
        configureExploreCollection()
        configureDimmedView()
        configureTabbedSearch()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        collectionView?.frame = view.bounds
        dismmeView.frame = view.bounds
        tabbdSearchCollectionsView?.frame = CGRect(x: 0,
                                                   y: view.safeAreaInsets.top,
                                                   width: view.width,
                                                   height: 72)
    }
    
    private func setupView() {
        title = "Explore"
        view.backgroundColor = .systemBackground
    }
    
    private func configureExploreCollection() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.itemSize = CGSize(width: (view.width-4)/3, height: (view.width-4)/3)
        layout.minimumLineSpacing = 1
        layout.minimumInteritemSpacing = 1
        navigationController?.navigationBar.topItem?.titleView = searchBar
        
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        
        collectionView?.register(PhotoCollectionViewCell.self, forCellWithReuseIdentifier: PhotoCollectionViewCell.identifier)
        
        collectionView?.delegate = self
        collectionView?.dataSource = self
        
        guard let collectionView = collectionView else {
            return
        }
        view.addSubview(collectionView)
    }
    
    private func configureSearchBar() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.itemSize = CGSize(width: (view.width-4)/3, height: (view.width-4)/3)
        layout.minimumLineSpacing = 1
        layout.minimumInteritemSpacing = 1
        navigationController?.navigationBar.topItem?.titleView = searchBar
        
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        
        collectionView?.register(PhotoCollectionViewCell.self, forCellWithReuseIdentifier: PhotoCollectionViewCell.identifier)
        
        collectionView?.delegate = self
        collectionView?.dataSource = self
        
        guard let collectionView = collectionView else {
            return
        }
        view.addSubview(collectionView)
        searchBar.delegate = self
    
        view.addSubview(dismmeView)
        let gesture = UITapGestureRecognizer(target: self, action: #selector(didCancelSearch))
        gesture.numberOfTouchesRequired = 1
        gesture.numberOfTapsRequired = 1
        dismmeView.addGestureRecognizer(gesture)
    }
    
    private func configureTabbedSearch() {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: view.width/3, height: 52)
        layout.scrollDirection = .horizontal
        tabbdSearchCollectionsView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        
        tabbdSearchCollectionsView?.backgroundColor = .yellow
        tabbdSearchCollectionsView?.isHidden = true
        
        guard let tabbdSearchCollectionsView = tabbdSearchCollectionsView else {
            return
        }
        tabbdSearchCollectionsView.delegate = self
        tabbdSearchCollectionsView.dataSource = self
        view.addSubview(tabbdSearchCollectionsView)
    }
    
    private func configureDimmedView() {
        view.addSubview(dismmeView)
        let gesture = UITapGestureRecognizer(target: self, action: #selector(didCancelSearch))
        gesture.numberOfTouchesRequired = 1
        gesture.numberOfTapsRequired = 1
        dismmeView.addGestureRecognizer(gesture)
    }
}

extension ExplorerViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        guard let text = searchBar.text, !text.isEmpty else {
            return
        }
        query(text)
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            title: "Cancel",
            style: .plain,
            target: self,
            action: #selector(didCancelSearch)
        )
        
        dismmeView.isHidden = false
        UIView.animate(withDuration: 0.2, animations: {
            self.dismmeView.alpha = 0.4
        }) { done in
            if done {
                self.tabbdSearchCollectionsView?.isHidden = false
            }
        }
    }
    
    @objc private func didCancelSearch() {
        searchBar.resignFirstResponder()
        navigationItem.rightBarButtonItem = nil
        self.tabbdSearchCollectionsView?.isHidden = true
        UIView.animate(withDuration: 0.2, animations: {
            self.dismmeView.alpha = 0
        }) { done in
            if done {
                self.dismmeView.isHidden = true
            }
        }
    }
    
    private func query(_ text: String) {
        // perform the search in the back end
    }
}


extension ExplorerViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == tabbdSearchCollectionsView {
            return 0
        }
        
        return 100
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        //return UICollectionViewCell()
        
        if collectionView == tabbdSearchCollectionsView {
            return UICollectionViewCell()
        }
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PhotoCollectionViewCell.identifier,
                                                            for: indexPath) as? PhotoCollectionViewCell else {
            return UICollectionViewCell()
        }
        //cell.configure(with: )
        //cell.configure(debug: "test")
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        
        if collectionView == tabbdSearchCollectionsView {
            // change search context
            return
        }
        
        //let model = models[indexPath.row]
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
        navigationController?.pushViewController(vc, animated: true)
    }
    
    
}
