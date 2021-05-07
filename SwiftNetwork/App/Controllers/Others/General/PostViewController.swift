//
//  PostViewController.swift
//  Blubinn
//
//  Created by Eddy Donald Chinchay Lujan on 31/3/21.
//

import UIKit

/*
 
 Section
 - Header
 Section
 - Post Cell model
 Section
 - Action Buttons Cell model
 Section
 - n Number general models for comments
 
 */

/// States of render cell
enum PostRenderType {
    case collections(collections: [CollectionTableCellModel])
    case header(provider: User)
    case primaryContent(provider: UserPost) //Post
    case actions(provider: UserPost) // Like, comment, share
    case descriptions(post: UserPost)
    case comments(comments: [PostComments])
    //case comments(post: UserPost)
    case footer(footer: String)
}

/// Model of  renderd Post
struct PostRenderViewModel {
    let renderType: PostRenderType
}

class PostViewController: UIViewController {
    
    private let model: UserPost?
    
    private var renderModels = [PostRenderViewModel]()
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        //let tableView = UITableView(frame: .zero, style: .grouped)
        return tableView
    }()
    
    // MARK: Init Receive data from the ProfileViewcontroller
    init(model: UserPost?) {
        self.model = model
        super.init(nibName: nil, bundle: nil)
        configureModels()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        configureTableView()
        delegateTableView()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }
    
    private func configureModels() {
        /*
        var comments = [PostComments]()
        for x in 0..<4 {
            comments.append(
                PostComments(
                    identifier: "123\(x)",
                    username: "@save",
                    text: "Great post!",
                    createDate: Date(),
                    likes: []
                )
            )
        }
        
        let user = User(
            name: (first: "", last: ""),
            username: "@kanye_west",
            bio: "",
            profilePicture: URL(string: "https://wwww.google.com")!,
            birthDate: Date(),
            gender: .male,
            email: "",
            counts: UserCount(followers: 1, following: 1, posts: 1),
            joinDate: Date())
        
        
        let post = UserPost(
            identifier: "",
            postType: .photo,
            thumbnailImage: URL(string: "https://wwww.google.com")!,
            postURL: URL(string: "https://wwww.google.com")!,
            caption: "Esto es un titlo del post para un ejemplo en el Iphone de hacer proueba y test",
            likeCount: [],
            comments: comments,
            createDate: Date(),
            taggedUsers: [],
            owner:  user)*/
        
        guard let userPostModel = self.model else {
            return
        }
        
        
        /// Header
        renderModels.append(PostRenderViewModel(renderType: .header(provider: userPostModel.owner )))
        ///Post
        renderModels.append(PostRenderViewModel(renderType: .primaryContent(provider: userPostModel)))
        ///Actions
        renderModels.append(PostRenderViewModel(renderType: .actions(provider: userPostModel))) //post
        ///Description
        renderModels.append(PostRenderViewModel(renderType: .descriptions(post: userPostModel))) //post
        ///comment
        renderModels.append(PostRenderViewModel(renderType: .comments(comments: userPostModel.comments))) //comments
    }
    
    private func setupView() {
        view.backgroundColor = .systemBackground
        view.addSubview(tableView)
    }
    
    private func configureTableView() {
        tableView.backgroundColor = .secondarySystemFill
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
}

extension PostViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return renderModels.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch renderModels[section].renderType {
        case .actions(_):  return 1
        case .comments(let comments): return comments.count > 0 ? comments.count : comments.count
        case .primaryContent(_):  return 1
        case .header(_):  return 1
        case .descriptions(_):  return 1
        case .footer(_): return 1
        case .collections(_): return 1
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = renderModels[indexPath.section]
        
        switch model.renderType {
        case .actions(_/**let actions**/):
            let cell = tableView.dequeueReusableCell(withIdentifier: IGFeedPostActionsTableViewCell.identifier, for: indexPath) as! IGFeedPostActionsTableViewCell
            return cell
        case .comments(let comments):
            let comment = comments[indexPath.row] ///Se obtiene cada fila del array de comments
            let cell = tableView.dequeueReusableCell(withIdentifier: IGFeedPostGeneralTableViewCell.identifier, for: indexPath) as! IGFeedPostGeneralTableViewCell
            cell.configure(with: comment)
            return cell
        case .primaryContent(let post):
            let cell = tableView.dequeueReusableCell(withIdentifier: IGFeedPostTableViewCell.identifier, for: indexPath) as! IGFeedPostTableViewCell
            cell.configure(with: post)
            return cell
        case .header(let user):
              let cell = tableView.dequeueReusableCell(withIdentifier: IGFeedPostHeaderTableViewCell.identifier,for: indexPath) as! IGFeedPostHeaderTableViewCell
            cell.configure(with: user)
            cell.backgroundColor = .red
            return cell
        case .descriptions(let post):
            let cell = tableView.dequeueReusableCell(withIdentifier: IGFeedPostDescriptionTableViewCell.identifier, for: indexPath) as! IGFeedPostDescriptionTableViewCell
            cell.configure(with: post)
            return cell
        case .footer(_/**let footer**/):
            let cell = tableView.dequeueReusableCell(withIdentifier: IGFeedPostFooterTableViewCell.identifier, for: indexPath) as! IGFeedPostFooterTableViewCell
            return cell
        case .collections(_/**let collections**/):
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let model = renderModels[indexPath.section]
        switch model.renderType {
        case .actions(_): return 60 ///Actions
        case .comments(_): return 30 ///Comments
        case .primaryContent(_): return tableView.width ///Post
        case .header(_): return 70 ///Hader
        case .descriptions(_): return 90 ///Descriptions
        case .collections(_): return 50 ///Collections
        case .footer(_): return 50 ///Footer
        }
    }
}
