//
//  TimeLineViewController.swift
//  SwiftNetwork
//
//  Created by Eddy Donald Chinchay Lujan on 25/4/21.
//

import UIKit
//import FloatingPanel

struct HomeFeedRenderViewModel {
    let collections: PostRenderViewModel
    let header: PostRenderViewModel
    let post: PostRenderViewModel
    let actions: PostRenderViewModel
    let descriptions: PostRenderViewModel
    let comments: PostRenderViewModel
    let footer: PostRenderViewModel
}


class HomeViewController: UIViewController {
    
    let cellSpacingHeight: CGFloat = 5
    
    //let settingsLauncher = SettingsLauncher()
    //let heigth: CGFloat = 250
    var model : HomeFeedRenderViewModel?
    
    private let tableMenuView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)// UITableView()
        return tableView
    }()
    
    private let likeButton: UIButton = {
        let button = UIButton(frame: CGRect(x: 100, y: 100, width: 200, height: 200))
        button.tintColor = .systemRed
        let config = UIImage.SymbolConfiguration(pointSize: 18, weight: .semibold) //semibold, regular, thin
        let image = UIImage(systemName: "video.fill", withConfiguration: config)
        button.imageView?.contentMode = UIView.ContentMode.scaleAspectFit
        button.setImage(image, for: UIControl.State.normal)
        button.setTitle("Directo", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 14, weight: .semibold)
        button.setTitleColor(.black, for: .normal)
        button.layer.cornerRadius = 10
        return button
    }()
    
    private let commentButton: UIButton = {
        let button = UIButton(frame: CGRect(x: 100, y: 100, width: 200, height: 200))
        button.tintColor = .systemGreen
        let config = UIImage.SymbolConfiguration(pointSize: 18, weight: .semibold) //semibold, regular, thin
        let image = UIImage(systemName: "photo.on.rectangle", withConfiguration: config)
        button.imageView?.contentMode = UIView.ContentMode.scaleAspectFit
        button.setImage(image, for: UIControl.State.normal)
        button.titleLabel?.font = .systemFont(ofSize: 14, weight: .semibold)
        button.setTitle("Foto", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.layer.cornerRadius = 10
        return button
    }()
    
    private let sendButton: UIButton = {
        let button = UIButton(frame: CGRect(x: 100, y: 100, width: 200, height: 200))
//        button.tintColor = Constants.Color.blue
        let config = UIImage.SymbolConfiguration(pointSize: 18, weight: .semibold)
        let image = UIImage(systemName: "location.fill", withConfiguration: config)
        button.imageView?.contentMode = UIView.ContentMode.scaleAspectFit
        button.setImage(image, for: UIControl.State.normal)
        button.titleLabel?.font = .systemFont(ofSize: 14, weight: .semibold)
        button.setTitle("Ubicación", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.layer.cornerRadius = 10
        return button
    }()
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        return tableView
    }()
    
    private let headerView: UIView = {
        let headerView = UIView()
//        headerView.backgroundColor = .systemBackground
        return headerView
    }()
    
    private let imageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(systemName: "person.circle"))
        imageView.tintColor = Constants.Color.black
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
        
    private let writePostButton: UIButton = {
        let button = UIButton(frame: CGRect(x: 10, y: 10, width: 10, height: 0))
        button.setTitle("¡Eddy, dile al mundo lo que piensas!", for: .normal)
        button.contentHorizontalAlignment = .left
        button.setTitleColor(Constants.Color.general, for: .normal)
        button.titleLabel?.font = Constants.fontSize.regular
        button.clipsToBounds = true
        button.layer.masksToBounds = true
        button.titleEdgeInsets = UIEdgeInsets(top: 0.0, left: 10.0, bottom: 0.0, right: 0.0)
        return button
    }()
    
    private let uploadImageButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "photo.on.rectangle.angled"), for: .normal)
        button.contentMode = .scaleAspectFit
        button.tintColor = Constants.Color.whiteLight
        return button
    }()
    
    private let separatorView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemGray5
        view.translatesAutoresizingMaskIntoConstraints  = false
        return view
    }()

    private let buttonVideo: UIButton = {
        let button = UIButton()
        return button
    }()
    
    lazy var settingLauncher: SettingsLauncher = {
        let launcher = SettingsLauncher()
        launcher.homeController = self
        return launcher
    }()

    private var models = [HomeFeedRenderViewModel]()
    private var story : [CollectionTableCellModel] = []
    private var collections : [CollectionTableCellModel] = []
    private var comments    : [PostCommentsViewModel] = []
    private var likes       : [PostLikeViewModel] = []
    private var users       : UserViewModel?
    private var posts       : UserPostViewModel?

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        //handleNotAuthenticated()
        setupModels()
        configureTableView()
        delegateTableView()
        setupNavigationBarItems()
        addButtonActions()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.tabBar.isHidden = false
    }
    
    override func viewDidLayoutSubviews() {
        
        tableView.frame = tableView.frame.inset(by: UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8))
        
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
        headerView.frame = CGRect(
            x: 0,
            y: 0,
            width: view.width,
            height: 65)
        
        imageView.contentMode = .scaleAspectFit
        imageView.frame = CGRect(
            x: 5,
            y: 10,
            width:40,
            height: 40)
        imageView.layer.cornerRadius = imageView.height/2
        
        let buttonWidth = view.width > 500 ? 220.0 : view.width/6
        let labelHeight = headerView.height/2
        
        writePostButton.frame = CGRect(
            x: imageView.right+10,
            y: 12,
            width: headerView.width-8-imageView.width-buttonWidth,
            height: labelHeight)
        writePostButton.layer.cornerRadius = writePostButton.height/2
        
        uploadImageButton.frame = CGRect(
            x: writePostButton.right+5,
            y: 12,
            width: buttonWidth-10,
            height: labelHeight)
        
        separatorView.frame = CGRect(
            x: tableView.separatorInset.left,
            y: 0  ,
            width: 20,
            height: 1)
        
        headerView.addSubview(separatorView)
        NSLayoutConstraint.activate([
            separatorView.leadingAnchor.constraint(equalTo:headerView.leadingAnchor),
            separatorView.trailingAnchor.constraint(equalTo:headerView.trailingAnchor),
            separatorView.heightAnchor.constraint(equalToConstant:5),
            separatorView.bottomAnchor.constraint(equalTo:headerView.bottomAnchor)])
    }
    
    private func setup() {
        view.backgroundColor = UIColor(red: 0.05, green: 0.05, blue: 0.07, alpha: 1.00)
        view.addSubview(tableView)
        tableView.tableHeaderView = createTableHeader()
    }
    

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    /**private func handleNotAuthenticated() {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let token = appDelegate.objUsuarioSesion?.token
        
        if token == nil {
            let vc = LoginViewController()
            vc.modalPresentationStyle = .fullScreen
            self.present(vc, animated: false)
        }
    }*/
 
    private func setupNavigationBarItems() {
        setupLeftNavItems()
        setupRightNavItems()
        //setupRemaningNavItems()
    }
    
    private func configureTableView() {
        tableView.register(CollectionTableViewCell.self, forCellReuseIdentifier: CollectionTableViewCell.identifier)
        tableView.register(IGFeedPostTableViewCell.self, forCellReuseIdentifier: IGFeedPostTableViewCell.identifier)
        tableView.register(IGFeedPostHeaderTableViewCell.self, forCellReuseIdentifier: IGFeedPostHeaderTableViewCell.identifier)
        tableView.register(IGFeedPostActionsTableViewCell.self, forCellReuseIdentifier: IGFeedPostActionsTableViewCell.identifier)
        tableView.register(IGFeedPostDescriptionTableViewCell.self, forCellReuseIdentifier: IGFeedPostDescriptionTableViewCell.identifier)
        tableView.register(IGFeedPostGeneralTableViewCell.self, forCellReuseIdentifier: IGFeedPostGeneralTableViewCell.identifier)
        tableView.register(IGFeedPostFooterTableViewCell.self, forCellReuseIdentifier: IGFeedPostFooterTableViewCell.identifier)
        tableView.separatorStyle = .none
    }
    
    private func delegateTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        
        tableMenuView.delegate = self
        tableMenuView.delegate = self
    }
    
    private func addButtonActions() {
        writePostButton.addTarget(self, action: #selector(didTapWritePostButton), for: .touchUpInside)
    }
    
    @objc private func didTapWritePostButton() {
        let vc = PublishPostViewController()
        vc.title = "Create Post"
        vc.modalPresentationStyle = .fullScreen
        vc.navigationItem.largeTitleDisplayMode = .never
        present(UINavigationController(rootViewController: vc), animated: true)
    }
    
    ///Header
    private func createTableHeader() -> UIView? {
        view.addSubview(headerView)
        headerView.addSubview(imageView)
        headerView.addSubview(writePostButton)
        headerView.addSubview(uploadImageButton)
        return headerView
    }
    
    ///Create Story Collections
    func createStoryCollections() -> [CollectionTableCellModel] {
        var collections = [CollectionTableCellModel]()
        let data = CollectionTableCellModel(title: "eddy", imageName: "eddy")
        collections.append(data)

        return collections
    }
    
    ///Collections
    func createArrayCollections() -> [CollectionTableCellModel] {
        var collections = [CollectionTableCellModel]()
        let username = ["eddylujann", "jordann", "paola","rebeca", "jeremy", "lucas"]
        for i in 0..<username.count {
            let data = CollectionTableCellModel(title: username[i], imageName: "img\(i+1)")
            collections.append(data)
        }
        return collections
    }
    
    ///Comments
    func createArrayComments() -> [PostCommentsViewModel] {
        var tempComments: [PostCommentsViewModel] = []
        for i in 0..<5 {
            let comments = PostCommentsViewModel(
                id: i+1,
                username: "@save",
                typeId: 0,
                refId: 0,
                userssId: 0,
                content: "Great post!",
                comentarioId: 0,
                createdAt: "",// Date(),
                likes: []
                /*identifier: "id-\(i)", username: "\(i) Username", text: "commentario \(i)", createDate: Date(), likes: []*/)
            tempComments.append(comments)
        }
        return tempComments
    }
    
    ///Likes
    func createArrayLikes() -> [PostLikeViewModel] {
        let likes = [PostLikeViewModel]()
        /*for i in 0..<5 {
            let data = PostLikeViewModel(
                username: "jor \(i)",
                postIdentifier: "",
                text: "Mi primera publicacion para el test de la App.",
                likes: i)
            likes.append(data)
        }*/
        return likes
    }
    
    ///User
    func createArrayUser() -> UserViewModel {
        let user = UserViewModel(
            name: "",
            last: "",//(first: "", last: ""),
            username: "eddylujann",
            bio: "",
            profilePicture: URL(string: "https://wwww.google.com")!,
            dayOfBirth: Date(),
            gender: GenderViewModel(gender: "male"),//.male,
            publicEmail: "",
            counts: UserCountViewModel(followers: 1, following: 1, posts: 1),
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
        return user
      
    }
    
    ///UserPostViewModel
    func createArrayUserPostViewModel() -> UserPostViewModel {
        likes = createArrayLikes() ///Se obtiene el array de likes
        let post = UserPostViewModel(
            identifier: "post 2",
            postType: .photo,
            thumbnailImage: URL(
                string: "http://127.0.0.1:8000/storage/app-new-publish/EddyLujan/images/boy.jpeg")!,
            postURL: URL(string: "https://wwww.google.com")!,
            caption: "Esto es un titlo del post para un ejemplo en el Iphone de hacer proueba y test",
            likeCount: likes,
            comments: comments,
            createDate: Date(),
            taggedUsers: [],
            owner: users!)
        return post
    }
    
    private func setupModels() {
        story       = createStoryCollections()
        collections = createArrayCollections()
        comments    = createArrayComments()
        users       = createArrayUser()
        posts       = createArrayUserPostViewModel()
        for _ in 0..<2 {
            let viewModel = HomeFeedRenderViewModel(
                collections : PostRenderViewModel(renderType: .collections(collections  : collections, createStory: story )),
                header      : PostRenderViewModel(renderType: .header(provider          : users!        )),
                post        : PostRenderViewModel(renderType: .primaryContent(provider  : posts!        )),
                actions     : PostRenderViewModel(renderType: .actions(provider         : posts!        )),
                descriptions: PostRenderViewModel(renderType: .descriptions(post        : posts!        )),
                comments    : PostRenderViewModel(renderType: .comments(comments        : comments      )),
                footer      : PostRenderViewModel(renderType: .footer(footer            : posts!        ))
            )
            models.append(viewModel)
        }
    }
}

//MARK:- TableView
extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return models.count * 7
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let count = section
        if count == 0 { ///Pinta el collection de imagenes
            model = models[0]
            return 1
        } else { /// Pinta el resto de contenido del post (hader, posts, actions, comments)
            let position = count % 7 == 0 ? count / 7 : ((count - (count % 7)) / 7)
            model = models[position]
            let subSection = count % 7
            if subSection      == 1 { return 1 } /// Header
            else if subSection == 2 { return 1 } /// Post
            else if subSection == 3 { return 1 } /// Actions
            else if subSection == 4 { return 1 } /// Description
            else if subSection == 5 { return 1 } /// Comments
            else if subSection == 6 { return 1 } /// Footer
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model: HomeFeedRenderViewModel
        let count = indexPath.section
        if count == 0 { ///Pinta el collection de imagenes
            model = models[0]
            switch model.collections.renderType {
            case .collections(let collections, let createStory):
                    let cell = tableView.dequeueReusableCell(
                        withIdentifier: CollectionTableViewCell.identifier,
                        for: indexPath) as! CollectionTableViewCell
                        cell.configure(with: collections, with: createStory)
                        cell.delegate = self
                    return cell
            case .comments, .actions, .primaryContent, .header, .descriptions, .footer :
                    return UITableViewCell()
                }
        } else { /// Pinta el resto de contenido del post (hader, posts, actions, comments)
            let position = count % 7 == 7 ? count/7 : ((count - (count % 7)) / 7)
            model = models[position]
            let subSection = count % 7
            if subSection == 1 { /// Header
                switch model.header.renderType {
                    case .header(let user):
                        let cell = tableView.dequeueReusableCell(
                            withIdentifier: IGFeedPostHeaderTableViewCell.identifier,
                            for: indexPath) as! IGFeedPostHeaderTableViewCell
                            cell.configure(with: user)
                        cell.frame = CGRect(x: 5, y: 5, width: tableView.width-10 , height: 70  )
                        return cell
                    case .comments, .actions, .primaryContent, .collections, .descriptions, .footer :
                        return UITableViewCell()
                }
            } else if subSection == 2 { /// Post
                switch model.post.renderType {
                    case .primaryContent(let post):
                        let cell = tableView.dequeueReusableCell(
                            withIdentifier: IGFeedPostTableViewCell.identifier,
                            for: indexPath) as! IGFeedPostTableViewCell
                            cell.configure(with: post)
                        return cell
                    case .comments, .actions, .header, .collections, .descriptions, .footer :
                        return UITableViewCell()
                }
            } else if subSection == 3 { /// Actions
                switch model.actions.renderType {
                    case .actions(let provider):
                        let cell = tableView.dequeueReusableCell(
                            withIdentifier: IGFeedPostActionsTableViewCell.identifier,
                            for: indexPath) as! IGFeedPostActionsTableViewCell
                            cell.configure(with: provider)
                            cell.delegate = self
                        return cell
                    case .comments, .header, .primaryContent, .collections, .descriptions, .footer :
                        return UITableViewCell()
                }
            } else if subSection == 4 { /// Descriptions
                switch model.descriptions.renderType {
                    case .descriptions(let post):
                        let cell = tableView.dequeueReusableCell(
                            withIdentifier: IGFeedPostDescriptionTableViewCell.identifier,
                            for: indexPath) as! IGFeedPostDescriptionTableViewCell
                            cell.configure(with: post)
                        return cell
                    case .comments, .header, .primaryContent, .collections, .actions, .footer:
                        return UITableViewCell()
                }
            }
            else if subSection == 5 { /// comments
                switch model.comments.renderType {
                case .comments(let comments):
                    let comment = comments[indexPath.row] ///Se obtiene cada fila del array de comments
                    let cell = tableView.dequeueReusableCell(
                        withIdentifier: IGFeedPostGeneralTableViewCell.identifier,
                        for: indexPath) as! IGFeedPostGeneralTableViewCell
                        cell.configure(with: comment)
                    return cell
                case .header, .actions, .primaryContent, .collections, .descriptions, .footer :
                    return UITableViewCell()
                }
            } else if subSection == 6 { /// Footer
                switch model.footer.renderType {
                    case .footer(let footer):
                        let cell = tableView.dequeueReusableCell(
                            withIdentifier: IGFeedPostFooterTableViewCell.identifier,
                            for: indexPath) as! IGFeedPostFooterTableViewCell
                            cell.configure(with: footer)
                            cell.delegate = self
                            let separatorView = UIView(frame: CGRect(x: tableView.separatorInset.left, y: 0, width: 20, height: 1))
                            separatorView.backgroundColor = .systemGray5
                            separatorView.translatesAutoresizingMaskIntoConstraints  = false
                            cell.contentView.addSubview(separatorView)
                            NSLayoutConstraint.activate([
                                separatorView.leadingAnchor.constraint(equalTo:cell.contentView.leadingAnchor),
                                separatorView.trailingAnchor.constraint(equalTo:cell.contentView.trailingAnchor),
                                separatorView.heightAnchor.constraint(equalToConstant:1),
                                separatorView.topAnchor.constraint(equalTo:cell.contentView.topAnchor)])

                            let separatorView2 = UIView(frame: CGRect(x: tableView.separatorInset.left, y: 0, width: 20, height: 1))
                            separatorView2.backgroundColor = .systemGray5
                            separatorView2.translatesAutoresizingMaskIntoConstraints  = false
                            cell.contentView.addSubview(separatorView2)
                            NSLayoutConstraint.activate([
                                separatorView2.leadingAnchor.constraint(equalTo:cell.contentView.leadingAnchor),
                                separatorView2.trailingAnchor.constraint(equalTo:cell.contentView.trailingAnchor),
                                separatorView2.heightAnchor.constraint(equalToConstant:1),
                                separatorView2.bottomAnchor.constraint(equalTo:cell.contentView.bottomAnchor)])
                        return cell
                case .comments, .header, .primaryContent, .collections, .actions, .descriptions:
                        return UITableViewCell()
                }
            }
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        print("Did select normal list item")
    }
    
    ///Height de Cell
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 { return view.height/3 } //Collection
        else {
            let subSection = indexPath.section % 7
            if subSection        == 1 { return 70 } /// Header
            else if subSection   == 2 { return tableView.width } /// Post
            else if subSection   == 3 { return 50 }  /// Actions
            else if subSection   == 4 { return 100 } /// Description
            else if subSection   == 5 { return 25  } /// Comment 30
            else if subSection   == 6 { return 50  } /// Footer
            return 0
        }
    }

    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        let subSection = section % 7
        return subSection == 6 ? 20 : 0
    }
    
    // Set the spacing between sections
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return cellSpacingHeight
    }
}


//MARK: - Keyborad
extension HomeViewController: IGFeedPostFooterTableViewCellDelegate {
    
    func didTapComment(model: UserPostViewModel) {
        let vc = ListCommentsViewController(model: model)
        vc.title = "Coments"
        vc.navigationItem.largeTitleDisplayMode = .never
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension HomeViewController: CollectionTableViewCellDelegate {
 
    ///Show all story in list or collections
    func didPushUpStoryButton() {
        let vc = SettingStoryViewController()
        let navVC = UINavigationController(rootViewController: vc)
        navVC.modalPresentationStyle = .fullScreen
        navVC.navigationItem.largeTitleDisplayMode = .never
        present(navVC, animated: true)
    }
    
    ///Create story and collections the images
    func didSelectItem(with model: CollectionTableCellModel, type: String ) {
        switch type {
        case Constants.storyCollections.createStory:
            let vc = CreateStoryViewController()
            let modalStyle: UIModalTransitionStyle = UIModalTransitionStyle.crossDissolve
            vc.modalTransitionStyle = modalStyle
            vc.modalPresentationStyle = .fullScreen
            present(vc, animated: true)
            
        case Constants.storyCollections.collections:
            let vc = StoryViewController(model: model)
            let modalStyle: UIModalTransitionStyle = UIModalTransitionStyle.crossDissolve
            vc.modalTransitionStyle = modalStyle
            vc.modalPresentationStyle = .fullScreen
            present(vc, animated: true)
             
        default:
            print("Default")
        }
    }
}




//MARK: - Actions buttons
extension HomeViewController: IGFeedPostActionsTableViewCellDelegate {
  
    func didTapLikeButton() {
        print("like")
    }

    func didTapCommentButton(model: UserPostViewModel) {
        let vc = ListCommentsViewController(model: model)
        vc.title = "Coments"
        vc.navigationItem.largeTitleDisplayMode = .never
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func didTapSendButton() {
        self.settingLauncher.showSettings()
        ///self.settingLauncher.homeController = self
    }
    
    public func showControllerForSetting(index:Int, setting: Setting) {
        switch index {
            case 0: //Share in your story
//                let vc = StoryViewController()
//                vc.navigationItem.title = setting.name
//                vc.modalPresentationStyle = .fullScreen
//                vc.navigationItem.largeTitleDisplayMode = .never
//                present(UINavigationController(rootViewController: vc), animated: true)
                break
            case 1: //Send by menssenger ListContactMessenger
                let vc = ContactsMessengerViewController()
                vc.navigationItem.title = setting.name
                vc.modalPresentationStyle = .fullScreen
                vc.navigationItem.largeTitleDisplayMode = .never
                present(UINavigationController(rootViewController: vc), animated: true)///present(vc, animated: true)
                break
            case 2: //Setting
                break
            case 3: //More options
                break
            case 4: //Cancel
                break
            default:
                print("error select shared options")
        }
    }
}

// MARK: - Navigation Buttons
extension HomeViewController {
    private func setupRemaningNavItems() {
        //let titleImageView = UIImageView(image: UIImage(systemName: "bag"))
        let titleImageView = UIImageView(image: UIImage(named: "logo"))
        ///titleImageView.backgroundColor = .red
//        titleImageView.tintColor = Constants.Color.blue
        titleImageView.frame = CGRect(x: 0, y: 0, width: 34, height: 34)
        titleImageView.contentMode = .scaleAspectFit
        navigationItem.titleView = titleImageView
    }
    
    private func setupLeftNavItems() {
        /*let followButton = UIButton(type: .system)
        followButton.setImage(UIImage(systemName: "person.crop.circle.fill.badge.plus"), for: .normal)
        followButton.tintColor = Constants.ColorText.purple
        followButton.frame = CGRect(x: 0, y: 0, width: 34, height: 34)
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: followButton)*/
        
        let followButton = UIButton(type: .system)
        followButton.setTitle("Timwider", for: .normal)
        followButton.titleLabel?.font = .systemFont(ofSize: 26, weight: .black )
        followButton.tintColor = Constants.Color.black
        followButton.frame = CGRect(x: 0, y: 0, width: 34, height: 34)
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: followButton)
        navigationController?.navigationBar.backgroundColor = .white
        navigationController?.navigationBar.isTranslucent = false
    }
    
    private func  setupRightNavItems() {
        let searchButton = UIButton(type: .system)
        searchButton.setImage(UIImage(systemName: "paperplane.fill"), for: .normal)
        searchButton.tintColor =  Constants.Color.black
        searchButton.frame = CGRect(x: 0, y: 0, width: 34, height: 34)
        
        let composeButton = UIButton(type: .system)
        composeButton.setImage(UIImage(systemName: "plus"), for: .normal)
        composeButton.tintColor = Constants.Color.black
        composeButton.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
        navigationItem.rightBarButtonItems = [
            UIBarButtonItem(customView: searchButton),
            UIBarButtonItem(customView: composeButton)]
    }
}
