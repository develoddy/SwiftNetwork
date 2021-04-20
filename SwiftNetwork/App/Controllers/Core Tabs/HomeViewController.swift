//
//  HomeViewController.swift
//  Blubinn
//
//  Created by Eddy Donald Chinchay Lujan on 31/3/21.
//

import UIKit

struct HomeFeedRenderViewModel {
    let header: PostRenderViewModel
    let post: PostRenderViewModel
    let actions: PostRenderViewModel
    let comments: PostRenderViewModel
}

class HomeViewController: UIViewController {
    
    private var feedRenderModels = [HomeFeedRenderViewModel]()
    
    private let tableView: UITableView = {
        let table = UITableView()
        
        // Register cells
        table.register(IGFeedPostTableViewCell.self, forCellReuseIdentifier: IGFeedPostTableViewCell.identifier)
        table.register(IGFeedPostHeaderTableViewCell.self, forCellReuseIdentifier: IGFeedPostHeaderTableViewCell.identifier)
        table.register(IGFeedPostActionsTableViewCell.self, forCellReuseIdentifier: IGFeedPostActionsTableViewCell.identifier)
        table.register(IGFeedPostGeneralTableViewCell.self, forCellReuseIdentifier: IGFeedPostGeneralTableViewCell.identifier)
        return table
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        createMockModels()
        //handleNotAuthenticated()
        configureTableView()
        delegateTableView()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }
    
    private func setupView() {
        title = "Home"
        view.backgroundColor = .systemBackground
        view.addSubview(tableView)
    }
    
    private func configureTableView() {
        tableView.backgroundColor = .secondarySystemFill
    }
    
    private func delegateTableView() {
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    private func createMockModels() {
        
        let user = User(name: (first: "", last: ""),
                        username: "@kanye_west",
                        bio: "",
                        profilePicture: URL(string: "https://wwww.google.com")!,
                        birthDate: Date(),
                        gender: .male,
                        email: "",
                        counts: UserCount(followers: 1, following: 1, posts: 1),
                        joinDate: Date() )
        
        
        let post = UserPost(identifier: "",
                            postType: .photo,
                            thumbnailImage: URL(string: "https://wwww.google.com")!,
                            postURL: URL(string: "https://wwww.google.com")!,
                            caption: nil,
                            likeCount: [],
                            comments: [],
                            createDate: Date(),
                            taggedUsers: [],
                            owner: user)
        
        var comments = [PostComments]()
        for x in 0..<2 {
            comments.append(PostComments(identifier: "\(x)",
                                         username: "@jenny",
                                         text: "This is the best post I've seen",
                                         createDate: Date(),
                                         likes: []))
        }
        
        for x in 0..<5 {
            let viewModel = HomeFeedRenderViewModel(header: PostRenderViewModel(renderType: .header(provider: user)),
                                                    post: PostRenderViewModel(renderType: .primaryContent(provider: post)),
                                                    actions: PostRenderViewModel(renderType: .actions(provider: "")),
                                                    comments: PostRenderViewModel(renderType: .comments(comments: comments)))
            feedRenderModels.append(viewModel)
        }
    }
    
    private func handleNotAuthenticated() {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let token = appDelegate.objUsuarioSesion?.token
        
        if token == nil {
            let vc = LoginViewController()
            vc.modalPresentationStyle = .fullScreen
            self.present(vc, animated: false)
        } else {
            print("ElSE Home")
        }
    }
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return feedRenderModels.count * 4
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        let x = section
        let model: HomeFeedRenderViewModel
        
        if x == 0 {
            model = feedRenderModels[0]
        } else {
            let position = x % 4 == 0 ?  x/4 : ((x - (x % 4)) / 4)
            model = feedRenderModels[position]
        }
        
        let subSection = x % 4
        if subSection == 0 {
            //header
            return 1
        }
        else if subSection == 1 {
            //post
            return 1
        }
        else if subSection == 2 {
            //actions
            return 1
        }
        else if subSection == 3 {
            //comments
            let commentsModel = model.comments
            switch commentsModel.renderType {
                case .comments(let comments): return comments.count > 2 ? 2 : comments.count
                case .header, .actions, .primaryContent: return 0
            }
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let x = indexPath.section
        let model: HomeFeedRenderViewModel
        
        if x == 0 {
            model = feedRenderModels[0]
        } else {
            let position = x % 4 == 0 ?  x/4 : ((x - (x % 4)) / 4)
            model = feedRenderModels[position]
        }
        
        let subSection = x % 4
        
        if subSection == 0 {
            //header
            switch model.header.renderType {
            case .header(let user):
                let cell = tableView.dequeueReusableCell(withIdentifier: IGFeedPostHeaderTableViewCell.identifier, for: indexPath) as! IGFeedPostHeaderTableViewCell
                cell.configure(with: user)
                cell.delegate = self
                return cell
            case .comments, .actions, .primaryContent: return UITableViewCell()
            }
        }
        else if subSection == 1 {
            //post
            switch model.post.renderType {
            case .primaryContent(let post):
                let cell = tableView.dequeueReusableCell(withIdentifier: IGFeedPostTableViewCell.identifier, for: indexPath) as! IGFeedPostTableViewCell
                cell.configure(with: post)
                return cell
            case .comments, .actions, .header: return UITableViewCell()
            }
        }
        else if subSection == 2 {
            //actions
            switch model.actions.renderType {
            case .actions(let provider):
                let cell = tableView.dequeueReusableCell(withIdentifier: IGFeedPostActionsTableViewCell.identifier, for: indexPath) as! IGFeedPostActionsTableViewCell
                cell.delegate = self
                return cell
                
            case .comments, .header, .primaryContent: return UITableViewCell()
            }
        }
        else if subSection == 3 {
            //comments
            switch model.comments.renderType {
            case .comments(let comments):
                let cell = tableView.dequeueReusableCell(withIdentifier: IGFeedPostGeneralTableViewCell.identifier, for: indexPath) as! IGFeedPostGeneralTableViewCell
                return cell
                
            case .header, .actions, .primaryContent: return UITableViewCell()
            }
        }
       
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        let subSection = indexPath.section % 4
        if subSection == 0 {
            // Header
            return 70
        } else if subSection == 1 {
            // Post
            return tableView.width
        }
        else if subSection == 2 {
            // Actions (Like, Comment)
            return 60
        }
        else if subSection == 3 {
            // Comment row
            return 50
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        let subSection = section % 4
        return subSection == 3 ? 70 : 0
    }
}


extension HomeViewController: IGFeedPostHeaderTableViewCellDelegate {
    func didTapMoreButton() {
        let acctionSheet = UIAlertController(title: "Post Option", message: nil, preferredStyle: .actionSheet)
        acctionSheet.addAction(UIAlertAction(title: "Report Post", style: .destructive, handler: { [weak self] _ in
            self?.reportPost()
        }))
        acctionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        present(acctionSheet, animated: true)
    }
    
    func reportPost() {
        
    }
}


extension HomeViewController: IGFeedPostActionsTableViewCellDelegate {
    
    func didTapLikeButton() {
        print("like")
    }
    
    func didTapCommentButton() {
        print("comment")
    }
    
    func didTapSendButton() {
        print("Send")
    }
    
    
}
