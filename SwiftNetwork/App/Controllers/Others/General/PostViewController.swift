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
/*enum PostRenderType {
    case collections(collections: [CollectionTableCellModel], createStory: [CollectionTableCellModel])
    case header(provider: UserViewModel)
    case primaryContent(provider: UserpostViewModel)
    case actions(provider: UserpostViewModel)
    case descriptions(post: UserpostViewModel)
    case comments(comments: [CommentViewModel])
    case footer(footer: UserpostViewModel)
}*/

enum PostRenderType {
    case collections(collections: [CollectionTableCellModel], createStory: [CollectionTableCellModel])
    case header(provider: User)
    case primaryContent(provider: Userpost)
    case actions(provider: Userpost)
    case descriptions(post: Userpost)
    case comments(comments: [Comment])
    case footer(footer: Userpost)
}

/// Model of  renderd Post
struct PostRenderViewModel {
    let renderType: PostRenderType
}

class PostViewController: UIViewController {
    
    private let model: Userpost?
    
    private var renderModels = [PostRenderViewModel]()
    
    private let tableView: UITableView = {  		
        let tableView = UITableView()
        //let tableView = UITableView(frame: .zero, style: .grouped)
        return tableView
    }()
    
    // MARK: Init Receive data from the ProfileViewcontroller
    init(model: Userpost?) {
        self.model = model
        super.init(nibName: nil, bundle: nil)
        
        guard let model = model else {
            return
        }
        self.setupModel(with: model)
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
    
    ///Models
    ///Está función revcibe los datos para tratarlos y guardalos en el array Modelo.
    private func setupModel(with model: Userpost ) {
        guard let ownew = model.userAuthor else { return }
        guard let comments = model.comments else { return }
        renderModels.append(PostRenderViewModel(renderType: .header(provider: ownew)))
        renderModels.append(PostRenderViewModel(renderType: .primaryContent(provider: model)))
        renderModels.append(PostRenderViewModel(renderType: .actions(provider: model)))
        renderModels.append(PostRenderViewModel(renderType: .descriptions(post: model)))
        renderModels.append(PostRenderViewModel(renderType: .comments(comments: comments)))
        renderModels.append(PostRenderViewModel(renderType: .footer(footer: model)))
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
        case .comments(_/*comments*/): return 1 //return comments.count > 0 ? comments.count : comments.count
        case .primaryContent(_):  return 1
        case .header(_):  return 1
        case .descriptions(_):  return 1
        case .footer(_): return 1
        case .collections(_,_): return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = renderModels[indexPath.section]
        
        switch model.renderType {
        case .actions(_/**let actions**/):
            let cell = tableView.dequeueReusableCell(withIdentifier: IGFeedPostActionsTableViewCell.identifier, for: indexPath) as! IGFeedPostActionsTableViewCell
            return cell
        case .comments(let comments):
            //let comment = comments[indexPath.row]
            let cell = tableView.dequeueReusableCell(withIdentifier: IGFeedPostGeneralTableViewCell.identifier, for: indexPath) as! IGFeedPostGeneralTableViewCell
            let count = comments.count
            cell.configure(with: count)
            return cell
        case .primaryContent(let post):
            let cell = tableView.dequeueReusableCell(withIdentifier: IGFeedPostTableViewCell.identifier, for: indexPath) as! IGFeedPostTableViewCell
            cell.configure(with: post)
            return cell
        case .header(let user):
              let cell = tableView.dequeueReusableCell(withIdentifier: IGFeedPostHeaderTableViewCell.identifier,for: indexPath) as! IGFeedPostHeaderTableViewCell
            cell.configure(with: user)
            return cell
        case .descriptions(let post):
            let cell = tableView.dequeueReusableCell(withIdentifier: IGFeedPostDescriptionTableViewCell.identifier, for: indexPath) as! IGFeedPostDescriptionTableViewCell
            cell.configure(with: post)
            cell.delegate = self
            return cell
        case .footer(let footer):
            let cell = tableView.dequeueReusableCell(withIdentifier: IGFeedPostFooterTableViewCell.identifier, for: indexPath) as! IGFeedPostFooterTableViewCell
            cell.configure(with: footer)
            //cell.delegate = self
            return cell
        case .collections(_,_):
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let model = renderModels[indexPath.section]
        switch model.renderType {
        case .actions(_): return 60 ///Actions
        case .comments(_): return 25 ///Comments
        case .primaryContent(_): return tableView.width ///Post
        case .header(_): return 70 ///Hader
        case .descriptions(_): return 85 ///Descriptions
        case .collections(_,_): return 50 ///Collections
        case .footer(_): return 50 ///Footer
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}


extension PostViewController: IGFeedPostDescriptionTableViewCellDelegate {
    func didTapLikeButton() {
        print("didTapLikeButton")
    }
    
     func didTapCommentButton(model: Userpost) {
         let vc = ListCommentsViewController(model: model)
         vc.title = "Coments"
         vc.navigationItem.largeTitleDisplayMode = .never
         navigationController?.pushViewController(vc, animated: true)
     }
    
    func didTapSendButton() {
        print("didTapLikeButton")
    }
}
