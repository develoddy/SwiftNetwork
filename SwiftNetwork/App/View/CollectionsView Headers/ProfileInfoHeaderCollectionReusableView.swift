//
//  ProfileInfoHeaderCollectionReusableView.swift
//  SwiftNetwork
//
//  Created by Eddy Donald Chinchay Lujan on 15/4/21.
//

import UIKit

protocol ProfileInfoHeaderCollectionReusableViewDelegate {
    func profileHeaderDidTapPostButton( _header:  ProfileInfoHeaderCollectionReusableView)
    func profileHeaderDidTapFollowersButton( _header:  ProfileInfoHeaderCollectionReusableView)
    func profileHeaderDidTapFollowingButton( _header:  ProfileInfoHeaderCollectionReusableView)
    func profileHeaderDidTapEditProfileButton( _header:  ProfileInfoHeaderCollectionReusableView)
}

final class ProfileInfoHeaderCollectionReusableView: UICollectionReusableView {
    
    static let identifier = "ProfileInfoHeaderCollectionReusableView"
    
    public var delegate: ProfileInfoHeaderCollectionReusableViewDelegate?
    
    private let profilePhotoImageView : UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .purple
        imageView.layer.masksToBounds = true
        return imageView
    }()
    
    private let postButton : UIButton = {
        let button = UIButton()
        button.setTitle("Post", for: .normal)
        button.backgroundColor = .secondarySystemBackground
        button.setTitleColor(.label, for: .normal)
        button.setTitleColor(UIColor.black, for: .normal)
        return button
    }()
    
    private let followingButton : UIButton = {
        let button = UIButton()
        button.setTitle("Following", for: .normal)
        button.backgroundColor = .secondarySystemBackground
        button.setTitleColor(.label, for: .normal)
        button.setTitleColor(UIColor.black, for: .normal)
        return button
    }()
    
    private let followersButton : UIButton = {
        let button = UIButton()
        button.setTitle("Followers", for: .normal)
        button.backgroundColor = .secondarySystemBackground
        button.setTitleColor(.label, for: .normal)
        button.setTitleColor(UIColor.black, for: .normal)
        return button
    }()
    
    private let editProfileButton : UIButton = {
        let button = UIButton()
        button.setTitle("Edit Your Profile", for: .normal)
        button.backgroundColor = .secondarySystemBackground
        button.setTitleColor(.label, for: .normal)
        button.setTitleColor(UIColor.black, for: .normal)
        return button
    }()
    
    private let nameLabel : UILabel = {
        let label = UILabel()
        label.text = "Joe Smith"
        label.numberOfLines = 1
        return label
    }()
    
    private let bioLabel : UILabel = {
        let label = UILabel()
        label.text = "This is the first account!"
        label.numberOfLines = 0 // line wrap
        return label
    }()
    
    // MARK: Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubviews()
        addButtonActions()
        backgroundColor = .systemBackground
        clipsToBounds = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
   
    private func addSubviews() {
        addSubview(profilePhotoImageView)
        addSubview(postButton)
        addSubview(followingButton)
        addSubview(followersButton)
        addSubview(editProfileButton)
        addSubview(nameLabel)
        addSubview(bioLabel)
    }
    
    private func addButtonActions() {
        followersButton.addTarget(self, action: #selector(didTapFollowerButton), for: .touchUpInside)
        followingButton.addTarget(self, action: #selector(didTapFollowingButton), for: .touchUpInside)
        postButton.addTarget(self, action: #selector(didTapPostsButton), for: .touchUpInside)
        editProfileButton.addTarget(self, action: #selector(didTapEditProfileButton), for: .touchUpInside)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let profilePhotoSize = width/4
        profilePhotoImageView.frame = CGRect(
            x: 5,
            y: 5,
            width: profilePhotoSize,
            height: profilePhotoSize
        ).integral
        
        profilePhotoImageView.layer.cornerRadius = profilePhotoSize/2.0
        
        let buttonHeight = profilePhotoSize/2
        let countButtonWidth = (width-10-profilePhotoSize)/3
        
        postButton.frame = CGRect(
            x: profilePhotoImageView.right,
            y: 5,
            width: countButtonWidth,
            height: buttonHeight
        ).integral
        
        followersButton.frame = CGRect(
            x: postButton.right,
            y: 5,
            width: countButtonWidth,
            height: buttonHeight
        ).integral
        
        followingButton.frame = CGRect(
            x: followersButton.right,
            y: 5,
            width: countButtonWidth,
            height: buttonHeight
        ).integral
        
        editProfileButton.frame = CGRect(
            x: profilePhotoImageView.right,
            y: 5 + buttonHeight,
            width: countButtonWidth*3,
            height: buttonHeight
        ).integral
        
        nameLabel.frame = CGRect(
            x: 5,
            y: 5+profilePhotoImageView.bottom,
            width: width-10,
            height: 50
        ).integral
        
        let bioLabelSize = bioLabel.sizeThatFits(frame.size)
        bioLabel.frame = CGRect(
            x: 5,
            y: 5+nameLabel.bottom,
            width: width-10,
            height: bioLabelSize.height
        ).integral
    }
    
    // MARK: - Actions
    
    @objc private func didTapFollowerButton() {
        delegate?.profileHeaderDidTapFollowersButton(_header: self)
    }
    @objc private func didTapFollowingButton() {
        delegate?.profileHeaderDidTapFollowingButton(_header: self)
    }
    @objc private func didTapPostsButton() {
        delegate?.profileHeaderDidTapPostButton(_header: self)
    }
    @objc private func didTapEditProfileButton() {
        delegate?.profileHeaderDidTapEditProfileButton(_header: self)
    }
}

/*
 
 
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
     
     private var collectionView: UICollectionView?
     
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
     
     private let stackView: UIStackView = {
         let stackView = UIStackView()
         stackView.axis = .horizontal
         stackView.distribution =  .fillEqually
         stackView.spacing = 5
         stackView.backgroundColor = .orange
         stackView.translatesAutoresizingMaskIntoConstraints = false
         return stackView
     }()
     
     private let stackViewTypingPost: UIStackView = {
         let stackView = UIStackView()
         stackView.axis = .horizontal
         stackView.distribution =  .fillEqually
         //stackView.spacing = 5
         stackView.backgroundColor = .red
         stackView.translatesAutoresizingMaskIntoConstraints = false
         return stackView
     }()
     
     
     
     
     
     
     
     
     
     
     
     
     
     
     private let imageProfileButton: UIButton = {
         let button = UIButton()
         button.backgroundColor = .blue
         return button
     }()
     
     lazy var stackView1: UIStackView = {
         let stackView = UIStackView(arrangedSubviews: [imageProfileButton])
         stackView.axis = .horizontal
         stackView.distribution =  .fillEqually
         stackView.spacing = 5
         stackView.backgroundColor = .green
         stackView.translatesAutoresizingMaskIntoConstraints = false
         return stackView
     }()
     
     private let stackView2: UIStackView = {
         let stackView = UIStackView()
         stackView.axis = .horizontal
         stackView.distribution =  .fillEqually
         stackView.spacing = 5
         stackView.backgroundColor = .red
         stackView.translatesAutoresizingMaskIntoConstraints = false
         return stackView
     }()
     
    
     
    
     
     lazy var stackVieww: UIStackView = {
         let stackView = UIStackView()
         stackView.axis = .vertical
         stackView.distribution =  .fillEqually
         stackView.spacing = 5
         stackView.backgroundColor = .purple
         stackView.translatesAutoresizingMaskIntoConstraints = false
         return stackView
     }()
     
     lazy var stackVieww2: UIStackView = {
         let stackView = UIStackView(arrangedSubviews: [stackView2] )
         stackView.axis = .vertical
         stackView.distribution =  .fillEqually
         stackView.spacing = 5
         stackView.backgroundColor = .orange
         stackView.translatesAutoresizingMaskIntoConstraints = false
         return stackView
     }()
     
     
 //   private let storyButton : UIButton = {
 //        let button = UIButton()
 //        button.setTitle("Post", for: .normal)
 //        button.backgroundColor = .secondarySystemBackground
 //        button.setTitleColor(.label, for: .normal)
 //        button.setTitleColor(UIColor.black, for: .normal)
 //        return button
 //   }()
     
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
         configureTableViewHeader()
         configureTableView()
         delegateTableView()
         
         configureStoryStackView()
     }
     
     override func viewDidLayoutSubviews() {
         super.viewDidLayoutSubviews()
         tableView.frame = view.bounds
         //collectionView?.frame = view.bounds
         
         //stackVieww.frame = view.bounds
         //stackVieww2.frame = view.bounds
         
         
         //let countButtonWidth = view.width-10
         //let buttonHeight = view.width/3
         
         
         
         
         /*stackView2.frame = CGRect(
             x: 5,
             y: 5,
             width: view.width - 10,
             height: 100
         )*/
         
         
         /*let profilePhotoSize = view.width/4
         imageProfileButton.frame = CGRect(
             x: 5,
             y: 5,
             width: 70,
             height: profilePhotoSize
         ).integral*/
         
     }
     
     private func setupView() {
         title = "Home"
         view.backgroundColor = .systemBackground
         view.addSubview(tableView)
     }
     
     private func configureStoryStackView() {
        /* for i in 1...3 {
             let storyButton = UIButton()
             storyButton.setTitle("Post", for: .normal)
             storyButton.backgroundColor = .secondarySystemBackground
             storyButton.setTitleColor(.label, for: .normal)
             storyButton.setTitleColor(UIColor.black, for: .normal)
             stackView1.addArrangedSubview(storyButton)
             
         }*/
     
     }
     
     
     private func configureTableViewHeader() {
         
         let header = UIView(frame: CGRect(x:0, y:0, width: view.width, height:100))
         header.backgroundColor = .yellow
         
         let header2 = UIView(frame: CGRect(x:0,
                                            y:header.frame.origin.y + header.frame.size.height + 25,
                                            width: view.width,
                                            height:100))
         header2.backgroundColor = .purple
         
         let stackView = UIStackView(arrangedSubviews: [header, header2] )
         stackView.frame = view.bounds
         stackView.backgroundColor = .white
         stackView.axis = .vertical
         stackView.distribution = .fillEqually
         //view.addSubview(stackView)
         
         
         tableView.tableHeaderView = stackView
         
         
 //        stackVieww.heightAnchor.constraint(equalToConstant: header.height-5).isActive = true
 //        stackVieww.widthAnchor.constraint(equalToConstant: view.width - 10).isActive = true
 //        stackVieww.centerYAnchor.constraint(equalTo: header.centerYAnchor).isActive = true
 //        stackVieww.centerXAnchor.constraint(equalTo: header.centerXAnchor).isActive = true
 //
 //        stackVieww2.heightAnchor.constraint(equalToConstant: stackVieww.top).isActive = true
 //        stackVieww2.widthAnchor.constraint(equalToConstant: view.width - 10).isActive = true
 //        stackVieww2.centerYAnchor.constraint(equalTo: header.centerYAnchor).isActive = true
 //        stackVieww2.centerXAnchor.constraint(equalTo: header.centerXAnchor).isActive = true
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
         for x in 0..<2 {
             comments.append(PostComments(
                                 identifier: "\(x)",
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

 
 */
