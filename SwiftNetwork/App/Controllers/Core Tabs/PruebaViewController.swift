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
    
    private let grid = "grid"
    
    private let tagged = "tagged"
    
    private var viewModel = ProfileViewModel()
    
    private var token = Token()
    
    //MARK: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupRemaningNavItems()
        configureHeader()
        configureCollectionViewTwo()
        configureNavigationBar()
        configureSpinner()
        loadProfileData()
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
    
    //MARK: Spinner
    //MARK: Muestra el spiner mientras los datos de van cargando...
    private func showSpinner() {
        CustomLoader.instance.showLoader()
    }
    
    // MARK: Carga los datos del ViewModel
    private func loadProfileData() {
        print(token.getUserToken())
        guard let token = token.getUserToken().token else { return }
        viewModel.fetchProfileData(email: self.email, token: token) { [weak self] in
            self?.collectionViewTwo.dataSource = self
            self?.collectionViewTwo.delegate = self
            DispatchQueue.main.async {
                CustomLoader.instance.hideLoader()
                //self?.collectionViewTwo.reloadData()
            }
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
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            title: "LogOut",
            style: .done,
            target: self,
            action: #selector(didTapSettingsButton))
    }
    
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
    
    private func configureCollectionViewTwo() {
        collectionViewTwo.register(
            PhotoCollectionViewCell.self,
            forCellWithReuseIdentifier: PhotoCollectionViewCell.identifier)
        view.addSubview(collectionViewTwo)
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
    
    //MARK: Count post
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 3
    }
    
    //MARK: Count header & story & photos
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        if section == 0 { return 0 }
        if section == 1 { return 0 }
        return viewModel.numberOfRowsInSection(section: section) 
    }
    
    //MARK: PhotosCollectionsViewCell
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: PhotoCollectionViewCell.identifier,
            for: indexPath) as! PhotoCollectionViewCell
        
        let model = viewModel.cellForRowAt(indexPath: indexPath)
        cell.configure(with: model)
        return cell
    }
    
    //MARK: Height PhotosCollectionsViewCell
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize( width: ( view.frame.width / 3 )-1 , height: 150 )
    }
    
    //MARK: UIEdgeInsets PhotosCollectionsViewCell
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets( top: 10, left: 0, bottom: 10, right: 0 )
    }
    
    //MARK: SupplementaryElementOfKind
    //MARK: Header & Story & Tabs
    func collectionView(_ collectionView: UICollectionView,
                        viewForSupplementaryElementOfKind kind: String,
                        at indexPath: IndexPath) -> UICollectionReusableView {
        
        guard kind == UICollectionView.elementKindSectionHeader else { return UICollectionReusableView() }
        switch indexPath.section {
        case 0:
            let header = collectionView.dequeueReusableSupplementaryView(
                ofKind: kind,
                withReuseIdentifier: ProfileInfoHeaderCollectionReusableView.identifier,
                for: indexPath) as! ProfileInfoHeaderCollectionReusableView
            
            guard let user = viewModel.fetchUsername(indexPath: indexPath) else { return UICollectionReusableView() }
            header.configureProfile(with: user)
            header.delegate = self
            return header
        
        case 1:
            let storyHeader = collectionView.dequeueReusableSupplementaryView(
                ofKind: kind,
                withReuseIdentifier: StoryFeaturedCollectionTableViewCell.identifier,
                for: indexPath) as! StoryFeaturedCollectionTableViewCell
            return storyHeader
            
        case 2:
            let tabsHeader = collectionView.dequeueReusableSupplementaryView(
                ofKind: kind,
                withReuseIdentifier: ProfileTabsCollectionReusableView.identifier,
                for: indexPath) as! ProfileTabsCollectionReusableView
            tabsHeader.delegate = self
                return tabsHeader
            
        default: fatalError()
        }
    }
    
    //MARK: Collection Header
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        referenceSizeForHeaderInSection section: Int) -> CGSize {
        // Header & Story & Tabs
        if section == 0 { return CGSize(width: collectionView.width, height: collectionView.height/2.5) }
        if section == 1 { return CGSize(width: collectionView.width, height: 90) }
        return CGSize(width: collectionView.width, height: 50)
    }
    
    //MARK: Select or click on photo
    //MARK: Push PostViewController
    func collectionView(_ collectionView: UICollectionView,
                        didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        let model = viewModel.cellForRowAt(indexPath: indexPath)
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
