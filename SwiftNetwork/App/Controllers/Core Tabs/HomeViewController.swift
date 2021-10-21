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

///HomeViewController
class HomeViewController: UIViewController {
    ///let settingsLauncher = SettingsLauncher() ///let heigth: CGFloat = 250
    
    let cellSpacingHeight: CGFloat = 5
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        return tableView
    }()
    
    private let tableMenuView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)// UITableView()
        return tableView
    }()
    
    lazy var settingLauncher: SettingsLauncher = {
        let launcher = SettingsLauncher()
        launcher.homeController = self
        return launcher
    }()
    
    var model : HomeFeedRenderViewModel?
    
    private var models = [HomeFeedRenderViewModel]()
    
    // MARK: - viewDidLoad()
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        fetchUserPost()
        configureTableView()
        delegateTableView()
        setupNavigationBarItems()
        headerTableView()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = tableView.frame.inset(by: UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8))
        tableView.frame = view.bounds
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.tabBar.isHidden = false
    }
    
    ///Inicio del programa.
    ///Setupview
    private func setupView() {
        view.backgroundColor = .clear //UIColor(red: 0.05, green: 0.05, blue: 0.07, alpha: 1.00)
        view.addSubview(tableView)
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

    ///Hacemos una llamada al Api rest.
    ///Una vez obtenido los datos que queremos, se lo enviamos a la funcion setuModel.
    private func fetchUserPost() {
        APIService.shared.apiUserPost(token: handleNotAuthenticated()) {(result) in
            switch result {
            case .success(let model):
                print("-------- model home-----")
                print(model)
                self.setupModel(with: model.userpost ?? [])
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    ///Models
    ///Está función revcibe los datos para tratarlos y guardalos en el array Modelo.
    private func setupModel(with model: [Userpost] ) {
        for items in model {
            guard let user = items.userAuthor else { return }
            guard let comments = items.comments else { return }
            let viewModel = HomeFeedRenderViewModel(
                collections : PostRenderViewModel(renderType: .collections(collections:  createStoryCollections(), createStory: createArrayCollections())),
                header      : PostRenderViewModel(renderType: .header(provider: user)),
                post        : PostRenderViewModel(renderType: .primaryContent(provider: items)),
                actions     : PostRenderViewModel(renderType: .actions(provider: items)),
                descriptions: PostRenderViewModel(renderType: .descriptions(post: items)),
                comments    : PostRenderViewModel(renderType: .comments(comments: comments)),
                footer      : PostRenderViewModel(renderType: .footer(footer: items)))
            models.append(viewModel)
        }
        DispatchQueue.main.async{ self.tableView.reloadData() }
    }
    
    ///Creamos el Header en el ViewController.
    private func headerTableView() {
        tableView.tableHeaderView = createTableHeaderView()
    }
    
    ///Configuramos y registramos los TableViews
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
    
    ///Configuramos los delegates de ambas tables view
    ///Tableview
    ///TableMenuView
    private func delegateTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableMenuView.delegate = self
        tableMenuView.delegate = self
    }
    
    ///Creamos StoryCollections
    ///Boton se crear historia.
    func createStoryCollections() -> [CollectionTableCellModel] {
        var collections = [CollectionTableCellModel]()
        let data = CollectionTableCellModel(title: "eddy", imageName: "eddy")
        collections.append(data)
        return collections
    }
    
    ///Resto de collections.
    func createArrayCollections() -> [CollectionTableCellModel] {
        var collections = [CollectionTableCellModel]()
        let username = ["eddylujann", "jordann", "paola","rebeca", "jeremy", "lucas"]
        for i in 0..<username.count {
            let data = CollectionTableCellModel(title: username[i], imageName: "img\(i+1)")
            collections.append(data)
        }
        return collections
    }
    
    ///Navegacion bar items
    ///Left & Right.
    private func setupNavigationBarItems() {
        setupLeftNavItems()
        setupRightNavItems()
        ///setupRemaningNavItems()
    }
    
    ///Creamos el separador al final de cada post.
    private func separator(cell: IGFeedPostFooterTableViewCell) {
        let separatorView: UIView = {
            let view = UIView()
            view.backgroundColor = .systemGray5
            view.translatesAutoresizingMaskIntoConstraints  = false
            return view
        }()
        separatorView.frame = CGRect(x: 0, y: 10, width: view.width, height: view.height)
        cell.addSubview(separatorView)
        NSLayoutConstraint.activate([
            separatorView.leadingAnchor.constraint(equalTo:cell.leadingAnchor),
            separatorView.trailingAnchor.constraint(equalTo:cell.trailingAnchor),
            separatorView.heightAnchor.constraint(equalToConstant:5),
            separatorView.bottomAnchor.constraint(equalTo:cell.bottomAnchor)])
    }
    
    ///Button de  crear un nuevo post.
    @objc private func didTapWritePostButton() {
        let vc = PublishPostViewController()
        vc.title = "Create Post"
        vc.modalPresentationStyle = .fullScreen
        vc.navigationItem.largeTitleDisplayMode = .never
        present(UINavigationController(rootViewController: vc), animated: true)
    }
}

//MARK:- TableView Delgates
extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    
    ///Creamos el header en el TableView
    private func createTableHeaderView() -> UIView {
        let imageView: UIImageView = {
            let imageView = UIImageView(image: UIImage(systemName: "person.circle"))
            imageView.tintColor = Constants.Color.black
            imageView.contentMode = .scaleAspectFit
            return imageView
        }()
            
        let writePostButton: UIButton = {
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
        
        let uploadImageButton: UIButton = {
            let button = UIButton()
            button.setImage(UIImage(systemName: "photo.on.rectangle.angled"), for: .normal)
            button.contentMode = .scaleAspectFit
            button.tintColor = Constants.Color.whiteLight
            return button
        }()
        
        let separatorView: UIView = {
            let view = UIView()
            view.backgroundColor = .systemGray5
            view.translatesAutoresizingMaskIntoConstraints  = false
            return view
        }()
        
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 60))
        imageView.contentMode = .scaleAspectFit
        imageView.frame = CGRect(x: 5, y: 10, width:40, height: 40)
        imageView.layer.cornerRadius = imageView.height/2
        
        let buttonWidth = view.width > 500 ? 220.0 : view.width/6
        let labelHeight = headerView.height/2
        
        writePostButton.frame = CGRect(x: imageView.right+10, y: 12, width: headerView.width-8-imageView.width-buttonWidth,height: labelHeight)
        writePostButton.layer.cornerRadius = writePostButton.height/2
        uploadImageButton.frame = CGRect(x: writePostButton.right+5,y: 12,width: buttonWidth-10,height: labelHeight)
        
        writePostButton.addTarget(self, action: #selector(didTapWritePostButton), for: .touchUpInside)
        headerView.addSubview(separatorView)
        NSLayoutConstraint.activate([
            separatorView.leadingAnchor.constraint(equalTo:headerView.leadingAnchor),
            separatorView.trailingAnchor.constraint(equalTo:headerView.trailingAnchor),
            separatorView.heightAnchor.constraint(equalToConstant:5),
            separatorView.bottomAnchor.constraint(equalTo:headerView.bottomAnchor)])
        
        headerView.addSubview(imageView)
        headerView.addSubview(writePostButton)
        headerView.addSubview(uploadImageButton)
        return headerView
    }
    
    ///Count models
    func numberOfSections(in tableView: UITableView) -> Int {
        return models.count * 7
    }
    
    ///Sections
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let count = section
        let boxes = 7
        if count == 0 { ///Pinta el collection de imagenes
            model = models[0]
            return 1
        } else { /// Pinta el resto de contenido del post (hader, posts, actions, comments y footer)
            let position = count % boxes == 0 ? count / boxes : ((count - (count % boxes)) / boxes)
            model = models[position]
            let subSection = count % boxes
            switch subSection {
                case 1:  return 1 /// Header
                case 2:  return 1 /// Post
                case 3:  return 1 /// Actions
                case 4:  return 1 /// Description
                case 5:  return 1 /// Comments
                case 6:  return 1 /// Footer
                default:  return 0
            }
        }
    }
    
    ///TablesView
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model: HomeFeedRenderViewModel
        let count = indexPath.section
        let boxes = 7
        if count == 0 { /// Collections
            model = models[0]
            switch model.collections.renderType {
            case .collections(let collections, let createStory):
                let cell = tableView.dequeueReusableCell(withIdentifier: CollectionTableViewCell.identifier, for: indexPath) as! CollectionTableViewCell
                    cell.configure(with: collections, with: createStory)
                    cell.delegate = self
                return cell
            case .comments, .actions, .primaryContent, .header, .descriptions, .footer : return UITableViewCell() }
        } else {
            let position = count % boxes == boxes ? count/boxes : ((count - (count % boxes)) / boxes)
            model = models[position]
            let subSection = count % boxes
            switch subSection {
            case 1:
                switch model.header.renderType {
                case .header(let user):
                    let cell = tableView.dequeueReusableCell(withIdentifier: IGFeedPostHeaderTableViewCell.identifier, for: indexPath) as! IGFeedPostHeaderTableViewCell
                    cell.configure(with: user)
                    return cell
                case .comments, .actions, .primaryContent, .collections, .descriptions, .footer : return UITableViewCell()
                }
            case 2:
                switch model.post.renderType {
                case .primaryContent(let post):
                    let cell = tableView.dequeueReusableCell(withIdentifier: IGFeedPostTableViewCell.identifier,for: indexPath) as! IGFeedPostTableViewCell
                    cell.configure(with: post)
                    return cell
                case .comments, .actions, .header, .collections, .descriptions, .footer : return UITableViewCell()
                }
                
            case 3:
                switch model.actions.renderType {
                case .actions(let provider):
                    let cell = tableView.dequeueReusableCell(withIdentifier: IGFeedPostActionsTableViewCell.identifier, for: indexPath) as! IGFeedPostActionsTableViewCell
                    cell.configure(with: provider)
                    cell.delegate = self
                    return cell
                case .comments, .header, .primaryContent, .collections, .descriptions, .footer : return UITableViewCell()
                }
                
            case 4:
                switch model.descriptions.renderType {
                case .descriptions(let post):
                    let cell = tableView.dequeueReusableCell(withIdentifier: IGFeedPostDescriptionTableViewCell.identifier, for: indexPath) as! IGFeedPostDescriptionTableViewCell
                    cell.configure(with: post)
                    return cell
                case .comments, .header, .primaryContent, .collections, .actions, .footer: return UITableViewCell()
                }
            
            case 5:
                switch model.comments.renderType {
                case .comments(let comments):
                    //let comment = comments[indexPath.row]
                    let count = comments.count
                    let cell = tableView.dequeueReusableCell(withIdentifier: IGFeedPostGeneralTableViewCell.identifier, for: indexPath) as! IGFeedPostGeneralTableViewCell
                    cell.configure(with: count)
                    return cell
                case .header, .actions, .primaryContent, .collections, .descriptions, .footer : return UITableViewCell()
                }
            
            case 6:
                switch model.footer.renderType {
                case .footer(let footer):
                    let cell = tableView.dequeueReusableCell(withIdentifier: IGFeedPostFooterTableViewCell.identifier, for: indexPath) as! IGFeedPostFooterTableViewCell
                    cell.configure(with: footer)
                    cell.delegate = self
                    self.separator(cell: cell)
                    return cell
                case .comments, .header, .primaryContent, .collections, .actions, .descriptions: return UITableViewCell()
                }
                
            default:
                print("error en subSection")
            }
            return UITableViewCell()
        }
    }
    
    ///Did select
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        print("Did select normal list item")
    }
    
    ///Height de Cell
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let section = 7
        if indexPath.section == 0 { return view.height/3 } ///Collections
        else {
            let subSection = indexPath.section % section
            switch subSection {
                case 1:  return  70 /// Header
                case 2:  return  tableView.width /// Post
                case 3:  return  50 /// Actions
                case 4:  return  85 /// Description
                case 5:  return  25 /// Comment
                case 6:  return  60 /// Footer
                default:  return 0
            }
        }
    }
    
    ///Footer
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
    
    ///Footer Table View
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        let section = 7
        let subSection = section % section
        return subSection == 6 ? 20 : 0
    }
    
    ///Set the spacing between sections
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return cellSpacingHeight
    }
}


//MARK: - Keyborad
extension HomeViewController: IGFeedPostFooterTableViewCellDelegate {
    
    func didTapComment(model: Userpost) {
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

    //func didTapCommentButton(model: UserpostViewModel) {
    func didTapCommentButton(model: Userpost) {
        let vc = ListCommentsViewController(model: model)
        vc.title = "Coments"
        vc.navigationItem.largeTitleDisplayMode = .never
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func didTapSendButton() {
        self.settingLauncher.showSettings()
        self.settingLauncher.homeController = self
    }
    
    public func showControllerForSetting(index:Int, setting: Setting) {
        switch index {
            case 0: //Share in your story
                /**let vc = StoryViewController()
                vc.navigationItem.title = setting.name
                vc.modalPresentationStyle = .fullScreen
                vc.navigationItem.largeTitleDisplayMode = .never
                present(UINavigationController(rootViewController: vc), animated: true)*/
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
