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
    
    private var models = [Userpost]()
    
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
            item.contentInsets = NSDirectionalEdgeInsets(top: 2, leading: 5, bottom: 2, trailing: 5)
            let group = NSCollectionLayoutGroup.horizontal(layoutSize: NSCollectionLayoutSize(
                                                            widthDimension: .fractionalWidth(1),heightDimension: .absolute(150)),
                                                           subitem: item,
                                                           count: 3)
            group.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 0, bottom: 10, trailing: 0)
            return NSCollectionLayoutSection(group: group)
    }))
    
    private let dismmeView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.alpha = 0.4
        view.isHidden = true
        return view
    }()
    
    //MARK: viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        configureSpinner()
        configureCollectionViewCell()
        delegateCollections()
        configureSearchBar()
        fetchUserPost()
    }
    
    //MARK: viewDidLayoutSubviews
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        collectionView.frame = view.bounds
        dismmeView.frame = view.bounds
    }
    
    private func setupView() {
        view.addSubview(collectionView)
        view.addSubview(dismmeView)
    }
    
    ///Spinner
    ///Muestra el spiner mientras los datos de van cargando...
    private func configureSpinner() {
        CustomLoader.instance.viewColor = UIColor.systemBackground
        CustomLoader.instance.setAlpha = 0.8
        CustomLoader.instance.gifName = Constants.Spinner.spinner
        showSpinner()
    }
    
    ///Spinner
    ///Muestra el spiner mientras los datos de van cargando...
    private func showSpinner() {
        CustomLoader.instance.showLoader()
    }
    
    ///Api Rest.
    ///Hacemos una llamada al Api rest.
    ///Una vez obtenido los datos que queremos, se lo enviamos a la funcion setuModel.
    private func fetchUserPost() {
        /*APIService.shared.getUserPost(token: handleNotAuthenticated()) {(result) in
            switch result {
            case .success(let model):
                model.userpost?.count != 0 ? self.setupModel(with: model.userpost ?? []) : print("Array Userpost está vacio...")
            case .failure(let error):
                print(error.localizedDescription)
            }
        }*/
    }
    
    ///Models
    ///Está función revcibe los datos para tratarlos y guardalos en el array Modelo.
    private func setupModel(with model: [Userpost] ) {
        for items in model {
            let userpost = Userpost(id: items.id, title: items.title, content: items.content, lat: items.lat, lng: items.lng, startAt: items.startAt, finishAt: items.finishAt, receptorTypeID: items.receptorRefID, authorRefID: items.authorRefID, receptorRefID: items.receptorRefID, posttTypeID: items.posttTypeID, nivelID: items.nivelID, createdAt: items.createdAt, updatedAt: items.updatedAt, idPostType: items.idPostType, comments: items.comments, likes: items.likes, taggeds: items.taggeds, userAuthor: items.userAuthor, postImage: items.postImage, postType: items.postType, storyfeatured: items.storyfeatured )
            models.append(userpost)
        }
        ///Carga el spiner y recarga el collectionViewTwo con los datos.
        DispatchQueue.main.async {
            CustomLoader.instance.hideLoader()
            self.collectionView.reloadData()
        }
    }
    
    ///Autenticated & validate del Token de la sesión del aplicativo.
    private func handleNotAuthenticated() -> String {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let token = appDelegate.objUsuarioSesion?.token
        if token == nil {
            let vc = LoginViewController()
            vc.modalPresentationStyle = .fullScreen
            self.present(vc, animated: false)
        }
        return token ?? "nil"
    }
    
    private func configureDisnmeView() {
        let gesture = UITapGestureRecognizer(target: self, action: #selector(didCancelSearch))
        gesture.numberOfTouchesRequired = 1
        gesture.numberOfTapsRequired = 1
        dismmeView.addGestureRecognizer(gesture)
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
        //searchController.delegate = self
        navigationItem.searchController = searchController
    }
}

//MARK: UISearchResultsUpdating
///Se hace la busqueda por nombre de usuarioi.
///La bsuqueda es online.
extension SearchViewController: UISearchResultsUpdating, UISearchBarDelegate {
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        print("xxxxxx")
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        guard let resultsComtroller = searchController.searchResultsController as? SearchResultViewController,
              let query = searchController.searchBar.text, !query.trimmingCharacters(in: .whitespaces).isEmpty else {
            return
        }
        
        let filter = UserSearchBE()
        filter.name = query
        BCApiRest.search(filter, handleNotAuthenticated(), conCompletionCorrecto: { ( objExplore ) in
            guard let userpost = objExplore.userpost else { return }
            DispatchQueue.main.async {
                resultsComtroller.update(with: userpost)
            }
        }, conCompletionIncorrecto: {(mensajeError) in
            print("mensajeError:\(mensajeError)")
        })
    }
    
    @objc private func didCancelSearch() {
        self.dismmeView.isHidden = true
        print("cancel")
    }
}

//MARK: Collections
extension SearchViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    ///Total Photos
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return models.count  //20
    }
    
    ///We indicate the collections of photo
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        //let model = models[indexPath.row]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PhotoCollectionViewCell.identifier, for: indexPath) as! PhotoCollectionViewCell
        cell.backgroundColor = .systemBackground
        //cell.configure(with: model)
        return cell
    }
    
    ///Selected photo
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        //let model = models[indexPath.row]
        //let vc = PostViewController(model: model)
        //vc.title = "Search"//model.postType.rawValue
        //navigationController?.pushViewController(vc, animated: true)
    }
}
