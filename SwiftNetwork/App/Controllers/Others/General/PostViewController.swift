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
    case header(provider: Userpost)
    case primaryContent(provider: Userpost)
    case actions(provider: Userpost)
    case descriptions(post: Userpost)
    case comments(comments: [Comment])
    case footer(footer: Userpost)
}*/

enum PostRenderType {
    case collections(collections: [CollectionTableCellModel], createStory: [CollectionTableCellModel])
    case header(provider: CD0011_posts )
    case primaryContent(provider: CD0011_posts)
    case actions(provider: CD0011_posts)
    case descriptions(post: CD0011_posts)
    case comments(comments: [CD0014_comments])
    case footer(footer: CD0011_posts)
}

/// Model of  renderd Post
struct PostRenderViewModel {
    let renderType: PostRenderType
}

class PostViewController: UIViewController {

    private let tableView: UITableView = {  		
        let tableView = UITableView()
        return tableView
    }()
    
    lazy var settingsPost: SettingsPost = {
        let launcher = SettingsPost()
        launcher.postController = self
        return launcher
    }()
    
    lazy var settingsCaption: SettingCaption = {
        let launcher = SettingCaption()
        launcher.postController = self
        return launcher
    }()
    
    let captionContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemBackground
        return view
    }()
    
    let captionTextField : UITextField = {
        let text = UITextField()
        text.backgroundColor = .systemBackground
        return text
    }()
    
    let cancelButton : UIButton = {
        let button = UIButton()
        button.setTitle("Cancelar", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = .systemBackground
        return button
    }()
    
    let titleLabel : UILabel = {
        let label = UILabel()
        label.backgroundColor = .systemBackground
        label.text = "Editar información"
        label.font = .systemFont(ofSize: 16, weight: .bold)
        label.textAlignment = .center
        return label
    }()
    
    let saveButton : UIButton = {
        let button = UIButton()
        button.setTitle("Guardar", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = .systemBackground
        return button
    }()
    
    private func setupSpinner() -> UIActivityIndicatorView {
        let spinerView = SpinnerView.shared.setupSpinner()
        spinerView.center = view.center
        SpinnerView.shared.VW_overlay = UIView(frame: UIScreen.main.bounds)
        SpinnerView.shared.VW_overlay.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.5)
        return spinerView
    }
    
    private var model: CD0011_posts?
    
    private var renderModels = [PostRenderViewModel]()
    
    private var viewModel = HomeViewModel()
    
    static let database = DatabaseHandler.shared
    
    var bottomConstraint: NSLayoutConstraint?
    
    
    // MARK: - INIT RECEIVE DATA FROM THE PROFILEVIEWCONTROLLER.
    init(model: CD0011_posts?) {
        self.model = model
        super.init(nibName: nil, bundle: nil)
        guard let model = model else { return }
        self.setupModel(with: model)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: VIEW DID LOAD.
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
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    // MODEL.
    private func setupModel(with model: CD0011_posts ) {
        guard let comments = model.comments else { return }
        renderModels.append(PostRenderViewModel(renderType: .header(provider: model)))
        renderModels.append(PostRenderViewModel(renderType: .primaryContent(provider: model)))
        renderModels.append(PostRenderViewModel(renderType: .actions(provider: model)))
        renderModels.append(PostRenderViewModel(renderType: .descriptions(post: model)))
        renderModels.append(PostRenderViewModel(renderType: .comments(comments: [comments] )))
        renderModels.append(PostRenderViewModel(renderType: .footer(footer: model)))
    }
    
    // SETUP VIEW.
    private func setupView() {
        view.backgroundColor = .systemBackground
        view.addSubview(tableView)
    }
    
    // CONFIGURE TABLEVIEW.
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
    
    // DELEGATES
    private func delegateTableView() {
        tableView.delegate = self
        tableView.dataSource = self
    }
}

//MARK: - Extension UITableViewDelegate & UITableViewDataSource
extension PostViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return renderModels.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch renderModels[section].renderType {
            case .actions(_)        : return 1
            case .comments(_)       : return 1 //return comments.count > 0 ? comments.count : comments.count
            case .primaryContent(_) : return 1
            case .header(_)         : return 1
            case .descriptions(_)   : return 1
            case .footer(_)         : return 1
            case .collections(_,_)  : return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = renderModels[indexPath.section]
        
        switch model.renderType {
            //HEADER
            case .header(let post):
                let cell = tableView.dequeueReusableCell(withIdentifier: IGFeedPostHeaderTableViewCell.identifier,for: indexPath) as! IGFeedPostHeaderTableViewCell
                cell.setCellWithValuesOf(with: post)
                cell.delegate = self
                return cell
                
            // POST
            case .primaryContent(let post):
                let cell = tableView.dequeueReusableCell(withIdentifier: IGFeedPostTableViewCell.identifier, for: indexPath) as! IGFeedPostTableViewCell
                let images = viewModel.fetchPrimaryContent(post: post) //viewModel.fetchPostImageData(post: post)
                cell.configure(image: images)
                return cell
                
            //ACTION
            case .actions(_):
                let cell = tableView.dequeueReusableCell(withIdentifier: IGFeedPostActionsTableViewCell.identifier, for: indexPath) as! IGFeedPostActionsTableViewCell
                return cell
                
            // DESCRIPTION
            case .descriptions(let post):
                let cell = tableView.dequeueReusableCell(withIdentifier: IGFeedPostDescriptionTableViewCell.identifier, for: indexPath) as! IGFeedPostDescriptionTableViewCell
                let countLikes      = viewModel.countLikes(model: post, like: post.likes)
                let countComments   = viewModel.countComments(model: post, comment: post.comments)
                let username        = viewModel.getUsername(post: post)
                let content         = viewModel.getContent(post: post)
                let imageHeader     = viewModel.getImageHeader(post: post)
                cell.setCellWithValuesOf(countLikes: countLikes, countComments: countComments, username: username, content: content, image: imageHeader)
                //cell.delegate = self
                return cell
                
            // COMMENTS
            case .comments(_):
                let cell = tableView.dequeueReusableCell(withIdentifier: IGFeedPostGeneralTableViewCell.identifier, for: indexPath) as! IGFeedPostGeneralTableViewCell
                cell.setCellWithValuesOf()
                return cell
        
            // FOOTER
            case .footer(let footer):
                let cell = tableView.dequeueReusableCell(withIdentifier: IGFeedPostFooterTableViewCell.identifier, for: indexPath) as! IGFeedPostFooterTableViewCell
                let imageHeader = viewModel.getImageHeader(post: footer)
                cell.setCellWithValuesOf(image: imageHeader)
                //cell.delegate = self
                return cell
                
            // COLLECTIONS
            case .collections(_,_):
                return UITableViewCell()
        }
    }
    
    // HEIGHT FOR ROW AT.
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let model = renderModels[indexPath.section]
        switch model.renderType {
            case .actions(_)        : return 60                 ///Actions
            case .comments(_)       : return 25                 ///Comments
            case .primaryContent(_) : return tableView.width    ///Post
            case .header(_)         : return 70                 ///Hader
            case .descriptions(_)   : return 85                 ///Descriptions
            case .collections(_,_)  : return 50                 ///Collections
            case .footer(_)         : return 50                 ///Footer
        }
    }
    
    // DID SELECT ROW AT.
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

//MARK: - Extension IGFeedPostDescriptionTableViewCellDelegate
extension PostViewController: IGFeedPostDescriptionTableViewCellDelegate {
    
    // Did tap Like.
    func didTapLikeButton() {
        print("didTapLikeButton")
    }
    
    // Did tap Comments.
    func didTapCommentButton(model: Userpost) {
        let vc = ListCommentsViewController(model: model)
        vc.title = "Coments"
        vc.navigationItem.largeTitleDisplayMode = .never
        navigationController?.pushViewController(vc, animated: true)
    }
    
    // Did Tap Send.
    func didTapSendButton() {
        print("didTapLikeButton")
    }
}

//MARK: - Extension IGFeedPostHeaderTableViewCellDelegate
extension PostViewController: IGFeedPostHeaderTableViewCellDelegate {
    
    // Did tap more button.
    func didTapMoreButton(post: CD0011_posts) {
        print("Post view constroller")
        self.settingsPost.showSettings(post: post)
        self.settingsPost.postController = self
    }
    
    // Show setting.
    public func showControllerForSetting(index:Int, setting: Setting, post: CD0011_posts?) {
        switch index {
            case 0: break /// Delete
            case 1: addCaptionView(post: post)
            case 2: break /// Shared
            case 4: break /// Cancel
            default: print("error select shared options")
        }
    }
}


//MARK: - Extension PostViewController
extension PostViewController {
    private func addCaptionView(post: CD0011_posts?) {
        DispatchQueue.main.async {
            self.captionTextField.becomeFirstResponder()
            guard let caption = post?.content else { return }
            self.captionTextField.text = caption
            self.captionTextField.textAlignment = .left
            self.captionTextField.font = .systemFont(ofSize: 12, weight: .regular)
        }
        
        view.addSubview(captionContainerView)
        view.addConstraintWhithFormat(format:"H:|[v0]|",views: captionContainerView)
        view.addConstraintWhithFormat(format:"V:[v0(100)]",views: captionContainerView)
    
        setupInputComponents()
        handlePushButtonNext()
    }
    
    private func setupInputComponents() {
        captionContainerView.addSubview(cancelButton)
        captionContainerView.addSubview(titleLabel)
        captionContainerView.addSubview(saveButton)
        captionContainerView.addSubview(captionTextField)
        
        // Button Cancel.
        captionContainerView.addConstraintWhithFormat(format:"H:|-5-[v0(80)]", views: cancelButton)
        captionContainerView.addConstraintWhithFormat(format:"V:|-5-[v0]", views: cancelButton)
        
        // UILabel Title.
        captionContainerView.addConstraintWhithFormat(format:"H:[v0(80)]-5-[v1]", views: cancelButton, titleLabel)
        captionContainerView.addConstraintWhithFormat(format:"V:|-5-[v0(35)]", views: titleLabel)
        
        // Button Save.
        captionContainerView.addConstraintWhithFormat(format:"H:[v0]-5-[v1(80)]-5-|", views: titleLabel, saveButton)
        captionContainerView.addConstraintWhithFormat(format:"V:|-5-[v0]", views: saveButton)
        
        // UiTextFielf Caption.
        captionContainerView.addConstraintWhithFormat(format:"H:|-5-[v0]-5-|", views: captionTextField )
        captionContainerView.addConstraintWhithFormat(format:"V:[v0]-5-[v1(35)]", views: saveButton, captionTextField)
        
        // Buttons [Cancel & Save]
        saveButton.addTarget(self, action: #selector(didTapSaveCaption), for: .touchUpInside)
        cancelButton.addTarget(self, action: #selector(didTapCancelCaption), for: .touchUpInside)
    }
    
    // Handle Push Button Next
    func handlePushButtonNext() {
        bottomConstraint = NSLayoutConstraint(item: captionContainerView, attribute: .top, relatedBy: .equal, toItem: view, attribute: .bottom, multiplier:1, constant: 0)
        view.addConstraint(bottomConstraint!)
        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboardNotification),name: UIResponder.keyboardWillShowNotification, object: nil)
    }
    
    // Up keyboard
    @objc func handleKeyboardNotification(notificacion: NSNotification) {
        if let userInfo: NSValue = notificacion.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            let keyboardFrame = userInfo.cgRectValue
            let isKeyBoardShowing = notificacion.name == UIResponder.keyboardWillShowNotification
            bottomConstraint?.constant = isKeyBoardShowing ? -keyboardFrame.height : 0
            UIView.animate(withDuration: 0, delay: 0, options: UIView.AnimationOptions.curveEaseOut, animations: {
                self.view.layoutIfNeeded()
            }, completion: {(completed) in})
        }
    }
    
    //MARK: Did tap Save button or update core..
    @objc func didTapSaveCaption() {
        guard let idPost = self.model?.id, let newCaption = captionTextField.text else { return }
        self.model?.content = newCaption
        let update = PostViewController.database.update(CD0011_posts.self, author_ref_id: Int(idPost))
        if update {
            buttonUpdatePostContent()
            NotificationCenter.default.removeObserver(self)
        } else {
            print("No se pude actualizar el dato del caption....")
        }
    }
    
    //MARK: Save context.
    func buttonUpdatePostContent() {
        view.addSubview(setupSpinner())
        DispatchQueue.main.async {
        //DispatchQueue.main.asyncAfter(deadline: .now()+4) {
            self.tableView.reloadData()
            SpinnerView.shared.spinner.stopAnimating()
            SpinnerView.shared.VW_overlay.isHidden = true
            self.captionTextField.resignFirstResponder()
            NotificationCenter.default.addObserver(self, selector: #selector(self.handleKeyboardNotification), name: UIResponder.keyboardDidHideNotification, object: nil)
        }
    }
    
    //MARK: Did tap cancel button.
    @objc func didTapCancelCaption() {
        buttonCancelCaption()
    }
    
    //MARK: Cancel context.
    func buttonCancelCaption() {
        self.captionTextField.resignFirstResponder()
        NotificationCenter.default.addObserver(self, selector: #selector(self.handleKeyboardNotification), name: UIResponder.keyboardDidHideNotification, object: nil)
    }
}
