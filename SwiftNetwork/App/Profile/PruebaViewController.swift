//
//  PruebaCollectionViewController.swift
//  SwiftNetwork
//
//  Created by Eddy Donald Chinchay Lujan on 30/9/21.
//

import UIKit

//MARK: PruebaViewController
class PruebaViewController: UIViewController {
    
    //MARK: ViewModel
    private var viewModel = ProfileViewModel()
    
    //MARK: Adapter
    var adapter : ProfileAdapter!
    
    let collectionViewTwo = ProfileCollectionsViews.collectionViewTwo()
    
    var email: String = ""
    
    private var token = Token()
    
    var activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView()
    
    
    // MARK: - Init
    init(with email: String) {
        super.init(nibName: nil, bundle: nil)
        self.email = email
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupProtocol()
        setupRemaningNavItems()
        configureHeader()
        configureCollectionViewTwo()
        configureNavigationBar()
        initViewModel()
        configureSpinner()
    }
    

    // ViewDidLayoutSubviews
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.collectionViewTwo.frame = view.bounds
    }
    
    // SetupView
    private func setupView() {
        view.backgroundColor = .systemBackground
    }
    
    // Protocols
    private func setupProtocol() {
        adapter = ProfileAdapter(delegate: self, delegateHeader: self)
    }
    
    
    // MARK: Carga los datos del ViewModel
    private func initViewModel() {
        
        guard let token = token.getUserToken().token else {
            return
        }
        
        // Setup for reloadTableViewClosure
        viewModel.reloadTableViewClosure = { [weak self] () in
            self?.collectionViewTwo.dataSource  = self?.adapter
            self?.collectionViewTwo.delegate    = self?.adapter
            DispatchQueue.main.async {
                self?.collectionViewTwo.reloadData()
            }
        }
        
        // Setup for updateLoadingStatusClosure
        viewModel.updateLoadingStatusClosure = { [weak self] () in
            //DispatchQueue.main.async {
            DispatchQueue.main.asyncAfter(deadline: .now()+4) {
                let isLoading = self?.viewModel.isLoading ?? false
                if isLoading {
                    self?.activityIndicator.startAnimating()
                    UIView.animate(withDuration: 0.2, animations:  {
                        self?.collectionViewTwo.alpha = 0.0
                    })
                } else {
                    self?.activityIndicator.stopAnimating()
                    UIView.animate(withDuration: 0.2, animations: {
                        self?.collectionViewTwo.alpha = 1.0
                    })
                }
            }
        }
        viewModel.fetchData(email: self.email, token: token)
    }
    
    // UIActivityIndicatorView
    private func configureSpinner() {
        activityIndicator.center = view.center
        activityIndicator.hidesWhenStopped = false
        view.addSubview(activityIndicator)
    }
    
    // Item Nav
    private func setupRemaningNavItems() {
        let followButton = UIButton(type: .system)
        followButton.setTitle("eddylujann", for: .normal)
        followButton.titleLabel?.font = .systemFont(ofSize: 26, weight: .black)
        followButton.tintColor = Constants.Color.black
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: followButton)
        navigationController?.navigationBar.backgroundColor = .white
        navigationController?.navigationBar.isTranslucent = false
    }
    
    // Navigations Bar
    private func configureNavigationBar() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            title: "LogOut",
            style: .done,
            target: self,
            action: #selector(didTapSettingsButton))
    }
    
    // Header
    private func configureHeader() {
        collectionViewTwo.register(
            StoryFeaturedCollectionTableViewCell.self,
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
            withReuseIdentifier: StoryFeaturedCollectionTableViewCell.identifier)
        
        collectionViewTwo.register(
            ProfileInfoHeaderCollectionReusableView.self,
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
            withReuseIdentifier: ProfileInfoHeaderCollectionReusableView.identifier)
        
        collectionViewTwo.register(
            ProfileTabsCollectionReusableView.self,
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
            withReuseIdentifier: ProfileTabsCollectionReusableView.identifier)
    }
    
    // Collection
    private func configureCollectionViewTwo() {
        collectionViewTwo.register(
            PhotoCollectionViewCell.self,
            forCellWithReuseIdentifier: PhotoCollectionViewCell.identifier)
        view.addSubview(collectionViewTwo)
    }
    
    // Button Close session
    @objc func didTapSettingsButton() {
        let vc = SettingsViewController()
        vc.title = "Setting"
        navigationController?.pushViewController(vc, animated: true)
    }
}



// MARK: - ProfileProtocol
// MARK: Se Pide Datos al ViewModel para enviarselo al Adapter.
// MARK: ViewController -> ViewModel
// MARK: ViewController -> ProfileAdapter
extension PruebaViewController: ProfileProtocol {
    
    func retrieveNumberOfSections() -> Int {
        return viewModel.numberOfSections()
    }
    
    func retrieveNumberOfRowsInSection(section: Int) -> Int {
        return viewModel.numberOfRowsInSection(section: section)
    }
    
    func getData(indexPath: IndexPath) -> Userpost {
        return viewModel.cellForRowAt(indexPath: indexPath)
    }
    
    func retrieveSizeForItemAt() -> CGSize {
        return CGSize(width:(view.frame.width/3)-1, height: 150)
    }
    
    func retrieveInsetForSectionAt() -> UIEdgeInsets {
        return UIEdgeInsets(top: 10, left: 0, bottom: 10, right: 0)
    }
    
    func getUserData(indexPath: IndexPath) -> User? {
        return viewModel.fetchUsername(indexPath: indexPath)
    }
    
    func itemSelected(indexPath: IndexPath) {
        let model = viewModel.cellForRowAt(indexPath: indexPath)
        let vc = PostViewController(model: model)
        vc.navigationItem.largeTitleDisplayMode = .never
        navigationController?.pushViewController(vc, animated: true)
        vc.title = "Posts"
    }
}



// MARK: - ProfileReusableViewProtocol
extension PruebaViewController: ProfileReusableViewProtocol {
    
    func didTapPostButton(_header: ProfileInfoHeaderCollectionReusableView) {
       self.collectionViewTwo.scrollToItem(
        at: IndexPath(row: 0,
                      section: 1),
        at: .top, animated: true)
    }
    
    func didTapFollowersButton(_header: ProfileInfoHeaderCollectionReusableView) {
        var mockData = [UserRelationship]()
        for x in 0..<10 {
            mockData.append(UserRelationship(
                username: "@joer",
                namm: "Joe Smith",
                type: x % 2 == 0 ? .following: .not_following))
        }
        let vc = ListViewController(data: mockData)
        vc.title = "Follower"
        vc.navigationItem.largeTitleDisplayMode = .never
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func didTapFollowingButton(_header: ProfileInfoHeaderCollectionReusableView) {
        var mockData = [UserRelationship]()
        for x in 0..<10 {
            mockData.append(UserRelationship(
                username: "@joer",
                namm: "Joe Smith",
                type: x % 2 == 0 ? .following: .not_following))
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



// MARK: - Tabs Protocols ProfileTabsCollectionReusableViewDelegate
// extension PruebaViewController: ProfileTabsCollectionReusableViewDelegate {}
