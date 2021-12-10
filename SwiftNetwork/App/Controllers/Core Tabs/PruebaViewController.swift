//
//  PruebaCollectionViewController.swift
//  SwiftNetwork
//
//  Created by Eddy Donald Chinchay Lujan on 30/9/21.
//

import UIKit

//MARK: PruebaViewController
class PruebaViewController: UIViewController {
    
    let collectionViewTwo = ProfileCollectionsViews.collectionViewTwo()
    
    var email: String = ""
    
    private var models = [Userpost]()
    
    private var user: User?
    
    private var story = [Storyfeatured]()
    
    private let grid = "grid"
    private let tagged = "tagged"
    
    ///var spinner = UIActivityIndicatorView()var VW_overlay: UIView = UIView()
    //MARK: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupRemaningNavItems()
        configureHeader()
        configureCollectionViewTwo()
        configureNavigationBar()
        fetchUserPost()
        configureSpinner()
    }
    
    // MARK: Init
    init(with email: String) {
        super.init(nibName: nil, bundle: nil)
        self.email = email
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    ///viewDidLayoutSubviews
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.collectionViewTwo.frame = view.bounds
        
    }
    
    ///SetupView
    private func setupView() {
        view.backgroundColor = .systemBackground
    }
    
    ///Spinner
    ///Muestra el spiner mientras los datos de van cargando...
    private func setupSpinner()  {
        let spinerView = SpinnerView.shared.setupSpinner()
        spinerView.center = view.center
        SpinnerView.shared.VW_overlay = UIView(frame: UIScreen.main.bounds)
        SpinnerView.shared.VW_overlay.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.3)
        view.addSubview(spinerView)
    }
    
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
    
    /**
     Api Rest.
     En esta función llamamos al Api rest para traes los datos de la DataBase,
     Desde handleNotAuthenticated ontenemos tanto el token como el email del usario que está conectado a la App.
     - Parameter
     */
    private func fetchUserPost() {
        APIService.shared.apiProfile(email: self.email, token: getUserToken()?.token ?? "" ) {(result) in
            switch result {
            case .success(let model):
                model.userpost?.count != 0 ? self.setupModel(with: model.userpost ?? []) : print("Array Userpost está vacio...")
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }

    /**
     Models
     Está función revcibe los datos para tratarlos y guardalos en el array Modelo.
     Recorremos el array del modelo userpost.
     El modelo pintara los datos del user post acorde al email.
     - Parameter model: Recibe el ojeto userpost
     */
    private func setupModel(with model: [Userpost]) {
        for items in model {
            let userpost = Userpost(id: items.id, title: items.title, content: items.content, lat: items.lat, lng: items.lng, startAt: items.startAt, finishAt: items.finishAt, receptorTypeID: items.receptorRefID, authorRefID: items.authorRefID, receptorRefID: items.receptorRefID, posttTypeID: items.posttTypeID, nivelID: items.nivelID, createdAt: items.createdAt, updatedAt: items.updatedAt, idPostType: items.idPostType, comments: items.comments, likes: items.likes, taggeds: items.taggeds, userAuthor: items.userAuthor, postImage: items.postImage, postType: items.postType)
            models.append(userpost)
            
            ///User & Story Featured
            guard let user = items.userAuthor, let story = items.userAuthor?.profile?.storyfeatured else { return }
            self.user = user
            self.story.append(contentsOf: story)
        }
        
        DispatchQueue.main.async {
            CustomLoader.instance.hideLoader()
            self.collectionViewTwo.reloadData()
        }
    }
    
    private func failedToGeProfile() {
        let label = UILabel(frame: .zero)
        label.text = "Failed to load profile."
        label.sizeToFit()
        label.textColor = .secondaryLabel
        view.addSubview(label)
        label.center = view.center
    }
    
    private func setupRemaningNavItems() {
        let followButton = UIButton(type: .system)
        followButton.setTitle("eddylujann", for: .normal)
        followButton.titleLabel?.font = .systemFont(ofSize: 26, weight: .black)
        followButton.tintColor = Constants.Color.black
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: followButton)
        navigationController?.navigationBar.backgroundColor = .white
        navigationController?.navigationBar.isTranslucent = false
    }
    
    private func configureNavigationBar() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "LogOut",style: .done,target: self,action: #selector(didTapSettingsButton))
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
    }
    
    public func getUserToken() -> ResponseTokenBE? {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        guard let token = appDelegate.objUsuarioSesion else {
            return getUserToken()
        }
        return token
    }
    
    ///LogOut
    @objc func didTapSettingsButton() {
        let vc = SettingsViewController()
        vc.title = "Setting"
        navigationController?.pushViewController(vc, animated: true)
    }
}



//MARK: Extensión.
extension PruebaViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 3
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
            return 0 ///Heade
        }
        if section == 1 {
            return 0 ///Heade
        }
        return  models.count ///Collections photos
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let model = models[indexPath.row]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PhotoCollectionViewCell.identifier, for: indexPath) as! PhotoCollectionViewCell
        cell.configure(with: model)
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
                let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind,withReuseIdentifier: ProfileInfoHeaderCollectionReusableView.identifier,for: indexPath) as! ProfileInfoHeaderCollectionReusableView
                if self.user != nil {
                    guard let user = self.user else { return UICollectionReusableView() }
                    header.configureProfile(with: user)
                    header.delegate = self
                }
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
        if section == 0 { ///Header
            return CGSize(width: collectionView.width, height: collectionView.height/2.5)
        }
        if section == 1 { ///Story
            return CGSize(width: collectionView.width, height: 90)
        }
        return CGSize(width: collectionView.width, height: 50) ///Tabs
    }
    
    ///Select o click on photo
    ///Se empuja al PostViewController
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        let model = models[indexPath.row]
        let vc = PostViewController(model: model)
        vc.navigationItem.largeTitleDisplayMode = .never
        navigationController?.pushViewController(vc, animated: true)
        vc.title = "Posts"
    }
}

// MARK: - ProfileInfoHeaderCollectionReusableViewDelegate
extension PruebaViewController: ProfileInfoHeaderCollectionReusableViewDelegate {
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
extension PruebaViewController: ProfileTabsCollectionReusableViewDelegate {
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





/*
protocol SkeletonDisplayable {
    func showSkeleton()
    func hideSkeleton()
}

extension SkeletonDisplayable where Self: UIViewController {
    var skeletonLayerName: String {
        return "skeletonLayerName"
    }

    var skeletonGradientName: String {
        return "skeletonGradientName"
    }

    private func skeletonViews(in view: UIView) -> [UIView] {
        var results = [UIView]()
        for subview in view.subviews as [UIView] {
            switch subview {
            case _ where subview.isKind(of: UILabel.self):
                results += [subview]
            case _ where subview.isKind(of: UIImageView.self):
                results += [subview]
            case _ where subview.isKind(of: UIButton.self):
                results += [subview]
            default: results += skeletonViews(in: subview)
            }

        }
        return results
    }

    func showSkeleton() {
        let skeletons = skeletonViews(in: view)
        let backgroundColor = UIColor(red: 210.0/255.0, green: 210.0/255.0, blue: 210.0/255.0, alpha: 1.0).cgColor
        let highlightColor = UIColor(red: 235.0/255.0, green: 235.0/255.0, blue: 235.0/255.0, alpha: 1.0).cgColor

        let skeletonLayer = CALayer()
        skeletonLayer.backgroundColor = backgroundColor
        skeletonLayer.name = skeletonLayerName
        skeletonLayer.anchorPoint = .zero
        skeletonLayer.frame.size = UIScreen.main.bounds.size

        skeletons.forEach {
            let gradientLayer = CAGradientLayer()
            gradientLayer.colors = [backgroundColor, highlightColor, backgroundColor]
            gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.5)
            gradientLayer.endPoint = CGPoint(x: 1.0, y: 0.5)
            gradientLayer.frame = UIScreen.main.bounds
            gradientLayer.name = skeletonGradientName

            $0.layer.mask = skeletonLayer
            $0.layer.addSublayer(skeletonLayer)
            $0.layer.addSublayer(gradientLayer)
            $0.clipsToBounds = true
            let widht = UIScreen.main.bounds.width

            let animation = CABasicAnimation(keyPath: "transform.translation.x")
            animation.duration = 3
            animation.fromValue = -widht
            animation.toValue = widht
            animation.repeatCount = .infinity
            animation.autoreverses = false
            animation.fillMode = CAMediaTimingFillMode.forwards

            gradientLayer.add(animation, forKey: "gradientLayerShimmerAnimation")
        }
    }

    func hideSkeleton() {
        skeletonViews(in: view).forEach {
            $0.layer.sublayers?.removeAll {
                $0.name == skeletonLayerName || $0.name == skeletonGradientName
            }
        }
    }
}
*/
