//
//  TimeLineViewController.swift
//  SwiftNetwork
//
//  Created by Eddy Donald Chinchay Lujan on 25/4/21.
//

import UIKit

struct HomeFeedRenderViewModel {
    let collections: PostRenderViewModel
    let header: PostRenderViewModel
    let post: PostRenderViewModel
    let actions: PostRenderViewModel
    let descriptions: PostRenderViewModel
    let comments: PostRenderViewModel
    let footer: PostRenderViewModel
}

//HomeViewController
class HomeViewController: UIViewController {
    
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
        ///button.backgroundColor = UIColor(red: 244/255, green: 244/255, blue: 244/255, alpha: 1.0)
        button.layer.cornerRadius = 10
        //button.titleLabel?.font = UIFont(name: "Directo", size: 8)
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
        ///button.backgroundColor = UIColor(red: 244/255, green: 244/255, blue: 244/255, alpha: 1.0)
        button.layer.cornerRadius = 10
        return button
    }()
    
    private let sendButton: UIButton = {
        let button = UIButton(frame: CGRect(x: 100, y: 100, width: 200, height: 200))
        button.tintColor = Constants.Color.blue
        let config = UIImage.SymbolConfiguration(pointSize: 18, weight: .semibold) //semibold, regular, thin
        let image = UIImage(systemName: "location.fill", withConfiguration: config)
        button.imageView?.contentMode = UIView.ContentMode.scaleAspectFit
        button.setImage(image, for: UIControl.State.normal)
        button.titleLabel?.font = .systemFont(ofSize: 14, weight: .semibold)
        button.setTitle("Ubicación", for: .normal)
        button.setTitleColor(.black, for: .normal)
        ///button.backgroundColor = UIColor(red: 244/255, green: 244/255, blue: 244/255, alpha: 1.0)
        button.layer.cornerRadius = 10
        return button
    }()
    
    private let tableView: UITableView = {
        //let tableView = UITableView(frame: .zero, style: .grouped)
        let tableView = UITableView()
        return tableView
    }()
    
    private let headerView: UIView = {
        let headerView = UIView()
        headerView.backgroundColor = .systemBackground
        return headerView
    }()
    
    private let imageView: UIImageView = {
        //let imageView = UIImageView(image: UIImage(systemName: "person.circle"))
        let imageView = UIImageView(image: UIImage(named: "user3"))
        imageView.tintColor = .darkGray
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
//    private let textField: UITextField = {
//        let textField = UITextField()
//        textField.placeholder = "¿Eddy, en que piensas?"
//        textField.textColor = .black
//        textField.font = .systemFont(ofSize: 18, weight: .regular)
//        return textField
//    }()
    
    private let writePostButton: UIButton = {
        let button = UIButton()
        button.setTitle("¿Eddy, en que piensas?", for: .normal)
        button.contentHorizontalAlignment = .left
        button.setTitleColor(Constants.Color.lightDark, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 18, weight: .regular)
        //button.backgroundColor = .systemGreen
        return button
    }()
    
    private let separatorView: UIView = {
        let view = UIView()
        view.backgroundColor = .secondarySystemFill
        view.translatesAutoresizingMaskIntoConstraints  = false
        return view
    }()

    private let buttonVideo: UIButton = {
        let button = UIButton()
        return button
    }()
    
    
    private var models = [HomeFeedRenderViewModel]()
    private var collections : [CollectionTableCellModel] = []
    private var comments    : [PostComments] = []
    private var likes       : [PostLike] = []
    private var users       : User?
    private var posts       : UserPost?

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
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
        
        headerView.backgroundColor = .systemBackground
        headerView.frame = CGRect(
            x: 0,
            y: 0,
            width: view.width,
            height: 120)
        
        imageView.contentMode = .scaleAspectFit
        imageView.frame = CGRect(
            x: 10,
            y: 5,
            width: headerView.height-50,
            height: 50)
        imageView.layer.cornerRadius = imageView.height/2
        
        writePostButton.backgroundColor = .systemBackground
        writePostButton.frame = CGRect(
            x: 20+imageView.width,
            y: 5,
            width: headerView.width-20-imageView.width,
            height: 50)
        
        separatorView.frame = CGRect(
            x: tableView.separatorInset.left,
            y: 0  ,
            width: 20,
            height: 1)
        
        let buttonSize = headerView.height
        let buttons = [likeButton, commentButton, sendButton]
        for x in 0..<buttons.count {
            let button = buttons[x]
            button.frame = CGRect(
                x: (CGFloat(x)*buttonSize)+(15*CGFloat(x+1)),
                y: imageView.frame.origin.y + imageView.frame.size.height + 25,
                width: buttonSize,
                height: 30)
        }
        headerView.addSubview(separatorView)
        NSLayoutConstraint.activate([
            separatorView.leadingAnchor.constraint(equalTo:headerView.leadingAnchor),
            separatorView.trailingAnchor.constraint(equalTo:headerView.trailingAnchor),
            separatorView.heightAnchor.constraint(equalToConstant:5),
            separatorView.bottomAnchor.constraint(equalTo:headerView.bottomAnchor)])
    }
    
    private func setup() {
        view.addSubview(tableView)
        tableView.tableHeaderView = createTableHeader()
        headerView.addSubview(likeButton)
        headerView.addSubview(commentButton)
        headerView.addSubview(sendButton)
    }
    
    private func handleNotAuthenticated() {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let token = appDelegate.objUsuarioSesion?.token
        
        if token == nil {
            let vc = LoginViewController()
            vc.modalPresentationStyle = .fullScreen
            self.present(vc, animated: false)
        }
    }
    
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
        headerView.addSubview(buttonVideo)
        return headerView
    }
    
    ///Collections
    func createArrayCollections() -> [CollectionTableCellModel] {
        var collections = [CollectionTableCellModel]()
        let username = ["eddylujann", "jordann", "paola","rebeca", "jeremy", "lucas", "jean"]
        for i in 0..<username.count {
            let data = CollectionTableCellModel(title: username[i], imageName: "img\(i+1)")
            collections.append(data)
        }
        return collections
    }
    
    ///Comments
    func createArrayComments() -> [PostComments] {
        var tempComments: [PostComments] = []
        for i in 0..<5 {
            let comments = PostComments(identifier: "id-\(i)", username: "\(i) Username", text: "commentario \(i)", createDate: Date(), likes: [])
            tempComments.append(comments)
        }
        return tempComments
    }
    
    ///Likes
    func createArrayLikes() -> [PostLike] {
        var likes = [PostLike]()
        for i in 0..<5 {
            let data = PostLike(
                username: "jor \(i)",
                postIdentifier: "",
                text: "Mi primera publicacion para el test de la App.",
                likes: i)
            likes.append(data)
        }
        return likes
    }
    
    ///User
    func createArrayUser() -> User {
        let user = User(
            name: (first: "", last: ""),
            username: "jordan",
            bio: "",
            profilePicture: URL(string: "https://wwww.google.com")!,
            birthDate: Date(),
            gender: .male,
            email: "",
            counts: UserCount(followers: 1, following: 1, posts: 1),
            joinDate: Date())
        return user
      
    }
    
    ///UserPost
    func createArrayUserPost() -> UserPost {
        likes = createArrayLikes() ///Se obtiene el array de likes
        let post = UserPost(
            identifier: "post 2",
            postType: .photo,
            thumbnailImage: URL(
                string: "http://127.0.0.1:8000/storage/app-new-publish/EddyLujan/images/img9.jpeg")!,
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
        collections = createArrayCollections()
        comments    = createArrayComments()
        users       = createArrayUser()
        posts       = createArrayUserPost()
        for _ in 0..<2 {
            let viewModel = HomeFeedRenderViewModel(
                collections : PostRenderViewModel(renderType: .collections(collections  : collections   )),
                header      : PostRenderViewModel(renderType: .header(provider          : users!        )),
                post        : PostRenderViewModel(renderType: .primaryContent(provider  : posts!        )),
                actions     : PostRenderViewModel(renderType: .actions(provider         : posts!        )),
                descriptions: PostRenderViewModel(renderType: .descriptions(post        : posts!        )),
                comments    : PostRenderViewModel(renderType: .comments(comments        : comments      )),
                footer      : PostRenderViewModel(renderType: .footer(footer            : "")           )
            )
            models.append(viewModel)
        }
    }
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return models.count * 7
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let count = section
        var model: HomeFeedRenderViewModel
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
            else if subSection == 5 { /// Comments
                let commentsModel = model.comments
                switch commentsModel.renderType {
                    case .comments(let comments):
                        return comments.count > 0 ? 2 : comments.count /// Retorna el total de comentarios
                    case .header, .actions, .primaryContent, .collections, .descriptions, .footer :
                        return 0
                }
            }
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
                case .collections(let collections):
                    let cell = tableView.dequeueReusableCell(
                        withIdentifier: CollectionTableViewCell.identifier,
                        for: indexPath) as! CollectionTableViewCell
                    cell.configure(with: collections)
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
                        let separatorView = UIView(frame: CGRect(x: tableView.separatorInset.left, y: 0, width: 20, height: 1))
                        separatorView.backgroundColor = .secondarySystemFill
                        
                        separatorView.translatesAutoresizingMaskIntoConstraints  = false
                        cell.contentView.addSubview(separatorView)
                        
                        NSLayoutConstraint.activate([
                            separatorView.leadingAnchor.constraint(equalTo:cell.contentView.leadingAnchor),
                            separatorView.trailingAnchor.constraint(equalTo:cell.contentView.trailingAnchor),
                            separatorView.heightAnchor.constraint(equalToConstant:5),
                            separatorView.topAnchor.constraint(equalTo:cell.contentView.topAnchor)])
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
            } else if subSection == 5 { /// comments
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
                    case .footer(/*let footer*/_):
                        let cell = tableView.dequeueReusableCell(
                            withIdentifier: IGFeedPostFooterTableViewCell.identifier,
                            for: indexPath) as! IGFeedPostFooterTableViewCell
                            cell.configure()
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
        if indexPath.section == 0 { return 250 } //Collection
        else {
            let subSection = indexPath.section % 7
            if subSection        == 1 { return 70 } /// Header
            else if subSection   == 2 { return tableView.width } /// Post
            else if subSection   == 3 { return 60 }  /// Actions
            else if subSection   == 4 { return 90 } /// Description
            else if subSection   == 5 { return 30  } /// Comment
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
}

extension HomeViewController: CollectionTableViewCellDelegate {
    func didSelectItem(with model: CollectionTableCellModel) {
        print("Selected \(model.title)")
    }
}

//MARK: Actions buttons
extension HomeViewController: IGFeedPostActionsTableViewCellDelegate {
  
    func didTapLikeButton() {
        print("like")
    }
    
    func didTapCommentButton(model: UserPost) {
        let vc = ListCommentsViewController(model: model)
        vc.title = "Coments"
        vc.navigationItem.largeTitleDisplayMode = .never
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func didTapSendButton() {
        print("Send")
    }
}

// MARK: Navigation Buttons
extension HomeViewController {
    private func setupRemaningNavItems() {
        //let titleImageView = UIImageView(image: UIImage(systemName: "bag"))
        let titleImageView = UIImageView(image: UIImage(named: "logo"))
        ///titleImageView.backgroundColor = .red
        titleImageView.tintColor = Constants.Color.blue
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
        followButton.setTitle("N O O R I", for: .normal)
        followButton.titleLabel?.font = .systemFont(ofSize: 26, weight: .black )
        followButton.tintColor = Constants.Color.blue
        followButton.frame = CGRect(x: 0, y: 0, width: 34, height: 34)
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: followButton)
        
        navigationController?.navigationBar.backgroundColor = .white
        navigationController?.navigationBar.isTranslucent = false
    }
    
    private func  setupRightNavItems() {
        let searchButton = UIButton(type: .system)
        searchButton.setImage(UIImage(systemName: "paperplane.fill"), for: .normal)
        searchButton.tintColor =  Constants.Color.blue
        searchButton.frame = CGRect(x: 0, y: 0, width: 34, height: 34)
        
        let composeButton = UIButton(type: .system)
        composeButton.setImage(UIImage(systemName: "plus"), for: .normal)
        composeButton.tintColor = Constants.Color.blue
        composeButton.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
        navigationItem.rightBarButtonItems = [
            UIBarButtonItem(customView: searchButton),
            UIBarButtonItem(customView: composeButton)
        ]
    }
}
