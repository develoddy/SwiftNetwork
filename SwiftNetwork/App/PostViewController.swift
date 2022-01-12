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
    case header(provider: Userpost)
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
    
    //let itemArray = [Userpost]()
    
    private var model: Userpost?
    
    private var renderModels = [PostRenderViewModel]()
    
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
    
    var bottomConstraint: NSLayoutConstraint?
    
    private func setupSpinner() -> UIActivityIndicatorView {
        let spinerView = SpinnerView.shared.setupSpinner()
        spinerView.center = view.center
        SpinnerView.shared.VW_overlay = UIView(frame: UIScreen.main.bounds)
        SpinnerView.shared.VW_overlay.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.5)
        return spinerView
    }
    
    private var viewModel = UserPostViewModel()
    
    
    // MARK: - Init Receive data from the ProfileViewcontroller
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
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
    }
    
    // Models
    // Está función revcibe los datos para tratarlos y guardalos en el array Modelo.
    private func setupModel(with model: Userpost ) {
        //guard let ownew = model.userAuthor else { return }
        guard let comments = model.comments else { return }
        renderModels.append(PostRenderViewModel(renderType: .header(provider: model)))
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
    
    public func getUserToken() -> ResponseTokenBE? {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        guard let token = appDelegate.objUsuarioSesion else {
            return getUserToken()
        }
        return token
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
        case .header(let post):
              let cell = tableView.dequeueReusableCell(withIdentifier: IGFeedPostHeaderTableViewCell.identifier,for: indexPath) as! IGFeedPostHeaderTableViewCell
            cell.configure(with: post)
            cell.delegate = self
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


extension PostViewController: IGFeedPostHeaderTableViewCellDelegate {
    
    func didTapMoreButton(post: Userpost) {
        print("Post view constroller")
        self.settingsPost.showSettings(post: post)
        self.settingsPost.postController = self
    }
    
    public func showControllerForSetting(index:Int, setting: Setting, post: Userpost?) {
        switch index {
            case 0: break /// Delete
            case 1:
                addCaptionView(post: post)
            case 2: break /// Shared
            case 4: break /// Cancel
            default:
                print("error select shared options")
        }
    }
}


extension PostViewController {
    
    private func addCaptionView(post: Userpost?) {
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
        
        ///Button Cancel
        captionContainerView.addConstraintWhithFormat(format:"H:|-5-[v0(80)]", views: cancelButton)
        captionContainerView.addConstraintWhithFormat(format:"V:|-5-[v0]", views: cancelButton)
        
        ///UILabel Title
        captionContainerView.addConstraintWhithFormat(format:"H:[v0(80)]-5-[v1]", views: cancelButton, titleLabel)
        captionContainerView.addConstraintWhithFormat(format:"V:|-5-[v0(35)]", views: titleLabel)
        
        ///Button Save
        captionContainerView.addConstraintWhithFormat(format:"H:[v0]-5-[v1(80)]-5-|", views: titleLabel, saveButton)
        captionContainerView.addConstraintWhithFormat(format:"V:|-5-[v0]", views: saveButton)
        
        ///UiTextFielf Caption
        captionContainerView.addConstraintWhithFormat(format:"H:|-5-[v0]-5-|", views: captionTextField )
        captionContainerView.addConstraintWhithFormat(format:"V:[v0]-5-[v1(35)]", views: saveButton, captionTextField)
        
        saveButton.addTarget(self, action: #selector(didTapSaveCaption), for: .touchUpInside)
    }
    
    
    func handlePushButtonNext() {
        bottomConstraint = NSLayoutConstraint(item: captionContainerView, attribute: .top, relatedBy: .equal, toItem: view, attribute: .bottom, multiplier:1, constant: 0)
        view.addConstraint(bottomConstraint!)
        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboardNotification),name: UIResponder.keyboardWillShowNotification, object: nil)
        //NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboardNotification), name: UIResponder.keyboardDidHideNotification, object: nil)
    }
    
    /// up keyboard
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
    
    @objc func didTapSaveCaption(){
        print(".... hay echo click en save caption......")
        
        //NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboardNotification),name: UIResponder.keyboardWillShowNotification, object: nil)
        //NotificationCenter.default.removeObserver(self) // Remove from all notifications being observed
        
        guard let idpost = model?.id else { return}
        guard let token = getUserToken()?.token else { return }
        var caption = Caption()
        caption.content = self.captionTextField.text
    
        /*APIService.shared.apiPostCaptionUpdate(caption: caption, idpost: idpost, token: token) {( result ) in
            switch result {
            case .success(let message):
                print(message)
                self.saveData()
            case .failure(let error):
                print(error.localizedDescription)
            }
        }*/
    }
    
    //MARK: Save Context
    func saveData() {
        print(".... saveData ......")
        view.addSubview(setupSpinner())
        
        DispatchQueue.main.asyncAfter(deadline: .now()+4) {
        ///DispatchQueue.main.async {
            SpinnerView.shared.spinner.stopAnimating()
            SpinnerView.shared.VW_overlay.isHidden = true
            self.captionTextField.resignFirstResponder()
            NotificationCenter.default.addObserver(self, selector: #selector(self.handleKeyboardNotification), name: UIResponder.keyboardDidHideNotification, object: nil)
        }
    }
}
