//
//  ListCommentsViewController.swift
//  SwiftNetwork
//
//  Created by Eddy Donald Chinchay Lujan on 28/4/21.
//

import UIKit


/// States of render cell
enum UserPostRenderType {
    case primaryContent(posts: UserPost) //Post
}

/// Model of  renderd Post
struct UserPostRenderViewModel {
    let renderType: UserPostRenderType
}

class ListCommentsViewController: UIViewController {
    
    private let userImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.masksToBounds = true
        imageView.backgroundColor = .secondarySystemBackground
        return imageView
    }()
    
    private let Commentlabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.numberOfLines = 0
        return label
    }()
    
    private let timeToPostCommentLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.font = .systemFont(ofSize: 16, weight: .regular)
        label.text = "1h"
        label.textColor = .secondaryLabel
        return label
    }()
    
    private let tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.isHidden = false
        return tableView
    }()
    
    private let model: UserPost?
    
    private var renderModels = [UserPostRenderViewModel]()
    
    // MARK: Init
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
    
    private func setupView() {
        view.backgroundColor = .systemBackground
        view.addSubview(tableView)
        //tableView.tableHeaderView = createTableHeader()
    }
    
    private func configureTableView() {
        tableView.backgroundColor = . systemBackground //.secondarySystemFill
        tableView.register(PostCommentsListTableViewCell.self, forCellReuseIdentifier: PostCommentsListTableViewCell.identifier)
        tableView.register(CustomHeaderTableViewCell.self, forCellReuseIdentifier: CustomHeaderTableViewCell.identifier)
        tableView.separatorStyle = .none
    }
    
    private func delegateTableView() {
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    private func joinText(username:String, description:String) -> NSMutableAttributedString {
        let boldText  = username + " "
        let attrs = [NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 14)]
        let attributedString = NSMutableAttributedString(string:boldText, attributes:attrs)
        
        let normalText = description
        let attrs2 = [NSAttributedString.Key.font : UIFont.systemFont(ofSize: CGFloat(14))]
        let normalString = NSMutableAttributedString(string:normalText, attributes:attrs2)
        attributedString.append(normalString)
        return attributedString
    }
    
    private func createTableHeader() -> UIView? {
        let headerView = UIView(
        frame: CGRect(x: 0, y: 0,width: view.width,height: 55))
        view.addSubview(headerView)
        
        headerView.addSubview(userImageView)
        headerView.addSubview(Commentlabel)
        headerView.addSubview(timeToPostCommentLabel)
        
        let username = self.model?.owner.username
        let descriptionPost =  self.model?.caption
        let attributedString = joinText(username: username!, description: descriptionPost!)
        Commentlabel.attributedText = attributedString
        
        ///margin
        let size = headerView.height-4
        userImageView.frame = CGRect(
            x: 5,
            y: 5,
            width: headerView.height-6,
            height: headerView.height-6)
        userImageView.layer.cornerRadius = userImageView.height/2.0
        
        let labelHeight = headerView.height/2
        //Commentlabel.backgroundColor = .systemRed
        Commentlabel.frame = CGRect(
             x: userImageView.right+5,
             y: 5,
             width: headerView.width-(size*1)-15,
             height: labelHeight)
        
        let  buttonSubLabelWidth = headerView.width > 100 ? 280.0 : headerView.width/3
        //timeToPostCommentLabel.backgroundColor = .systemBlue
        timeToPostCommentLabel.frame = CGRect(
            x: userImageView.right+5,
            y: Commentlabel.bottom,
            width: headerView.width-8-userImageView.width-buttonSubLabelWidth,
            height: labelHeight-10)
        
        return headerView
    }
    
    private func configureModels() {
        guard let userPostModel = self.model else {
            return
        }
        renderModels.append(UserPostRenderViewModel(renderType: .primaryContent(posts: userPostModel)))
    }
}


// MARK: TableView
extension ListCommentsViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return renderModels.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch renderModels[section].renderType {
            case .primaryContent(let posts):
                return posts.comments.count > 0 ? posts.comments.count : posts.comments.count /// Retorna el total de comentarios
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = renderModels[indexPath.section]
        switch model.renderType {
            case .primaryContent(let posts):
                let comment = posts.comments[indexPath.row]
                let cell = tableView.dequeueReusableCell(withIdentifier: PostCommentsListTableViewCell.identifier, for: indexPath) as! PostCommentsListTableViewCell
                cell.configure(with: comment.username, with: comment.text)
                return cell
        }
    }
 
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let model = renderModels[section]
        switch model.renderType {
            case .primaryContent(let posts):
                let post = posts
                let cell = tableView.dequeueReusableCell(withIdentifier: CustomHeaderTableViewCell.identifier) as! CustomHeaderTableViewCell
                cell.configure(with: post.owner.username, with: post.caption!)
            
                let separatorView = UIView(frame: CGRect(x: tableView.separatorInset.left, y: 0, width: 20, height: 1))
                separatorView.backgroundColor = .secondarySystemFill
                
                separatorView.translatesAutoresizingMaskIntoConstraints  = false
                cell.contentView.addSubview(separatorView)
                NSLayoutConstraint.activate([
                    separatorView.leadingAnchor.constraint(equalTo:cell.contentView.leadingAnchor),
                    separatorView.trailingAnchor.constraint(equalTo:cell.contentView.trailingAnchor),
                    separatorView.heightAnchor.constraint(equalToConstant:1),
                    separatorView.bottomAnchor.constraint(equalTo:cell.contentView.bottomAnchor)])
                return cell
        }
    }
    
    ///Height de Cell (List Comments
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 65.0
    }
    
    ///Height de Cell (Header TableView)
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 100.0
    }
    
    ///Selected Cell
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        print("Did select normal list item")
    }
}
