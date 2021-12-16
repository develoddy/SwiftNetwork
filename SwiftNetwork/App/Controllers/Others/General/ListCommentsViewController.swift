//
//  ListCommentsViewController.swift
//  SwiftNetwork
//
//  Created by Eddy Donald Chinchay Lujan on 28/4/21.
//

import UIKit


/// States of render cell
enum UserPostViewModelRenderType {
    ///case primaryContent(posts: UserpostViewModel) //Post
    case primaryContent(posts: Userpost)
}

/// Model of  renderd Post
struct UserPostViewModelRenderViewModel {
    let renderType: UserPostViewModelRenderType
}

extension ListCommentsViewController: UITextFieldDelegate {
   
    
    /*func textFieldDidBeginEditing(_ textField: UITextField) {
        DispatchQueue.main.async{
            if textField == self.inputTextfield {
                print("entrooooooo")
                let beginning = textField.beginningOfDocument
                textField.selectedTextRange = textField.textRange(from: beginning, to: beginning)
                textField.insertText("Hello")
            }
        }
    }*/
}

class ListCommentsViewController: UIViewController  {
    
    ///private let model: UserpostViewModel?
    private let model: Userpost?
    
    private var renderModels = [UserPostViewModelRenderViewModel]()
    
    var bottomConstraint: NSLayoutConstraint?
    
    private let tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.isHidden = false
        return tableView
    }()
    
    let messageInputContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    
    private let profilePhotoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "eddy")
        imageView.clipsToBounds = true
        imageView.layer.masksToBounds = true
        imageView.backgroundColor = Constants.Color.whiteLight
        imageView.layer.borderWidth = 1
        imageView.layer.borderColor = Constants.Color.general.cgColor
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private let inputTextfield : UITextField = {
        let textfield = UITextField()
        textfield.attributedPlaceholder = NSAttributedString(string: "Escribe un comentario...", attributes: [NSAttributedString.Key.foregroundColor: Constants.Color.general])
        textfield.font = Constants.fontSize.regular
        textfield.backgroundColor = Constants.Color.whiteLight
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: textfield.frame.height))
        textfield.leftView = paddingView
        textfield.leftViewMode = UITextField.ViewMode.always
        textfield.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
        return textfield
    }()
    
    private let sendButton : UIButton = {
        let button = UIButton()
        let config = UIImage.SymbolConfiguration(pointSize: 22, weight: .regular)
        let image = UIImage(systemName: "paperplane.fill", withConfiguration: config)
        button.setImage(image, for: .normal)
        button.layer.masksToBounds = true
        button.contentMode = .scaleAspectFit
        button.tintColor = Constants.Color.general
        button.isEnabled = false
        return button
    }()
    
    ///icons
    private let facesButton: UIButton = {
        let button = UIButton()
        let config = UIImage.SymbolConfiguration(pointSize: 22, weight: .regular)
        let image = UIImage(systemName: "face.smiling", withConfiguration: config)
        button.setImage(image, for: .normal)
        button.clipsToBounds = true
        button.layer.masksToBounds = true
        button.tintColor = Constants.Color.general
        
        return button
    }()
    
    private let imagesButton: UIButton = {
        let button = UIButton()
        let config = UIImage.SymbolConfiguration(pointSize: 22, weight: .regular)
        let image = UIImage(systemName: "photo.on.rectangle.angled", withConfiguration: config)
        button.setImage(image, for: .normal)
        button.clipsToBounds = true
        button.layer.masksToBounds = true
        button.tintColor = Constants.Color.general
        return button
    }()
    
    private let gifButton: UIButton = {
        let button = UIButton()
        let config = UIImage.SymbolConfiguration(pointSize: 22, weight: .regular)
        let image = UIImage(systemName: "gift", withConfiguration: config)
        button.setImage(image, for: .normal)
        button.clipsToBounds = true
        button.layer.masksToBounds = true
        button.tintColor = Constants.Color.general
        return button
    }()
    
    // MARK: Init
    //init(model: UserpostViewModel?) {
    init(model: Userpost?) {
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
        tableView.backgroundColor = .systemBackground
        tableView.frame = view.bounds
    }
    
    override var hidesBottomBarWhenPushed: Bool {
        ///tabBarController?.tabBar.isHidden = true
        get{ return navigationController?.topViewController == self }
        set{ super.hidesBottomBarWhenPushed = newValue }
    }
    
    ///SetupView
    private func setupView() {
        view.addSubview(tableView)
        inputTextfield.delegate = self
        
        view.addSubview(messageInputContainerView)
        view.addConstraintWhithFormat(format:"H:|[v0]|",views: messageInputContainerView)
        view.addConstraintWhithFormat(format:"V:[v0(120)]",views: messageInputContainerView)
        
        bottomConstraint = NSLayoutConstraint(item: messageInputContainerView, attribute: .bottom, relatedBy: .equal, toItem: view, attribute: .bottom, multiplier: 1, constant: -0)
        view.addConstraint(bottomConstraint!)
        setupInputComponents()
        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboardNotification), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboardNotification), name: UIResponder.keyboardWillHideNotification, object: nil)
        
    }
    
    ///Validate textfield if empty.
    ///Paint bottom depending if it is empty or not.
    @objc func textDidChange(textField: UITextField) {
        let validateBool = !inputTextfield.text!.isEmpty
        if !validateBool {
            sendButton.isEnabled = validateBool
            sendButton.tintColor = Constants.Color.general
        } else {
            sendButton.isEnabled = validateBool
            sendButton.tintColor = Constants.Color.whiteLight
        }
    }
    
    @objc private func  handleKeyboardNotification(notification: NSNotification) {
        if let userInfo: NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            let keyboardFrame = userInfo.cgRectValue
            let isKeyBoardShowing = notification.name == UIResponder.keyboardWillShowNotification
            bottomConstraint?.constant = isKeyBoardShowing ? -keyboardFrame.height : 0
            UIView.animate(withDuration: 0, delay: 0, options: UIView.AnimationOptions.curveEaseOut, animations: {
                self.view.layoutIfNeeded()
            }, completion: {(completed) in
                let indexPath = NSIndexPath(item: self.renderModels.count-1, section: 0)
                self.tableView.scrollToRow(at: indexPath as IndexPath, at: .bottom, animated: true)
            })
        }
    }
    
    private func setupInputComponents() {
        let topBorderView = UIView()
        topBorderView.backgroundColor = UIColor(white: 0.5, alpha: 0.5)
        messageInputContainerView.addSubview(profilePhotoImageView)
        messageInputContainerView.addSubview(inputTextfield)
        messageInputContainerView.addSubview(topBorderView)
        
        ///Icons
        messageInputContainerView.addSubview(facesButton)
        messageInputContainerView.addSubview(imagesButton)
        messageInputContainerView.addSubview(gifButton)
        messageInputContainerView.addSubview(sendButton)
        
        topBorderView.frame = CGRect(
            x: 0,
            y: 0,
            width: view.width,
            height: 0.5)
        
        profilePhotoImageView.frame = CGRect(
            x: 10,
            y: 15,
            width: 50,
            height: 50)
        profilePhotoImageView.layer.cornerRadius = profilePhotoImageView.height/2
        
        
        inputTextfield.frame = CGRect(
            x: profilePhotoImageView.right+5,
            y: 15,
            width: view.width-profilePhotoImageView.width-30,
            height: 50)
        inputTextfield.layer.cornerRadius = inputTextfield.height/2
        
        ///Icons
        facesButton.frame = CGRect(
            x: 10,
            y: profilePhotoImageView.bottom+5,
            width: 30,
            height: 30)
        facesButton.layer.cornerRadius = facesButton.height/2
        
        
        imagesButton.frame = CGRect(
            x: facesButton.right+10,
            y: profilePhotoImageView.bottom+5,
            width: 30,
            height: 30)
        imagesButton.layer.cornerRadius = imagesButton.height/2
        
        gifButton.frame = CGRect(
            x: imagesButton.right+10,
            y: profilePhotoImageView.bottom+5,
            width: 30,
            height: 30)
        gifButton.layer.cornerRadius = gifButton.height/2
        
        
        sendButton.frame = CGRect(
            x: view.width-gifButton.width-15, 
            y: inputTextfield.bottom+5,
            width: 30,
            height: 30)
        sendButton.layer.cornerRadius = sendButton.height/2
    }
    
    
    private func configureTableView() {
        tableView.backgroundColor = .systemBackground
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
        guard let UserPostViewModelModel = self.model else { return }
        renderModels.append(UserPostViewModelRenderViewModel(renderType: .primaryContent(posts: UserPostViewModelModel)))
    }
    
    public func separator(cell:  CustomHeaderTableViewCell) {
        let separatorView = UIView(frame: CGRect(x: tableView.separatorInset.left, y: 0, width: 20, height: 1))
        separatorView.backgroundColor = .secondarySystemFill
        separatorView.translatesAutoresizingMaskIntoConstraints  = false
        cell.contentView.addSubview(separatorView)
        NSLayoutConstraint.activate([
            separatorView.leadingAnchor.constraint(equalTo:cell.contentView.leadingAnchor),
            separatorView.trailingAnchor.constraint(equalTo:cell.contentView.trailingAnchor),
            separatorView.heightAnchor.constraint(equalToConstant:1),
            separatorView.bottomAnchor.constraint(equalTo:cell.contentView.bottomAnchor)])
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
            ///return posts.comments.count > 0 ? posts.comments.count : posts.comments.count /// Retorna el total de comentarios
            guard let comments = posts.comments else { return 0 }
            return comments.count > 0 ? comments.count : comments.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = renderModels[indexPath.section]
        switch model.renderType {
            case .primaryContent(let posts):
                guard let comments = posts.comments else { return UITableViewCell() }
                let comment = comments[indexPath.row]
                let cell = tableView.dequeueReusableCell(withIdentifier: PostCommentsListTableViewCell.identifier, for: indexPath) as! PostCommentsListTableViewCell
                cell.configure(with: comment.user?.name ?? "", with: comment.content ?? "")
                return cell
        }
    }
 
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let model = renderModels[section]
        switch model.renderType {
        case .primaryContent(_/*let posts*/):
            let cell = tableView.dequeueReusableCell(withIdentifier: CustomHeaderTableViewCell.identifier) as! CustomHeaderTableViewCell
            //guard let username = posts.userAuthor?.username, let caption = posts.content else { return UIView() }
            //cell.configure(with: username, with: caption)
            separator(cell: cell)
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
        inputTextfield.endEditing(true)
    }
    
}
