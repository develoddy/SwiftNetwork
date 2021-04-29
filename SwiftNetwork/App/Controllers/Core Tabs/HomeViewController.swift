
//
//  HomeViewController.swift
//  Blubinn
//
//  Created by Eddy Donald Chinchay Lujan on 31/3/21.
//

import UIKit







class HomeViewController: UIViewController {
    
    /*private var feedRenderModels = [HomeFeedRenderViewModel]()
    
    private let tableView: UITableView = {
        let table = UITableView()
        // Register cells
        table.register(IGFeedPostTableViewCell.self, forCellReuseIdentifier: IGFeedPostTableViewCell.identifier)
        table.register(IGFeedPostHeaderTableViewCell.self, forCellReuseIdentifier: IGFeedPostHeaderTableViewCell.identifier)
        table.register(IGFeedPostActionsTableViewCell.self, forCellReuseIdentifier: IGFeedPostActionsTableViewCell.identifier)
        table.register(IGFeedPostGeneralTableViewCell.self, forCellReuseIdentifier: IGFeedPostGeneralTableViewCell.identifier)
        return table
    }()
    
    private let followingButton : UIButton = {
        let button = UIButton()
        button.setTitle("Following", for: .normal)
        button.backgroundColor = .secondarySystemBackground
        button.setTitleColor(.label, for: .normal)
        button.setTitleColor(UIColor.black, for: .normal)
        return button
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
        
        let user = User(
            name: (first: "", last: ""),
            username: "@kanye_west",
            bio: "",
            profilePicture: URL(string: "https://wwww.google.com")!,
            birthDate: Date(),
            gender: .male,
            email: "",
            counts: UserCount(followers: 1, following: 1, posts: 1),
            joinDate: Date() )
    
        let post = UserPost(
            identifier: "",
            postType: .photo,
            thumbnailImage: URL(string: "https://wwww.google.com")!,
            postURL: URL(string: "https://wwww.google.com")!,
            caption: nil,
            likeCount: [],
            comments: [],
            createDate: Date(),
            taggedUsers: [],
            owner: user )
        
        var comments = [PostComments]()
        for x in 0..<3 {
            comments.append(PostComments(
                                identifier: "\(x)",
                                username: "@jenny",
                                text: "This is the best post I've seen",
                                createDate: Date(),
                                likes: []))
        }
        
        for x in 0..<4 {
            let viewModel = HomeFeedRenderViewModel(
                header: PostRenderViewModel(
                    renderType: .header(provider: user)),
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
                case .comments(let comments):
                    return comments.count > 3 ? 3 : comments.count
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
                cell.configure(with: comments)
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
    }*/
}




/*
 
 
 //
 //  TimeLineViewController.swift
 //  SwiftNetwork
 //
 //  Created by Eddy Donald Chinchay Lujan on 25/4/21.
 //

 import UIKit
 import AVFoundation


 enum CellModel {
     case collectionView(models: [CollectionTableCellModel], rows: Int)
     case list(models: HomeFeedRenderViewModel)
 }

 struct CollectionTableCellModel {
     let title: String
     let imageName: String
 }

 struct HomeFeedRenderViewModel {
     let header: PostRenderViewModel
     let post: PostRenderViewModel
     let actions: PostRenderViewModel
     let comments: PostRenderViewModel
 }



 class TimeLineViewController: UIViewController {
     
     //private var feedRenderModels = [HomeFeedRenderViewModel]()
     private var models = [CellModel]()
     
     private let tableView: UITableView = {
         let tableView = UITableView(frame: .zero, style: .grouped)
         tableView.register(IGFeedPostTableViewCell.self, forCellReuseIdentifier: IGFeedPostTableViewCell.identifier)
         tableView.register(IGFeedPostHeaderTableViewCell.self, forCellReuseIdentifier: IGFeedPostHeaderTableViewCell.identifier)
         tableView.register(IGFeedPostActionsTableViewCell.self, forCellReuseIdentifier: IGFeedPostActionsTableViewCell.identifier)
         tableView.register(IGFeedPostGeneralTableViewCell.self, forCellReuseIdentifier: IGFeedPostGeneralTableViewCell.identifier)
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

     
     private func setupModels() {
         models.append(.collectionView(models: [
             CollectionTableCellModel(title: "Test 1",imageName: "test"),
             CollectionTableCellModel(title: "Test 2",imageName: "test"),
             CollectionTableCellModel(title: "Test 3",imageName: "test"),
             CollectionTableCellModel(title: "Test 4",imageName: "test"),
             CollectionTableCellModel(title: "Test 5",imageName: "test"),
         ],rows: 2))
         
         let user = User(
             name: (first: "", last: ""),
             username: "@kanye_west",
             bio: "",
             profilePicture: URL(string: "https://wwww.google.com")!,
             birthDate: Date(),
             gender: .male,
             email: "",
             counts: UserCount(followers: 1, following: 1, posts: 1),
             joinDate: Date() )
     
         let post = UserPost(
             identifier: "",
             postType: .photo,
             thumbnailImage: URL(string: "https://wwww.google.com")!,
             postURL: URL(string: "https://wwww.google.com")!,
             caption: nil,
             likeCount: [],
             comments: [],
             createDate: Date(),
             taggedUsers: [],
             owner: user )
         
         var comments = [PostComments]()
         for x in 0..<3 {
             let comm = PostComments(
                                 identifier: "\(x)",
                                 username: "@jenny",
                                 text: "This is the best post I've seen",
                                 createDate: Date(),
                                 likes: [])
             
             comments.append(comm)
             
         }
         
         for x in 0..<4 {
             let viewModel = HomeFeedRenderViewModel(
                 header: PostRenderViewModel(renderType: .header(provider: user)),
                 post: PostRenderViewModel(renderType: .primaryContent(provider: post)),
                 actions: PostRenderViewModel(renderType: .actions(provider: "")),
                 comments: PostRenderViewModel(renderType: .comments(comments: comments)))
             models.append(.list(models: viewModel ))
         }
         
     }
    
     private func configureTableView() {
         tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
         tableView.register(CollectionTableViewCell.self, forCellReuseIdentifier: CollectionTableViewCell.identifier)
     }
     
     private func createTableHeader() -> UIView? {
         
         let headerView = UIView(frame: CGRect(x: 0,
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
         //textField.text = "Custom section header"
         textField.font = .systemFont(ofSize: 22, weight: .thin)
         headerView.addSubview(textField)
         
         textField.frame = CGRect(x: 10+imageView.width,
                                  y: 10,
                                  width: headerView.width-20-imageView.width,
                                  height: headerView.height-20)
         return headerView
     }
     
     private func delegateTableView() {
         tableView.delegate = self
         tableView.dataSource = self
     }
 }

 extension TimeLineViewController: UITableViewDelegate, UITableViewDataSource {
     
     func numberOfSections(in tableView: UITableView) -> Int {
         return models.count
     }
     
     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
         //let modelListCount = models.count
         let type = models[section]
         
         switch type {
         case .list(let model):
             return models.count
             
         case .collectionView(_, _):
             return 1
         }
         //return 0
     }
     
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
         let modelListCount = models.count
         
         switch models[indexPath.section] {
             case .list(let models):
                 let model = models
                 let subSection = indexPath.row % modelListCount
                 
                 if subSection == 1 {
                     switch model.header.renderType {
                         case .header(let user):
                             let cell = tableView.dequeueReusableCell(withIdentifier: IGFeedPostHeaderTableViewCell.identifier,
                                                                      for: indexPath) as! IGFeedPostHeaderTableViewCell
                             cell.configure(with: user)
                             return cell
                         case .comments, .actions, .primaryContent: return UITableViewCell()
                     }
                 }
                 else if subSection == 2 {
                     //post
                     switch model.post.renderType {
                         case .primaryContent(let post):
                             let cell = tableView.dequeueReusableCell(withIdentifier: IGFeedPostTableViewCell.identifier,
                                                                      for: indexPath) as! IGFeedPostTableViewCell
                             cell.configure(with: post)
                             return cell
                         case .comments, .actions, .header: return UITableViewCell()
                     }
                 } else if subSection == 3 {
                     //actions
                     switch model.actions.renderType {
                         case .actions(let provider):
                             let cell = tableView.dequeueReusableCell(withIdentifier: IGFeedPostActionsTableViewCell.identifier,
                                                                      for: indexPath) as! IGFeedPostActionsTableViewCell
                             cell.delegate = self
                             return cell
                         case .comments, .header, .primaryContent: return UITableViewCell()
                     }
                 } else if subSection == 4 {
                     //comments
                     switch model.comments.renderType {
                         case .comments(let comments):
         
                             let cell = tableView.dequeueReusableCell(withIdentifier: IGFeedPostGeneralTableViewCell.identifier,
                                                                      for: indexPath) as! IGFeedPostGeneralTableViewCell
                             cell.configure(with: comments)
                             return cell
                         case .header, .actions, .primaryContent: return UITableViewCell()
                     }
                 }
                 
             case .collectionView(let models, _):
                 let cell = tableView.dequeueReusableCell(withIdentifier: CollectionTableViewCell.identifier,
                                                          for: indexPath) as! CollectionTableViewCell
                 cell.configure(with: models)
                 cell.delegate = self
                 return cell
         }
         return UITableViewCell()
     }
     
     func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
         tableView.deselectRow(at: indexPath, animated: true)
         print("Did select normal list item")
     }
     
     func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
         let modelListCount = models.count
         
         switch models[indexPath.section] {
             case .list(_):
                 let subSection = indexPath.row % modelListCount //4
                 if subSection == 1 {
                     // Header
                     return 70
                 } else if subSection == 2 {
                     // Post
                     return tableView.width
                 }else if subSection == 3 {
                     // Actions (Like, Comment)
                     return 60
                 }
                 else if subSection == 4 {
                     // Comment row
                     return 50
                 }
                 
             case .collectionView(_, _/*let rows*/): return 280 /// 180 *  CGFloat(rows)
         }
         return 0
     }
     
     /*func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
         return UIView()
     }
     
     func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
         let subSection = section % models.count
         return subSection == 4 ? 70 : 0
     }*/
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
         print("comment")
     }
     
     func didTapSendButton() {
         print("Send")
     }
 }

 */
