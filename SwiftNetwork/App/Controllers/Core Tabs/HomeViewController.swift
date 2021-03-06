//
//  TimeLineViewController.swift
//  SwiftNetwork
//
//  Created by Eddy Donald Chinchay Lujan on 25/4/21.
//

import UIKit


struct HomeFeedRenderViewModel {
    ///let collections: PostRenderViewModel
    let header: PostRenderViewModel
    let post: PostRenderViewModel
    let actions: PostRenderViewModel
    let descriptions: PostRenderViewModel
    let comments: PostRenderViewModel
    let footer: PostRenderViewModel
}

//MARK: -  FETCHING CORE DATA
//extension HomeViewController {
//    ///Api Rest.
//    ///Hacemos una llamada al Api rest.
//    ///Una vez obtenido los datos que queremos, se lo enviamos a la funcion setuModel.
//    private func fetchUserPost() {
//        APIService.shared.apiUserPost(token: getUserToken()?.token ?? "" ) {(result) in
//            switch result {
//            case .success(let model):
//                model.userpost?.count != 0 ? self.setupModel(with: model.userpost ?? []) : print("Array Userpost está vacio...")
//            case .failure(let error):
//                print(error.localizedDescription)
//            }
//        }
//    }
//
//    ///Models
//    ///Está función revcibe los datos para tratarlos y guardalos en el array Modelo.
//    private func setupModel(with model: [Userpost] ) {
//
//        for items in model {
//            guard let user = items.userAuthor else { return }
//            guard let comments = items.comments else { return }
//            let viewModel = HomeFeedRenderViewModel(
//                //collections : PostRenderViewModel(renderType: .collections(collections:  self.createStoryCollections(), createStory: self.createArrayCollections())),
//                header      : PostRenderViewModel(renderType: .header(provider: user)),
//                post        : PostRenderViewModel(renderType: .primaryContent(provider: items)),
//                actions     : PostRenderViewModel(renderType: .actions(provider: items)),
//                descriptions: PostRenderViewModel(renderType: .descriptions(post: items)),
//                comments    : PostRenderViewModel(renderType: .comments(comments: comments)),
//                footer      : PostRenderViewModel(renderType: .footer(footer: items)))
//            self.models.append(viewModel)
//        }
//
//        DispatchQueue.main.async {
//            ///SpinnerView.shared.spinner.stopAnimating()
//            ///SpinnerView.shared.VW_overlay.isHidden = true
//            CustomLoader.instance.hideLoader()
//            self.tableView.reloadData()
//        }
//    }
//}


//MARK: HomeViewController
class HomeViewController: UIViewController {
    
    let cellSpacingHeight: CGFloat = 5
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        return tableView
    }()
    
    private let tableMenuView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        return tableView
    }()
    
    lazy var settingLauncher: SettingsLauncher = {
        let launcher = SettingsLauncher()
        launcher.homeController = self
        return launcher
    }()
    
    
    
    public var models = [HomeFeedRenderViewModel]()
    
    var model : HomeFeedRenderViewModel?
    
    //private var models = [HomeFeedRenderViewModel]()
    
<<<<<<< HEAD
    //private var userpost = [Userpost]()
=======
    private var token = Token()
    
>>>>>>> recover-branch
    
<<<<<<< HEAD
    let viewContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
=======
    
    private var viewModel = UserpostViewModel()
    private var likeViewModel = LikeViewModel()
>>>>>>> parent of 684acd5... Post update caption
    
    //Core data
    var cd0011_posts: [CD0011_posts]? {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    let database = DatabaseHandler.shared

    // MARK: viewDidLoad()
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        delegateTableMenuView()
        configureTableView()
        headerTableView()
        setupNavigationBarItems()
        configureSpinner()
        ///loadUserpostData()
        
        pruebaApiRest()
    }
    
<<<<<<< HEAD
  
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.tabBar.isHidden = false
        //Esto se ejecuta despues de pruebaApiRest()
        //print(">_ viewWillAppear")
        
    }
    
<<<<<<< HEAD
    
    func pruebaApiRest()  {
        database.deleteAllRecords(object: cd0011_posts ?? [])
        //print(">_ despues del borrado")
        guard let token = getUserToken()?.token else { return }
        viewModel.syncUsersPost(token: token) {
            //let userpost = self.database.fetch(CD0011_posts.self)
            //for items in userpost {
                ///print("------------------------------  [ USERPOT : \(items.id) ]  ------------------------------ ")
                ///print("Post Title => \(items.title ?? "")")
                ///print(items.taggeds ?? [])
            ///}
=======
    //MARK: Load User Post data
    private func loadUserpostData() {
        guard let token = token.getUserToken().token else { return }
        viewModel.fetchUserpostData(token: token) {
>>>>>>> recover-branch
            self.tableView.dataSource = self
            self.tableView.delegate = self
            DispatchQueue.main.async {
                CustomLoader.instance.hideLoader()
                self.tableView.reloadData()
            }
        }
    }

    ///Load data.
    ///Llamamos al viewModel para traer los datos.
    /*private func loadUserpostData() {
        guard let token = getUserToken()?.token else { return }
        viewModel.fetchUserpostData(token: token) {
=======
    private func loadUserpostData() {
        guard let token = getUserToken()?.token else {
            return
        }
        viewModel.fetchUserPostData(token: token) {
>>>>>>> parent of 684acd5... Post update caption
            self.tableView.dataSource = self
            self.tableView.delegate = self
            DispatchQueue.main.async {
                CustomLoader.instance.hideLoader()
                self.tableView.reloadData()
            }
        }
<<<<<<< HEAD
    }*/
        
    // viewDidLayoutSubviews
=======
    }
    
<<<<<<< HEAD
    
>>>>>>> parent of 684acd5... Post update caption
=======
    // ViewDidLayoutSubviews
>>>>>>> recover-branch
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = tableView.frame.inset(by: UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8))
        tableView.frame = view.bounds
    }
    
<<<<<<< HEAD
<<<<<<< HEAD

    // Setupview
=======
=======
    // ViewWillAppear
>>>>>>> recover-branch
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.tabBar.isHidden = false
    }
    
<<<<<<< HEAD
    ///Inicio del programa.
    ///Setupview
>>>>>>> parent of 684acd5... Post update caption
=======
    // setupView
>>>>>>> recover-branch
    private func setupView() {
        view.backgroundColor = .systemBackground
        tableView.backgroundColor = .systemBackground
        view.addSubview(tableView)
    }

    // Spinner
<<<<<<< HEAD
    // Muestra el spiner mientras los datos de van cargando...
=======
>>>>>>> recover-branch
    private func setupSpinner() -> UIActivityIndicatorView {
        let spinerView = SpinnerView.shared.setupSpinner()
        spinerView.center = view.center
        SpinnerView.shared.VW_overlay = UIView(frame: UIScreen.main.bounds)
        SpinnerView.shared.VW_overlay.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.5)
        return spinerView
    }
    
    private func configureSpinner() {
        CustomLoader.instance.viewColor = UIColor.systemBackground
        CustomLoader.instance.setAlpha = 0.8
        CustomLoader.instance.gifName = Constants.Spinner.spinner
        showSpinner()
    }
    
    // Spinner
    // Muestra el spiner mientras los datos de van cargando...
    private func showSpinner() {
        CustomLoader.instance.showLoader()
    }
    
<<<<<<< HEAD
    // Obtenemos el Token de la App.
    public func getUserToken() -> ResponseTokenBE? {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        guard let token = appDelegate.objUsuarioSesion else {
            return getUserToken()
        }
        return token
    }

=======
    
>>>>>>> recover-branch
    
    
    // Creamos el Header en el ViewController.
    private func headerTableView() {
        tableView.tableHeaderView = createTableHeaderView()
    }
    
    // Configuramos y registramos los TableViews
    private func configureTableView() {
        //tableView.register(CollectionTableViewCell.self, forCellReuseIdentifier: CollectionTableViewCell.identifier)
        
        tableView.register(IGFeedPostTableViewCell.self, forCellReuseIdentifier: IGFeedPostTableViewCell.identifier)
        tableView.register(IGFeedPostHeaderTableViewCell.self, forCellReuseIdentifier: IGFeedPostHeaderTableViewCell.identifier)
        tableView.register(IGFeedPostActionsTableViewCell.self, forCellReuseIdentifier: IGFeedPostActionsTableViewCell.identifier)
        tableView.register(IGFeedPostDescriptionTableViewCell.self, forCellReuseIdentifier: IGFeedPostDescriptionTableViewCell.identifier)
        tableView.register(IGFeedPostGeneralTableViewCell.self, forCellReuseIdentifier: IGFeedPostGeneralTableViewCell.identifier)
        tableView.register(IGFeedPostFooterTableViewCell.self, forCellReuseIdentifier: IGFeedPostFooterTableViewCell.identifier)
        tableView.separatorStyle = .none
    }
    
    // Configuramos los delegates de ambas tables view
    private func delegateTableMenuView() {
        tableMenuView.delegate = self
        tableMenuView.delegate = self
    }
    
    // Creamos StoryCollections
    // Boton se crear historia.
    func createStoryCollections() -> [CollectionTableCellModel] {
        var collections = [CollectionTableCellModel]()
        let data = CollectionTableCellModel(title: "eddy", imageName: "eddy")
        collections.append(data)
        return collections
    }
    
    // Resto de collections.
    func createArrayCollections() -> [CollectionTableCellModel] {
        var collections = [CollectionTableCellModel]()
        let username = ["eddylujann", "jordann", "paola","rebeca", "jeremy", "lucas"]
        for i in 0..<username.count {
            let data = CollectionTableCellModel(title: username[i], imageName: "img\(i+1)")
            collections.append(data)
        }
        return collections
    }
    
    // Navegacion bar items
    // Left & Right.
    private func setupNavigationBarItems() {
        setupLeftNavItems()
        setupRightNavItems()
        ///setupRemaningNavItems()
    }
    
    // Creamos el separador al final de cada post.
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
    
    // Button de  crear un nuevo post.
    @objc private func didTapWritePostButton() {
        let vc = PublishPostViewController()
        vc.title = "Create Post"
        vc.modalPresentationStyle = .fullScreen
        vc.navigationItem.largeTitleDisplayMode = .never
        present(UINavigationController(rootViewController: vc), animated: true)
    }
}

//MARK:  - TABLEVIEW
extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    
    // COUNT
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.numberOfSections() * 7
    }
    
    // SECTION
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let count = section
        let boxes = 7
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
    
    // TABLEVIEW
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model: HomeFeedRenderViewModel
        let count = indexPath.section
        let boxes = 7
        let position = count % boxes == boxes ? count/boxes : ((count - (count % boxes)) / boxes)
        model = viewModel.models[position]
        let subSection = count % boxes
            
        switch subSection {
            
            // HEADER
            case 1:
                switch model.header.renderType {
                case .header(let user):
                    let cell = tableView.dequeueReusableCell(withIdentifier: IGFeedPostHeaderTableViewCell.identifier, for: indexPath) as! IGFeedPostHeaderTableViewCell
                    cell.configure(with: user)
                    cell.delegate = self
                    return cell
                case .comments, .actions, .primaryContent, .collections, .descriptions, .footer : return UITableViewCell()
                }
            
            // POST
            case 2:
                switch model.post.renderType {
                case .primaryContent(let post):
                    let cell = tableView.dequeueReusableCell(withIdentifier: IGFeedPostTableViewCell.identifier,for: indexPath) as! IGFeedPostTableViewCell
                    cell.configure(with: post)
                    return cell
                case .comments, .actions, .header, .collections, .descriptions, .footer : return UITableViewCell()
                }
                
            // ACTION
            case 3:
                switch model.actions.renderType {
                case .actions(_):
                    let cell = tableView.dequeueReusableCell(withIdentifier: IGFeedPostActionsTableViewCell.identifier, for: indexPath) as! IGFeedPostActionsTableViewCell
                    cell.delegate = self
                    return cell
                case .comments, .header, .primaryContent, .collections, .descriptions, .footer : return UITableViewCell()
                }
                
            // DESCRIPTION
            case 4:
                switch model.descriptions.renderType {
                case .descriptions(let post):
                    let cell = tableView.dequeueReusableCell(withIdentifier: IGFeedPostDescriptionTableViewCell.identifier, for: indexPath) as! IGFeedPostDescriptionTableViewCell
                    cell.setCellWithValuesOf(post)
                    return cell
                case .comments, .header, .primaryContent, .collections, .actions, .footer: return UITableViewCell()
                }
            
            // COMMENT
            case 5:
                switch model.comments.renderType {
                case .comments(let comments):
                    let count = comments.count
                    let cell = tableView.dequeueReusableCell(withIdentifier: IGFeedPostGeneralTableViewCell.identifier, for: indexPath) as! IGFeedPostGeneralTableViewCell
                    cell.configure(with: count)
                    return cell
                case .header, .actions, .primaryContent, .collections, .descriptions, .footer : return UITableViewCell()
                }
            
            // FOOTER
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
            
            // DEFAULT
            default: print("error en subSection")
        }
        return UITableViewCell()
    }
    
    // DID SELECT
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let boxes = 7
        let count = indexPath.section
        let position = count % boxes == boxes ? count/boxes : ((count - (count % boxes)) / boxes)
        let model = viewModel.models[position]
        let render = model.post.renderType
        
        let subSection = count % boxes
        switch subSection {
        ///Sub section header
        case 1:
            switch render {
            case .primaryContent(let userpost):
                guard let email = userpost.userAuthor?.email,
                      let name = userpost.userAuthor?.name else {
                    return
                }
                guard let token = token.getUserToken().token else {
                    return
                }
                let vc = UserPostViewController(email: email, token: token )
                vc.title = name
                navigationController?.pushViewController(vc, animated: true)
            default:
                print("Error...")
            }
        ///Sub section post image.
        case 2:
            print("image")
            
        ///Sub section actions.
        case 3:
            print("actions")
            //guard let btn = (tableView.cellForItem(at: indexPath) as! yourCellName).button else {
              //  return
            //}
        
            ///let btn = (tableView.cellForRow(at: indexPath) as! IGFeedPostActionsTableViewCell).likeButton
            ///btn.setImage(UIImage(named: "yourSelectedImage name"), for: .normal)
            ///btn.tintColor = .systemGreen
            
        ///Sub section post description.
        case 4:
            print("description")
            
        ///Sub section general.
        case 5:
            print("general")
            
        ///Sub section footer.
        case 6:
            print("footer")
            
        default:
            print("error...")
        }
    }
    
    // HEIGHT TABLE
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let section = 7
            let subSection = indexPath.section % section
            switch subSection {
                case 1:  return  70              // Header
                case 2:  return  tableView.width // Post
                case 3:  return  50              // Actions
                case 4:  return  85              // Description
                case 5:  return  25              // Comment
                case 6:  return  60              // Footer
                default:  return 0
            }
    }
    
    // FOOTER TABLEVIEW
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
    
    // FOOTER TABLEVIEW
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        let section = 7
        let subSection = section % section
        return subSection == 6 ? 20 : 0
    }
    
    // SPACING HEADER
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return cellSpacingHeight
    }
    
    // HEADER
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
<<<<<<< HEAD
    
    // Count models
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.numberOfSections() * 7
    }
    
    // Sections
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let count = section
        let boxes = 7
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
    
    // TableView
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model: HomeFeedRenderViewModel
        let count = indexPath.section
        let boxes = 7
        let position = count % boxes == boxes ? count/boxes : ((count - (count % boxes)) / boxes)
        model = viewModel.models[position]
        let subSection = count % boxes
            
        switch subSection {
            // HEADER
            case 1:
                switch model.header.renderType {
                case .header(let post):
                    let cell = tableView.dequeueReusableCell(withIdentifier: IGFeedPostHeaderTableViewCell.identifier, for: indexPath) as! IGFeedPostHeaderTableViewCell
                    cell.setCellWithValuesOf(with: post)
                    //cell.delegate = self
                    return cell
                case .comments, .actions, .primaryContent, .collections, .descriptions, .footer : return UITableViewCell()
                }
            
            // POST
            case 2:
                switch model.post.renderType {
                case .primaryContent(let post):
                    let cell = tableView.dequeueReusableCell(withIdentifier: IGFeedPostTableViewCell.identifier,for: indexPath) as! IGFeedPostTableViewCell
                    let modelImage = viewModel.fetchPrimaryContent(post: post)
                    cell.configure(image: modelImage)
                    return cell
                case .comments, .actions, .header, .collections, .descriptions, .footer : return UITableViewCell()
                }
                
            // ACTION
            case 3:
                switch model.actions.renderType {
                case .actions(_/*let provider*/):
                    let cell = tableView.dequeueReusableCell(withIdentifier: IGFeedPostActionsTableViewCell.identifier, for: indexPath) as! IGFeedPostActionsTableViewCell
                    guard let ref_id = provider.id,
                          let users_id = getUserToken()?.usertoken?.id,
                          let token = getUserToken()?.token else {
                        return UITableViewCell()
                    }
                    
                    self.likeViewModel.liked(ref_id: ref_id, users_id: users_id, token: token) {(result) in
                        switch result {
                        case .success(let liked):
                            cell.setCellWithValuesOf(provider, liked: liked)
                        case .failure(let error):
                            print(error.localizedDescription)
                        }
                    }
                    cell.delegate = self
                    return cell
                case .comments, .header, .primaryContent, .collections, .descriptions, .footer : return UITableViewCell()
                }
                
            // DESCRIPTION
            case 4:
                switch model.descriptions.renderType {
                case .descriptions(let post):
                    let cell = tableView.dequeueReusableCell(withIdentifier: IGFeedPostDescriptionTableViewCell.identifier, for: indexPath) as! IGFeedPostDescriptionTableViewCell
<<<<<<< HEAD
                    let countLikes      = viewModel.countLikes(model: post, like: post.likes)
                    let countComments   = viewModel.countComments(model: post, comment: post.comments)
                    let username        = viewModel.getUsername(post: post)
                    let content         = viewModel.getContent(post: post)
                    let imageHeader     = viewModel.getImageHeader(post: post)
                    cell.setCellWithValuesOf(countLikes: countLikes, countComments: countComments, username: username, content: content, image: imageHeader)
=======
                    //cell.configure(with: post)
                    cell.setCellWithValuesOf(post)
>>>>>>> parent of 684acd5... Post update caption
                    return cell
                case .comments, .header, .primaryContent, .collections, .actions, .footer: return UITableViewCell()
                }
                
            // COMMENTS
            case 5:
                switch model.comments.renderType {
<<<<<<< HEAD
                case .comments(_):
=======
                case .comments(let comments):
                    //let comment = comments[indexPath.row]
                    let count = comments.count
>>>>>>> parent of 684acd5... Post update caption
                    let cell = tableView.dequeueReusableCell(withIdentifier: IGFeedPostGeneralTableViewCell.identifier, for: indexPath) as! IGFeedPostGeneralTableViewCell
                    cell.setCellWithValuesOf()
                    return cell
                case .header, .actions, .primaryContent, .collections, .descriptions, .footer : return UITableViewCell()
                }
            
            // FOOTER
            case 6:
                switch model.footer.renderType {
                case .footer(let footer):
                    let cell = tableView.dequeueReusableCell(withIdentifier: IGFeedPostFooterTableViewCell.identifier, for: indexPath) as! IGFeedPostFooterTableViewCell
                    let imageHeader = viewModel.getImageHeader(post: footer)
                    cell.setCellWithValuesOf(image: imageHeader)
                    cell.delegate = self
                    self.separator(cell: cell)
                    return cell
                case .comments, .header, .primaryContent, .collections, .actions, .descriptions: return UITableViewCell()
                }
                
            default: print("error en subSection")
<<<<<<< HEAD
        }
        return UITableViewCell()
=======
            }
            return UITableViewCell()
        //}
        
        
>>>>>>> parent of 684acd5... Post update caption
    }
    
    // DID SELECT ROW
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let boxes = 7
        let count = indexPath.section
        let position = count % boxes == boxes ? count/boxes : ((count - (count % boxes)) / boxes)
        let model = viewModel.models[position]
        let render = model.post.renderType
        let subSection = count % boxes
        
        switch subSection {
        case 1:
            switch render {
            case .primaryContent(let post):
                guard let email = post.userAuthor?.cd01_email,
                      let name = post.userAuthor?.cd01_name else {
                          return
                      }
                let vc = UserPostViewController(author_ref_id: Int(post.author_ref_id), email: email, token: getUserToken()?.token ?? "")
                vc.title = name
                navigationController?.pushViewController(vc, animated: true)
            default:
                print("Error...")
            }
        ///Sub section post image.
        case 2:
            print("image")
            
        ///Sub section actions.
        case 3:
            print("actions")
            //guard let btn = (tableView.cellForItem(at: indexPath) as! yourCellName).button else {
              //  return
            //}
        
            ///let btn = (tableView.cellForRow(at: indexPath) as! IGFeedPostActionsTableViewCell).likeButton
            ///btn.setImage(UIImage(named: "yourSelectedImage name"), for: .normal)
            ///btn.tintColor = .systemGreen
            
        ///Sub section post description.
        case 4:
            print("description")
            
        ///Sub section general.
        case 5:
            print("general")
            
        ///Sub section footer.
        case 6:
            print("footer")
            
        default:
            print("error...")
        }
    }
    
    ///Height de Cell
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let section = 7
        //if indexPath.section == 0 { return view.height/3 } ///Collections
        //else {
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
        //}
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
=======
>>>>>>> recover-branch
}


//MARK: - KEYBOARD
extension HomeViewController: IGFeedPostFooterTableViewCellDelegate {
    
    func didTapComment(model: Userpost) {
        let vc = ListCommentsViewController(model: model)
        vc.title = "Coments"
        vc.navigationItem.largeTitleDisplayMode = .never
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension HomeViewController: CollectionTableViewCellDelegate {
 
    // Show all story in list or collections
    func didPushUpStoryButton() {
        let vc = SettingStoryViewController()
        let navVC = UINavigationController(rootViewController: vc)
        navVC.modalPresentationStyle = .fullScreen
        navVC.navigationItem.largeTitleDisplayMode = .never
        present(navVC, animated: true)
    }
    
    // Create story and collections the images
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


//MARK: - ACTIONS BUTTONS
extension HomeViewController: IGFeedPostActionsTableViewCellDelegate {
    
    /**
     Tap like.
     Verificamos si el usuario conectado ha dado like a los post que está viendo en el momento.
     - Parameter sender: event button
     - Parameter model: Userpost
     */
    func didTapLikeButton(_ sender: UIButton, model: Userpost) {
        guard let button = sender as? HeartButton else { return }
        guard let type_id = model.posttTypeID,
              let ref_id = model.id,
              let users_id = getUserToken()?.usertoken?.id,
              let token = getUserToken()?.token else {
            return
        }
        APIService.shared.apiLiked(ref_id: ref_id, users_id:users_id, token: token ) {( result ) in
            switch result {
            case .success(let message):
                if message.store == "true" {
                    button.flipDisLikedState()
                    self.liked(type_id: type_id, ref_id: ref_id, users_id: users_id, isLiked: false, token: token)
                } else {
                    button.flipLikedState()
                    self.liked(type_id: type_id, ref_id: ref_id, users_id: users_id, isLiked: true, token: token)
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    
    /**
     Insertamos o eliminamos el liked.
     - Parameter type_id: Int
     - Parameter ref_id: Int
     - Parameter users_id: Int
     - Parameter isLiked: Bool
     - Parameter token: String
     */
    private func liked(type_id:Int, ref_id: Int, users_id:Int, isLiked:Bool, token: String) {
        /*APIService.shared.apiLike(type_id:type_id, ref_id: ref_id, users_id:users_id, isLiked:isLiked, token: token) {( result ) in
            switch result {
            case .success(let message):
                print(message)
                /**cuando el usuario desliza el dedo elimina una fila de vista de tabla, entonces
                debería eliminar los datos de la base de datos, la matriz del modelo de datos y actualizar la interfaz de usuario de la vista de tabla.*/
                /**
                let tasktoDelete = tasks[indexPath.row]
                try! realmDB.write({
                    realmDB.delete(tasktoDelete)
                    self.tasks.remove(at: indexPath.row)
                    self.tasktv.deleteRows(at: [indexPath], with: .fade)
                })
                */
            case .failure(let error):
                print(error.localizedDescription)
            }
        }*/
    }
    
    /**
     Tap Comment
     Insertamos o eliminamos el liked.
     - Parameter model: Userpost
     */
    func didTapCommentButton(model: Userpost) {
        let vc = ListCommentsViewController(model: model)
        vc.title = "Coments"
        vc.navigationItem.largeTitleDisplayMode = .never
        navigationController?.pushViewController(vc, animated: true)
    }
    
    /**
     Insertamos o eliminamos el liked.
     - Parameter model: Userpost
     */
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

<<<<<<< HEAD
/*extension HomeViewController: IGFeedPostHeaderTableViewCellDelegate {
    func didTapMoreButton(post: Userpost) {
=======
extension HomeViewController: IGFeedPostHeaderTableViewCellDelegate {
    func didTapMoreButton() {
>>>>>>> parent of 684acd5... Post update caption
        print("clispp")
    }
}*/

