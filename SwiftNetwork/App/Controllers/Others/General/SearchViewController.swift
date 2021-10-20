//
//  SearchViewController.swift
//  Blubinn
//
//  Created by Eddy Donald Chinchay Lujan on 31/3/21.
//

import UIKit

enum Searchçresult {
    case artis(model:String)
    case album(model:String)
}

class SearchViewController: UIViewController {
    
    private var models = [UserpostViewModel]()
    
    private let searchController: UISearchController = {
        let searchController = UISearchController(searchResultsController: SearchResultViewController())
        searchController.searchBar.placeholder = "Song, Artists, Albums"
        searchController.searchBar.searchBarStyle = .minimal
        searchController.definesPresentationContext = true
        return searchController
    }()
    
    private let collectionView: UICollectionView = UICollectionView(
        frame: .zero,
        collectionViewLayout: UICollectionViewCompositionalLayout(sectionProvider: { (_, _) -> NSCollectionLayoutSection? in
            let item = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1)))
            item.contentInsets = NSDirectionalEdgeInsets(
                top: 2,
                leading: 5,
                bottom: 2,
                trailing: 5)
            
            let group = NSCollectionLayoutGroup.horizontal(
                layoutSize: NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(1),
                    heightDimension: .absolute(150)),
                subitem: item,
                count: 3)
            
            group.contentInsets = NSDirectionalEdgeInsets(
                top: 10,
                leading: 0,
                bottom: 10,
                trailing: 0)
            return NSCollectionLayoutSection(group: group)
    }))
    
    private let dismmeView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.alpha = 0.4
        view.isHidden = true
        return view
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        configureCollectionViewCell()
        delegateCollections()
        configureSearchBar()
        //setupModel()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        collectionView.frame = view.bounds
        dismmeView.frame = view.bounds
    }
    
    private func setupView() {
        view.addSubview(collectionView)
        view.addSubview(dismmeView)
    }
    
    private func configureDisnmeView() {
        let gesture = UITapGestureRecognizer(target: self, action: #selector(didCancelSearch))
        gesture.numberOfTouchesRequired = 1
        gesture.numberOfTapsRequired = 1
        dismmeView.addGestureRecognizer(gesture)
    }
    
    private func getTokenLocal() -> String {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let token = appDelegate.objUsuarioSesion?.token
        return token!
    }
    
    private func configureCollectionViewCell() {
        collectionView.register(PhotoCollectionViewCell.self, forCellWithReuseIdentifier: PhotoCollectionViewCell.identifier)
        collectionView.backgroundColor = .systemBackground
    }
    
    private func delegateCollections() {
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    private func configureSearchBar() {
        searchController.searchResultsUpdater = self
        navigationItem.searchController = searchController
    }
}

//MARK: UISearchResultsUpdating
extension SearchViewController: UISearchResultsUpdating, UISearchBarDelegate {
   
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        print("xxxxxx")
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        guard let resultsComtroller = searchController.searchResultsController as? SearchResultViewController,
              let query = searchController.searchBar.text,
              !query.trimmingCharacters(in: .whitespaces).isEmpty else {
            return
        }
        
        let filter = UserSearchBE()
        filter.name = query
        SearchBC.search(filter, getTokenLocal(), conCompletionCorrecto: { (obj) in
            DispatchQueue.main.async {
                resultsComtroller.update(with: obj)
            }
        } , conCompletionIncorrecto: {(mensajeError) in
            print("mensajeError:\(mensajeError)")
        })
    }
    
    @objc private func didCancelSearch() {
        print("cancel")
        self.dismmeView.isHidden = true
       
    }
}

//MARK: Collections
extension SearchViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    ///
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    ///Total Photos
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return models.count  //20
    }
    
    ///We indicate the collections of photo
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let model = models[indexPath.row]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PhotoCollectionViewCell.identifier, for: indexPath) as! PhotoCollectionViewCell
        cell.backgroundColor = .systemBackground
        //cell.configure(with: model)
        return cell
    }
    
    ///Selected photo
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        let model = models[indexPath.row]
        //let vc = PostViewController(model: model)
        //vc.title = model.postType.rawValue
        //navigationController?.pushViewController(vc, animated: true)
    }
}


//MARK: Mocks
/*
extension SearchViewController {
    private func setupModel() {
        
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
                counts: CountViewModel(followers: 1, following: 1, posts: 1),
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
            
            let post = UserpostViewModel(
                identifier: "",
                postType: .photo,
                thumbnailImage: URL(
                    string: "http://127.0.0.1:8000/storage/app-new-publish/EddyLujan/images/img\(i+1).jpeg")!,
                postURL: URL(string: "https://wwww.google.com")!,
                caption: nil,
                likeCount: [],
                comments: [],
                createDate: Date(),
                taggedUsers: [],
                owner: user)
            
            models.append(post)
        }
    }
}
*/
