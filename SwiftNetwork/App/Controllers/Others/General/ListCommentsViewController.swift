//
//  ListCommentsViewController.swift
//  SwiftNetwork
//
//  Created by Eddy Donald Chinchay Lujan on 28/4/21.
//

import UIKit


/// States of render cell
enum UserPostViewModelRenderType {
    case primaryContent(posts: UserPostViewModel) //Post
}

/// Model of  renderd Post
struct UserPostViewModelRenderViewModel {
    let renderType: UserPostViewModelRenderType
}

class ListCommentsViewController: UIViewController {
    
    private let tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.isHidden = false
        return tableView
    }()
    
    private let model: UserPostViewModel?
    
    private var renderModels = [UserPostViewModelRenderViewModel]()
    
    // MARK: Init
    init(model: UserPostViewModel?) {
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
        tableView.backgroundColor = .systemBackground //.secondarySystemFill 
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
    
   
    
    private func configureModels() {
        guard let UserPostViewModelModel = self.model else {
            return
        }
        renderModels.append(UserPostViewModelRenderViewModel(renderType: .primaryContent(posts: UserPostViewModelModel)))
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
                cell.configure(with: comment.username!, with: comment.content!)
                return cell
        }
    }
 
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let model = renderModels[section]
        switch model.renderType {
            case .primaryContent(let posts):
                let post = posts
                let cell = tableView.dequeueReusableCell(withIdentifier: CustomHeaderTableViewCell.identifier) as! CustomHeaderTableViewCell
                cell.configure(with: post.owner.username!, with: post.caption!)
            
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
