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

class TimeLineViewController: UIViewController {

    private var models = [HomeFeedRenderViewModel]()

    var commentarios: [PostComments] = []
    
    private let tableView: UITableView = {
        //let tableView = UITableView(frame: .zero, style: .grouped)
        let tableView = UITableView()
        //tableView.backgroundColor = .systemBackground
        tableView.register(IGFeedPostTableViewCell.self, forCellReuseIdentifier: IGFeedPostTableViewCell.identifier)
        tableView.register(IGFeedPostHeaderTableViewCell.self, forCellReuseIdentifier: IGFeedPostHeaderTableViewCell.identifier)
        tableView.register(IGFeedPostActionsTableViewCell.self, forCellReuseIdentifier: IGFeedPostActionsTableViewCell.identifier)
        tableView.register(IGFeedPostDescriptionTableViewCell.self, forCellReuseIdentifier: IGFeedPostDescriptionTableViewCell.identifier)
        tableView.register(IGFeedPostGeneralTableViewCell.self, forCellReuseIdentifier: IGFeedPostGeneralTableViewCell.identifier)
        tableView.register(IGFeedPostFooterTableViewCell.self, forCellReuseIdentifier: IGFeedPostFooterTableViewCell.identifier)
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
        setupModels()
        configureTableView()
        delegateTableView()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }
    
    private func setup() {
        view.addSubview(tableView)
        tableView.tableHeaderView = createTableHeader()
    }
    
    private func configureTableView() {
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.register(CollectionTableViewCell.self, forCellReuseIdentifier: CollectionTableViewCell.identifier)
        tableView.separatorStyle = .none
    }
    
    private func delegateTableView() {
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    
    private func createTableHeader() -> UIView? {
        let headerView = UIView(
            frame: CGRect(
                x: 0,
                y: 0,
                width: view.width,
                height: 100))
        headerView.backgroundColor = .systemBackground
        view.addSubview(headerView)
        
        let imageView = UIImageView(image: UIImage(systemName: "person.circle"))
        imageView.tintColor = .systemBlue
        imageView.contentMode = .scaleAspectFit
        headerView.addSubview(imageView)
        imageView.frame = CGRect(x: 5, y: 5, width: headerView.height-10, height: headerView.height-10)
        
        let textField = UITextField()
        textField.placeholder = "¿Eddy, en que piensas?"
        textField.frame = view.bounds
        textField.layer.borderWidth = 1
        textField.layer.cornerRadius = 12
        textField.layer.borderColor = UIColor.systemGray.cgColor
        textField.textColor = .black
        textField.font = .systemFont(ofSize: 22, weight: .thin)
        headerView.addSubview(textField)
        
        textField.frame = CGRect(
            x: 10+imageView.width,
            y: 10,
            width: headerView.width-20-imageView.width,
            height: headerView.height-20)
        return headerView
    }
    
    
    func createArrayComments() -> [PostComments] {
        
        var tempComments: [PostComments] = []
        for i in 0..<5 {
            let comments = PostComments(identifier: "id-\(i)", username: "\(i) Username", text: "commentario \(i)", createDate: Date(), likes: [])
            tempComments.append(comments)
        }
        /*let comments1 = PostComments(identifier: "", username: "Paola", text: "Primer commentario", createDate: Date(), likes: [])
        let comments2 = PostComments(identifier: "", username: "Jordan", text: "Segundo comentario", createDate: Date(), likes: [])
        let comments3 = PostComments(identifier: "", username: "Rebeca", text: "Tercer comentario", createDate: Date(), likes: [])
        let comments4 = PostComments(identifier: "", username: "Tessy", text: "Cuarto comentario", createDate: Date(), likes: [])
        let comments5 = PostComments(identifier: "", username: "Teresa", text: "Quinto comentario", createDate: Date(), likes: [])
        let comments6 = PostComments(identifier: "", username: "Maria", text: "Sexto comentario", createDate: Date(), likes: [])*/
        
        /*tempComments.append(comments2)
        tempComments.append(comments3)
        tempComments.append(comments4)
        tempComments.append(comments5)
        tempComments.append(comments6)*/
        return tempComments
    }
    
    
    
    
    private func setupModels() {
        var collections = [CollectionTableCellModel]()
        for i in 0..<5 {
            let data = CollectionTableCellModel(title: "Text \(i)", imageName: "test")
            collections.append(data)
        }
        
        
        ///Los likes se añade al objeto UserPost
        var likes = [PostLike]()
        for i in 0..<5 {
            let data = PostLike(
                username: "jor \(i)",
                postIdentifier: "",
                text: "Mi primera publicacion para el test de la App.",
                likes: i)
            likes.append(data)
        }
        
        ///Los comentarios se añade al objeto UserPost
        /*var comments = [PostComments]()
        for i in 0..<3 {
            comments.append(PostComments(
                identifier: "\(i)",
                username: "username \(i)",
                text: "\(i) Esta es la mejor publicación que he visto",
                createDate: Date(),
                likes: []))
        }*/
        
        commentarios = createArrayComments()
        
        ///Count Post
        let countPost = 2
        for i in 0..<countPost {
            ///El usuario se añade al objeto UserPost
            let user = User(
                name: (first: "", last: ""),
                username: "@kanye_west \(i)",
                bio: "",
                profilePicture: URL(string: "https://wwww.google.com")!,
                birthDate: Date(),
                gender: .male,
                email: "",
                counts: UserCount(followers: 1, following: 1, posts: 1),
                joinDate: Date())
            
            ///User post
            let post = UserPost(
                identifier: "",
                postType: .photo,
                thumbnailImage: URL(string: "https://wwww.google.com")!,
                postURL: URL(string: "https://wwww.google.com")!,
                caption: "Esto es un titlo del post para un ejemplo en el Iphone de hacer proueba y test",
                likeCount: likes,
                comments: commentarios,
                createDate: Date(),
                taggedUsers: [],
                owner: user )
            
            
            let viewModel = HomeFeedRenderViewModel(
                collections: PostRenderViewModel(renderType: .collections(collections: collections)) ,
                header: PostRenderViewModel(renderType: .header(provider: user)),
                post: PostRenderViewModel(renderType: .primaryContent(provider: post)),
                actions: PostRenderViewModel(renderType: .actions(provider: "")),
                descriptions: PostRenderViewModel(renderType: .descriptions(post: post)),
                comments: PostRenderViewModel(renderType: .comments(comments: commentarios)),
                //comments: PostRenderViewModel(renderType: .comments(post: post)),
                footer: PostRenderViewModel(renderType: .footer(footer: ""))
            )
            models.append(viewModel)
        }
    }
}

extension TimeLineViewController: UITableViewDelegate, UITableViewDataSource {
    
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
                        return comments.count > 0 ? comments.count : comments.count /// Retorna el total de comentarios
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
                    case .actions(_/*let provider*/):
                        let cell = tableView.dequeueReusableCell(
                            withIdentifier: IGFeedPostActionsTableViewCell.identifier,
                            for: indexPath) as! IGFeedPostActionsTableViewCell
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
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 { return 280 }
        else {
            let subSection = indexPath.section % 7
            if subSection        == 1 { return 70 } /// Header
            else if subSection   == 2 { return tableView.width } /// Post
            else if subSection   == 3 { return 60 }  /// Actions
            else if subSection   == 4 { return 100 } /// Description
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

extension TimeLineViewController: CollectionTableViewCellDelegate {
    func didSelectItem(with model: CollectionTableCellModel) {
        print("Selected \(model.title)")
    }
}

extension TimeLineViewController: IGFeedPostActionsTableViewCellDelegate {
    func didTapLikeButton() {
        print("like")
    }
    
    func didTapCommentButton() {
        //let vc = PostViewController(model: post)
        let vc = ListCommentsViewController()
        vc.title = "Coments"
        vc.navigationItem.largeTitleDisplayMode = .never
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func didTapSendButton() {
        print("Send")
    }
}
