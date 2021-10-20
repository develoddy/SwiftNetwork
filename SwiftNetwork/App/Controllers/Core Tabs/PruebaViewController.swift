//
//  PruebaCollectionViewController.swift
//  SwiftNetwork
//
//  Created by Eddy Donald Chinchay Lujan on 30/9/21.
//

import UIKit
import SDWebImage

class PruebaViewController: UIViewController {
    
    let collectionViewTwo = ProfileCollectionsViews.collectionViewTwo()
    
    let collectionViewTwoIdentifier = "collectionViewTwoIdentifier"
    
    private var models = [UserpostViewModel]()
    
    private let grid = "grid"
    private let tagged = "tagged"
    
    //MARK: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        configureHeader()
        configureCollectionViewTwo()
        setupRemaningNavItems()
        configureNavigationBar()
        fetchUserPost(tabs: grid)
        ///doTestUserPost()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.collectionViewTwo.frame = view.bounds
    }
    
    private func setupView() {
        view.backgroundColor = .systemBackground
    }
    
    /// Test api rest
    private func doTestUserPost() {
        /*APIServiceLocal.shared.parseUserPostJSON { (model) in
            self.updateUI(with: model.userpost ?? [])
            self.collectionViewTwo.reloadData()
        }*/
    }
    
    /// Aall the api rest
    private func fetchUserPost(tabs: String) {
        /*APIService.shared.apiToGetUserPostViewModelData(token: handleNotAuthenticated(), tabs: tabs) { (result) in
            switch result {
            case .success(let model):
                self.updateUI(with: model.userpost ?? [])
            case .failure(let error):
                print(error.localizedDescription)
                self.failedToGeProfile()
            }
        }*/
        ///Lllamar a los otros metodos que faltan...
    }
    
   /* private func updateUI(with model: [Userpost]) {
        for items in model {
            let userViewModel = UserViewModel(name: items.owner?.user?.name, last: items.owner?.user?.last, username: items.owner?.user?.username, bio: items.owner?.user?.bio, profilePicture: URL(string:  items.owner?.user?.profilePicture ?? ""), dayOfBirth: Date(), gender:  GenderViewModel(gender: "male"), publicEmail: items.owner?.user?.publicEmail, counts: UserCountViewModel(followers: 1, following: 1, posts: 1), joinDate: Date(), countryId: 0, image: items.owner?.user?.image, imageHeader: items.owner?.user?.imageHeader, title: items.owner?.user?.title, likes: items.owner?.user?.likes, dislikes: items.owner?.user?.dislikes, address: items.owner?.user?.address, phone: items.owner?.user?.phone, userssId: 0, nivelId: 0, sentimentalId: 0, imagenBin: items.owner?.user?.imagenBin, valor: items.owner?.user?.valor, id: 0)
            
            models.append(UserPostViewModel(identifier: items.identifier ?? "", postType: .photo, thumbnailImage: URL(string: items.thumbnailImage!)!, postURL: URL(string: items.thumbnailImage!)!, caption: items.caption, likeCount: [], comments: [], createDate: Date(), taggedUsers: [], owner: userViewModel))
        }
        collectionViewTwo.reloadData()
    }
    */
    
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
    
    ///LogOut
    @objc func didTapSettingsButton() {
        let vc = SettingsViewController()
        vc.title = "Setting"
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension PruebaViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 3
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 { ///Header
            return 0
        }
        if section == 1 {
            return 0
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
        
        if indexPath.section == 1 {
            let storyHeader = collectionView.dequeueReusableSupplementaryView(ofKind: kind,withReuseIdentifier: StoryFeaturedCollectionTableViewCell.identifier,for: indexPath) as! StoryFeaturedCollectionTableViewCell
            return storyHeader
        }
        
        if indexPath.section == 2 {
            let tabsHeader = collectionView.dequeueReusableSupplementaryView(ofKind: kind,withReuseIdentifier: ProfileTabsCollectionReusableView.identifier,for: indexPath) as! ProfileTabsCollectionReusableView
            tabsHeader.delegate = self
            return tabsHeader
        }
        
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind,withReuseIdentifier: ProfileInfoHeaderCollectionReusableView.identifier,for: indexPath) as! ProfileInfoHeaderCollectionReusableView
        ///let model = models[indexPath.row]
        ///header.configure(model: model)
        header.delegate = self
        return header
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        if section == 0 { ///Header
            return CGSize(width: collectionView.width, height: collectionView.height/2.5)
        }
        
        if section == 1 { ///Story
            return CGSize(width: collectionView.width, height: 90)
        }
        ///Tabs
        return CGSize(width: collectionView.width, height: 50)
    }
    
    ///Select o click on photo
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        ///get the model and open post controller
        let model = models[indexPath.row]
        //let vc = PostViewController(model: model)
        //vc.navigationItem.largeTitleDisplayMode = .never
        //navigationController?.pushViewController(vc, animated: true)
        //vc.title = "Posts" ///model.postType.rawValue
    }
}

// MARK: - ProfileInfoHeaderCollectionReusableViewDelegate
extension PruebaViewController: ProfileInfoHeaderCollectionReusableViewDelegate {
    func profileHeaderDidTapPostButton(_header: ProfileInfoHeaderCollectionReusableView) {
        ///Scroll to the posts
        self.collectionViewTwo.scrollToItem(at: IndexPath(row: 0, section: 1), at: .top, animated: true)
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
        self.fetchUserPost(tabs: self.grid)
        models = [UserpostViewModel]()
        collectionViewTwo.reloadData()
    }
    
    func didTapTaggedButtonTab() {
        print("didTapTaggedButtonTab")
        //Reload collection view with data
        self.fetchUserPost(tabs: self.tagged)
        models = [UserpostViewModel]()
        collectionViewTwo.reloadData()
    }
}














//class PruebaViewController: UIViewController {
//
//    private var countPhotos: CGFloat = 0.0
//
//    private let tableView: UITableView = {
//        let tableView = UITableView.init(frame: .zero)
//        tableView.estimatedRowHeight = 44
//        tableView.rowHeight = UITableView.automaticDimension
//        return tableView
//    }()
//
//    private var userPostViewModel: IReqResponseUserPost?
//
//    // MARK: ViewDidLoad
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        setupView()
//        headerTableView()
//        delegatesTableView()
//        constraintsTableView()
//        registerTableView()
//        setupRemaningNavItems()
//        configureNavigationBar()
//        //setupModel(tabs: "grid")
//        callAppiPrueba()
//    }
//
//
//    private func callAppiPrueba() {
//        APIServiceLocal.shared.parseUserPostJSON { (result) in
//            self.userPostViewModel = result
//            //print(self.userPostViewModel)
//        }
//    }
//
//
//    override func viewDidLayoutSubviews() {
//        super.viewDidLayoutSubviews()
//        tableView.frame = view.bounds
//    }
//
//    private func headerTableView() {
//        tableView.tableHeaderView = createTableHeaderView()
//    }
//
//    private func setupView() {
//        view.addSubview(tableView)
//        tableView.backgroundColor = .systemBackground
//        tableView.separatorStyle = .none
//    }
//
//    /**private func handleNotAuthenticated() -> String {
//        let appDelegate = UIApplication.shared.delegate as! AppDelegate
//        let token = appDelegate.objUsuarioSesion?.token
//
//        if token == nil {
//            let vc = LoginViewController()
//            vc.modalPresentationStyle = .fullScreen
//            self.present(vc, animated: false)
//        }
//        return token!
//    }*/
//
//    private func registerTableView() {
//        tableView.register(StoryFeaturedCollectionTableViewCell.self, forCellReuseIdentifier: StoryFeaturedCollectionTableViewCell.identifier)
//        tableView.register(TabsTableViewCell.self, forCellReuseIdentifier: TabsTableViewCell.identifier)
//        tableView.register(PhotosCollectionTableViewCell.self, forCellReuseIdentifier: PhotosCollectionTableViewCell.identifier)
//    }
//
//    private func constraintsTableView() {
//        tableView.translatesAutoresizingMaskIntoConstraints = false
//        NSLayoutConstraint.activate([
//            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
//            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
//            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
//            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
//        ])
//        DispatchQueue.main.async{
//            self.tableView.reloadData()
//        }
//    }
//
//    private func delegatesTableView() {
//        tableView.delegate = self
//        tableView.dataSource = self
//    }
//
//    private func configureNavigationBar() {
//        navigationItem.rightBarButtonItem = UIBarButtonItem(
//            title: "LogOut",
//            style: .done,
//            target: self,
//            action: #selector(didTapSettingsButton))
//    }
//
//    @objc func didTapSettingsButton() {
//        let vc = SettingsViewController()
//        vc.title = "Setting"
//        navigationController?.pushViewController(vc, animated: true)
//    }
//}
//
////MARK: Delgates & Datasource
//extension PruebaViewController: UITableViewDataSource {
//
//    private func createTableHeaderView() -> UIView {
//        ///Profile image
//        let profilePhotoImageView : UIImageView = {
//            let imageView = UIImageView(image: UIImage(named: "eddy"))
//            imageView.tintColor = .black
//            imageView.layer.masksToBounds = true
//            imageView.layer.borderWidth = 2.5
//            imageView.layer.borderColor = UIColor.white.cgColor
//            return imageView
//        }()
//        ///Username
//        let usernameLabel : UIButton = {
//            let button = UIButton()
//            button.setTitle("@eddylujann", for: .normal)
//            button.setTitleColor(.darkGray, for: .normal)
//            button.contentHorizontalAlignment = .center
//            button.setImage(UIImage(systemName: "checkmark.seal.fill"), for: .normal)
//            button.semanticContentAttribute = .forceRightToLeft
//            button.titleLabel?.font = .systemFont(ofSize: 14, weight: .semibold)
//            return button
//        }()
//        ///PostButton
//        let postButton : UIButton = {
//            let button = UIButton()
//            button.titleLabel?.font = .systemFont(ofSize: 14, weight: .thin)
//            button.titleLabel?.textAlignment = .center
//            button.backgroundColor = .systemBackground
//            button.setTitleColor(.label, for: .normal)
//            return button
//        }()
//        ///Followers
//        let followersButton : UIButton = {
//            let button = UIButton()
//            button.titleLabel?.font = .systemFont(ofSize: 14, weight: .thin)
//            button.titleLabel?.textAlignment = .center
//            button.backgroundColor = .systemBackground
//            button.setTitleColor(.label, for: .normal)
//            return button
//        }()
//        ///Following
//        let followingButton : UIButton = {
//            let button = UIButton()
//            button.titleLabel?.font = .systemFont(ofSize: 14, weight: .thin)
//            button.titleLabel?.textAlignment = .center
//            button.backgroundColor = .systemBackground
//            button.setTitleColor(.label, for: .normal)
//            return button
//        }()
//        ///Bio
//        let bioLabel : UILabel = {
//            let label = UILabel()
//            label.backgroundColor = .systemBackground
//            label.font = .systemFont(ofSize: 14, weight: .regular)
//            label.text = "Life style is muy one bio \n#madrid"
//            label.lineBreakMode = .byWordWrapping
//            label.numberOfLines = 3
//            return label
//        }()
//        ///Edit profile
//        let editProfileButton : UIButton = {
//            let button = UIButton()
//            button.setTitle("Editar tu perfil", for: .normal)
//            button.setImage(UIImage(systemName: "square.and.pencil"), for: .normal)
//            button.tintColor = .white
//            button.setTitleColor(.white, for: .normal)
//            button.titleLabel?.font = .systemFont(ofSize: 16, weight: .bold)
//            button.backgroundColor = .systemBlue
//            button.layer.cornerRadius = 26
//            return button
//        }()
//
//        ///Calcular la altura del header em base a los componentes.
//        let profilePhotoSize = view.width/4
//
//        let usernameLabelSize = usernameLabel.sizeThatFits(view.frame.size)
//        let usernameHeiht = usernameLabelSize.height
//
//        let buttonHeight = profilePhotoSize/2
//
//        let bioLabelSize = bioLabel.sizeThatFits(view.frame.size)
//        let bioHeight = bioLabelSize.height
//
//        ///Header
//        let heightHeader = CGFloat(profilePhotoSize + usernameHeiht + (buttonHeight*2) + bioHeight)*1.2
//        let header = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: heightHeader)) //view.height/2.7
//
//        ///Frames
//        profilePhotoImageView.frame = CGRect(
//            x: header.width/2.7,
//            y: 10,
//            width: profilePhotoSize,
//            height: profilePhotoSize).integral
//        profilePhotoImageView.layer.cornerRadius = profilePhotoSize/2.0
//
//        usernameLabel.frame = CGRect(
//            x: 5,
//            y: profilePhotoImageView.bottom+5,
//            width: view.width-10,
//            height: usernameLabelSize.height).integral
//
//        let countButtonWidth = (view.width)/3
//        ///Post
//        postButton.frame = CGRect(
//            x: 5,
//            y: usernameLabel.bottom+5,
//            width: countButtonWidth,
//            height: buttonHeight
//        ).integral
//        self.addTextOnPostButton(postButton: postButton)
//
//        ///Followers
//        followersButton.frame = CGRect(
//            x: postButton.right,
//            y: usernameLabel.bottom+5,
//            width: countButtonWidth,
//            height: buttonHeight
//        ).integral
//        self.addTextOnFollowersButton(followersButton: followersButton)
//
//        ///Following
//        followingButton.frame = CGRect(
//            x: followersButton.right,
//            y: usernameLabel.bottom+5,
//            width: countButtonWidth,
//            height: buttonHeight
//        ).integral
//        self.addTextOnFollowingButton(followingButton: followingButton)
//        ///Bio
//        let bioLabelSizeWidth = (view.width-10)/1
//        bioLabel.frame = CGRect(
//            x: 10,
//            y: followingButton.bottom+5,
//            width: bioLabelSizeWidth ,
//            height: bioLabelSize.height)
//
//        ///Edit Profile
//        editProfileButton.frame = CGRect(
//            x: 10,
//            y: bioLabel.bottom+10,
//            width: (countButtonWidth*3)-20,
//            height: buttonHeight).integral
//
//        postButton.addTarget(self, action: #selector(didTapPostButton), for: .touchUpInside)
//        followersButton.addTarget(self, action: #selector(didTapFollowersButton), for: .touchUpInside)
//        followingButton.addTarget(self, action: #selector(didTapFollowingButton), for: .touchUpInside)
//        editProfileButton.addTarget(self, action: #selector(didTapEditProfileButton), for: .touchUpInside)
//
//        header.addSubview(profilePhotoImageView)
//        header.addSubview(usernameLabel)
//        header.addSubview(postButton)
//        header.addSubview(followersButton)
//        header.addSubview(followingButton)
//        header.addSubview(bioLabel)
//        header.addSubview(editProfileButton)
//        return header
//    }
//
//    func numberOfSections(in tableView: UITableView) -> Int {
//        //Se pinta los 3 elementos
//        ///Photos
//        ///Tabs
//        ///Story
//        return 3 ///return userPostViewModel?.userpost!.count ?? 0
//    }
//
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        if section == 2 { /// Photos
//            return 1 ///return userPostViewModel?.userpost!.count ?? 0
//        } else if section == 1 { /// Tabs
//            return 1
//        }
//        return 1  ///Story
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//
//        ///let model = userPostViewModel?.userpost![indexPath.section]
//
//        if indexPath.section == 2 {
//            let cell = tableView.dequeueReusableCell(withIdentifier: PhotosCollectionTableViewCell.identifier, for: indexPath) as! PhotosCollectionTableViewCell
//            countPhotos = cell.photos()
//            return cell
//        } else if indexPath.section == 1 {
//            let cell = tableView.dequeueReusableCell(withIdentifier: TabsTableViewCell.identifier, for: indexPath) as! TabsTableViewCell
//            return cell
//        }
//        let cell = tableView.dequeueReusableCell(withIdentifier: StoryFeaturedCollectionTableViewCell.identifier, for: indexPath) as! StoryFeaturedCollectionTableViewCell
//        return cell
//    }
//
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        if indexPath.section == 2 { /// Photos
//            let row = self.countPhotos/3
//            return CGFloat(150 * (row.rounded(.up)))
//        } else if indexPath.section == 1 { /// Tabs
//            return 50
//        }
//        return 120 ///Story
//    }
//}
//
//extension PruebaViewController: UITableViewDelegate {
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        tableView.deselectRow(at: indexPath, animated: true)
//    }
//}
//
////MARK: Buttons
//extension PruebaViewController {
//    private func addTextOnPostButton(postButton:UIButton) {
//        postButton.titleLabel?.lineBreakMode = NSLineBreakMode.byWordWrapping
//        let buttonText: NSString = "10\nPublicaciones"
//        let newlineRange: NSRange = buttonText.range(of: "\n")
//        var substring1 = ""
//        var substring2 = ""
//
//        if(newlineRange.location != NSNotFound) {
//            substring1 = buttonText.substring(to: newlineRange.location)
//            substring2 = buttonText.substring(from: newlineRange.location)
//        }
//
//        let font1: UIFont = UIFont(name: "HelveticaNeue-Bold", size: 17.0)!
//        ///label.font = UIFont.boldSystemFont(ofSize: 16.0)
//        let attributes1 = [NSMutableAttributedString.Key.font: font1]
//        let attrString1 = NSMutableAttributedString(string: substring1, attributes: attributes1)
//
//        let font2: UIFont = UIFont(name: "Arial", size: 14.0)!
//        let attributes2 = [NSMutableAttributedString.Key.font: font2]
//        let attrString2 = NSMutableAttributedString(string: substring2, attributes: attributes2)
//
//        //appending both attributed strings
//        attrString1.append(attrString2)
//        postButton.setAttributedTitle(attrString1, for: [])
//    }
//
//    private func addTextOnFollowersButton(followersButton:UIButton) {
//        followersButton.titleLabel?.lineBreakMode = NSLineBreakMode.byWordWrapping
//        let buttonText: NSString = "105 mil\nSeguidor"
//        let newlineRange: NSRange = buttonText.range(of: "\n")
//        var substring1 = ""
//        var substring2 = ""
//
//        if(newlineRange.location != NSNotFound) {
//            substring1 = buttonText.substring(to: newlineRange.location)
//            substring2 = buttonText.substring(from: newlineRange.location)
//        }
//
//        let font1: UIFont = UIFont(name: "HelveticaNeue-Bold", size: 17.0)!
//        let attributes1 = [NSMutableAttributedString.Key.font: font1]
//        let attrString1 = NSMutableAttributedString(string: substring1, attributes: attributes1)
//        let font2: UIFont = UIFont(name: "Helvetica", size: 14.0)!
//
//        let attributes2 = [NSMutableAttributedString.Key.font: font2]
//        let attrString2 = NSMutableAttributedString(string: substring2, attributes: attributes2)
//
//        //appending both attributed strings
//        attrString1.append(attrString2)
//        followersButton.setAttributedTitle(attrString1, for: [])
//    }
//
//    private func addTextOnFollowingButton(followingButton:UIButton) {
//        followingButton.titleLabel?.lineBreakMode = NSLineBreakMode.byWordWrapping
//        let buttonText: NSString = "78\nSiguiendo"
//        let newlineRange: NSRange = buttonText.range(of: "\n")
//        var substring1 = ""
//        var substring2 = ""
//
//        if(newlineRange.location != NSNotFound) {
//            substring1 = buttonText.substring(to: newlineRange.location)
//            substring2 = buttonText.substring(from: newlineRange.location)
//        }
//
//        let font1: UIFont = UIFont(name: "HelveticaNeue-Bold", size: 17.0)!
//        let attributes1 = [NSMutableAttributedString.Key.font: font1]
//        let attrString1 = NSMutableAttributedString(string: substring1, attributes: attributes1)
//
//        let font2: UIFont = UIFont(name: "Arial", size: 14.0)!
//        let attributes2 = [NSMutableAttributedString.Key.font: font2]
//        let attrString2 = NSMutableAttributedString(string: substring2, attributes: attributes2)
//
//        attrString1.append(attrString2)
//        followingButton.setAttributedTitle(attrString1, for: [])
//    }
//}
//
//
////MARK: Navigation Items
//extension PruebaViewController {
//    private func setupRemaningNavItems() {
//        let followButton = UIButton(type: .system)
//        followButton.setTitle("eddylujann", for: .normal)
//        followButton.titleLabel?.font = .systemFont(ofSize: 26, weight: .black )
//        followButton.tintColor = Constants.Color.black
//        //followButton.frame = CGRect(x: 0, y: 0, width: 34, height: 34)
//        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: followButton)
//        navigationController?.navigationBar.backgroundColor = .white
//        navigationController?.navigationBar.isTranslucent = false
//    }
//}
//
////MARK:- ACTIONS
//extension PruebaViewController {
//
//
//    @objc private func didTapPostButton(_header: ProfileInfoHeaderCollectionReusableView) {
//        // scroll to the posts
//        //collectionView.scrollToItem(at: IndexPath(row: 0, section: 1), at: .top, animated: true)
//        print("didTapPostButton")
//    }
//
//    @objc private func didTapFollowersButton(_header: ProfileInfoHeaderCollectionReusableView) {
//        /*var mockData = [UserRelationship]()
//        for x in 0..<10 {
//            mockData.append(UserRelationship(username: "@joer", namm: "Joe Smith", type: x % 2 == 0 ? .following: .not_following))
//        }
//        let vc = ListViewController(data: mockData)
//        vc.title = "Follower"
//        vc.navigationItem.largeTitleDisplayMode = .never
//        navigationController?.pushViewController(vc, animated: true)*/
//
//        print("profileHeaderDidTapFollowersButton")
//        let vc = UIViewController()
//        vc.navigationItem.largeTitleDisplayMode = .never
//        navigationController?.pushViewController(vc, animated: true)
//    }
//
//
//    @objc private func didTapFollowingButton(_header: ProfileInfoHeaderCollectionReusableView) {
//        /*var mockData = [UserRelationship]()
//        for x in 0..<10 {
//            mockData.append(UserRelationship(username: "@joer", namm: "Joe Smith", type: x % 2 == 0 ? .following: .not_following))
//        }
//        let vc = ListViewController(data: mockData)
//        vc.title = "Following"
//        vc.navigationItem.largeTitleDisplayMode = .never
//        navigationController?.pushViewController(vc, animated: true)*/
//
//        print("profileHeaderDidTapFollowingButton")
//    }
//
//    @objc private func didTapEditProfileButton(_header: ProfileInfoHeaderCollectionReusableView) {
//        let vc = EditProfileViewController()
//        vc.title = "Edit Profile"
//        present(UINavigationController(rootViewController: vc), animated: true)
//    }
//}
