//
//  StorieViewController.swift
//  SwiftNetwork
//
//  Created by Eddy Donald Chinchay Lujan on 16/7/21.
//

import UIKit

class Story: NSObject {
    let imageName: String
    let name: String
    init(imageName: String, name: String) {
        self.imageName = imageName
        self.name = name
    }
}



class StoryViewController: UIViewController, SegmentedProgressBarDelegate {
    
    var bottomConstraint: NSLayoutConstraint?
    
    private var progressView: SegmentedProgressBar!
    
    private let imageStoryView = UIImageView()
    
    private let images = [#imageLiteral(resourceName: "eddy"), #imageLiteral(resourceName: "img2"), #imageLiteral(resourceName: "img1")]
    
    private let footerView =  UIView()
    
    private let figureLeftView: UIView = {
        let view = UIView()
        return view
    }()
    
    private let figureRightView: UIView = {
        let view = UIView()
        return view
    }()
    
    private let profilePhotoView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "eddy")
        imageView.tintColor = .white
        imageView.clipsToBounds = true
        imageView.layer.masksToBounds = true
        return imageView
    }()
    
    private let usernameLabel: UIButton = {
        let button = UIButton()
        button.setTitle("eddylujann", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 16, weight: .semibold)
        let config = UIImage.SymbolConfiguration(pointSize: 12, weight: .semibold)
        button.setImage(UIImage(systemName: "checkmark.seal.fill", withConfiguration: config)?.withRenderingMode(.alwaysOriginal).withTintColor(.white), for: .normal)
        button.contentHorizontalAlignment = .left
        button.semanticContentAttribute = .forceRightToLeft
        return button
    }()
    
    private let timeLabel : UILabel = {
        let label = UILabel()
        label.text = "30 min"
        label.font = .systemFont(ofSize: 14, weight: .regular)
        label.textColor = .white
        return label
    }()
    
    private let closeStoryButton: UIButton = {
        let button = UIButton()
        button.tintColor = .white
        let config = UIImage.SymbolConfiguration(pointSize: 24, weight: .semibold)
        button.setImage(UIImage(systemName: "xmark", withConfiguration: config)?.withRenderingMode(.alwaysOriginal).withTintColor(.white), for: .normal)
        button.addTarget(self, action: #selector(handleDismiss), for: .touchUpInside)
        return button
    }()
    
    //Footer View Components
    private let profilePhotoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "eddy")
        imageView.clipsToBounds = true
        imageView.layer.masksToBounds = true
        imageView.backgroundColor = Constants.Color.darkLigth
        imageView.layer.borderWidth = 1
        imageView.layer.borderColor = Constants.Color.dark.cgColor
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private let inputTextfield : UITextField = {
        let textfield = UITextField()
        textfield.attributedPlaceholder = NSAttributedString(string: "Escribe un comentario...", attributes: [NSAttributedString.Key.foregroundColor: Constants.Color.dark])
        textfield.font = Constants.fontSize.regular
        textfield.backgroundColor = Constants.Color.darkLigth
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
        button.tintColor = Constants.Color.dark
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
        button.tintColor = Constants.Color.whiteLight
        
        return button
    }()
    
    private let imagesButton: UIButton = {
        let button = UIButton()
        let config = UIImage.SymbolConfiguration(pointSize: 22, weight: .regular)
        let image = UIImage(systemName: "photo.on.rectangle.angled", withConfiguration: config)
        button.setImage(image, for: .normal)
        button.clipsToBounds = true
        button.layer.masksToBounds = true
        button.tintColor = Constants.Color.whiteLight
        return button
    }()
    
    private let gifButton: UIButton = {
        let button = UIButton()
        let config = UIImage.SymbolConfiguration(pointSize: 22, weight: .regular)
        let image = UIImage(systemName: "gift", withConfiguration: config)
        button.setImage(image, for: .normal)
        button.clipsToBounds = true
        button.layer.masksToBounds = true
        button.tintColor = Constants.Color.whiteLight
        return button
    }()
    
    
    //MARK: viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        gestureRecognizer()
        
        imageStoryView.frame = view.bounds
        imageStoryView.clipsToBounds = true
        imageStoryView.contentMode = .scaleAspectFill
        imageStoryView.layer.cornerRadius = 22
        imageStoryView.layer.borderWidth = 0
        
        view.addSubview(imageStoryView)

        updateImage(index: 0)
            
        progressView = SegmentedProgressBar(numberOfSegments: 3, duration: 5)
        progressView.frame = CGRect(x: 15, y: 45, width: view.frame.width - 30, height: 4)
        progressView.delegate = self
        progressView.topColor = UIColor.white
        progressView.bottomColor = UIColor.white.withAlphaComponent(0.25)
        progressView.padding = 2
        view.addSubview(progressView)
        
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tappedView)))
        
        setupView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        progressView.startAnimation()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        let size = view.width/3
        
        ///profilePhotoButton
        profilePhotoView.frame = CGRect(
                x: 5,
                y: progressView.bottom+15,
                width: 45,
                height: 45)
        profilePhotoView.layer.cornerRadius = profilePhotoView.height/2
        
        ///UserNameButton
        let usernameLabelSize = usernameLabel.sizeThatFits(view.frame.size)
        usernameLabel.frame = CGRect(
                x: profilePhotoView.right+15,
                y: progressView.bottom+15,
                width: view.width-(size),
            height: usernameLabelSize.height).integral
        usernameLabel.backgroundColor = .clear
        
        let timeLabelSize = timeLabel.sizeThatFits(view.frame.size)
        timeLabel.frame = CGRect(
            x: profilePhotoView.right+15,
            y: usernameLabel.bottom,
            width: view.width-(size),
            height: timeLabelSize.height).integral
        timeLabel.backgroundColor = .clear
        
        ///More Button
        closeStoryButton.frame = CGRect(
            x: usernameLabel.right+5,
            y: progressView.bottom+15,
            width:size/2,
            height:50)
        closeStoryButton.backgroundColor = .clear
    
        ///ImageStorie
        imageStoryView.frame = CGRect(x: 0, y: 0, width: view.width, height: view.height/1.2)
        
        ///Left
        figureLeftView.backgroundColor = .clear
        figureLeftView.frame = CGRect(
            x: 0,
            y: view.height/6,
            width: view.width/2,
            height: view.height)
        
        ///Right
        figureRightView.backgroundColor = .clear
        figureRightView.frame = CGRect(
            x: figureLeftView.right,
            y: view.height/6,
            width: view.width/2,
            height: view.height)
        
        ///Footer
        ///let theHeight = view.frame.size.height
        //footerView.backgroundColor = .white
        /*footerView.frame = CGRect(
            x: 0,
            y: imageStoryView.bottom, //theHeight-100,
            width: view.frame.width,
            height: view.height)*/
    }
    
    private func setupView() {
        view.backgroundColor = .black
        view.addSubview(profilePhotoView)
        view.addSubview(usernameLabel)
        view.addSubview(timeLabel)
        view.addSubview(closeStoryButton)
        view.addSubview(figureLeftView)
        view.addSubview(figureRightView)
        view.addSubview(footerView)
        
        view.addConstraintWhithFormat(format:"H:|[v0]|",views: footerView)
        view.addConstraintWhithFormat(format:"V:[v0(125)]",views: footerView)
        
        bottomConstraint = NSLayoutConstraint(
            item: footerView,
            attribute: .bottom,
            relatedBy: .equal,
            toItem: view,
            attribute: .bottom,
            multiplier: 1,
            constant: -0)
        view.addConstraint(bottomConstraint!)
        
        setupFooterViewComponents()
        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboardNotification), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboardNotification), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    private func  setupFooterViewComponents() {
        let topBorderView = UIView()
        topBorderView.backgroundColor = UIColor(white: 0.5, alpha: 0.5)
        
        footerView.backgroundColor = .black
        footerView.addSubview(profilePhotoImageView)
        footerView.addSubview(inputTextfield)
        footerView.addSubview(sendButton)
        ///Icons
        footerView.addSubview(facesButton)
        footerView.addSubview(imagesButton)
        footerView.addSubview(gifButton)
        footerView.addSubview(sendButton)
        
        let size = view.width/3
        profilePhotoImageView.frame = CGRect(
            x: 10,
            y: 15,
            width: 45,
            height: 45)
        profilePhotoImageView.layer.cornerRadius = profilePhotoImageView.height/2
        
        inputTextfield.frame = CGRect(
            x: profilePhotoImageView.right+15,
            y: 15,
            width: view.width-(size),
            height: 45)
        inputTextfield.layer.cornerRadius = inputTextfield.height/2
        
        sendButton.frame = CGRect(
            x: inputTextfield.right,
            y: 15,
            width: size/2,
            height: 45)
        sendButton.layer.cornerRadius = sendButton.height/2
        
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
    }
    
    @objc private func  handleKeyboardNotification(notification: NSNotification) {
        if let userInfo: NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            let keyboardFrame = userInfo.cgRectValue
            let isKeyBoardShowing = notification.name == UIResponder.keyboardWillShowNotification
            bottomConstraint?.constant = isKeyBoardShowing ? -keyboardFrame.height : 0
            UIView.animate(withDuration: 0, delay: 0, options: UIView.AnimationOptions.curveEaseOut, animations: {
                self.view.layoutIfNeeded()
            }, completion: {(completed) in
                ///let indexPath = NSIndexPath(item: self.renderModels.count-1, section: 0)
                ///self.tableView.scrollToRow(at: indexPath as IndexPath, at: .bottom, animated: true)
            })
        }
    }
    
    func  gestureRecognizer() {
        view.isUserInteractionEnabled = true
        ///Tap Right
        let singleLeftTap = UITapGestureRecognizer(target: self, action: #selector(tapLeftForSingleFigure))
        singleLeftTap.numberOfTapsRequired = 1
        singleLeftTap.numberOfTouchesRequired = 1
        figureLeftView.addGestureRecognizer(singleLeftTap)

        ///Tap Left
        let singleRightTap = UITapGestureRecognizer(target: self, action: #selector(tapRightForSingleFigure))
        singleRightTap.numberOfTapsRequired = 1
        singleRightTap.numberOfTouchesRequired = 1
        figureRightView.addGestureRecognizer(singleRightTap)
        
        
        /**var swipe = UISwipeGestureRecognizer(target: self, action: #selector(tapForSwipe))
        swipe.direction = .down
        swipe.numberOfTouchesRequired = 1
        view.addGestureRecognizer(swipe)
        
        swipe = UISwipeGestureRecognizer(target: self, action: #selector(tapForSwipe))
        swipe.direction = .up
        swipe.numberOfTouchesRequired = 1
        view.addGestureRecognizer(swipe)
        
        swipe = UISwipeGestureRecognizer(target: self, action: #selector(tapForSwipe))
        swipe.direction = .left
        swipe.numberOfTouchesRequired = 1
        view.addGestureRecognizer(swipe)
        
        swipe = UISwipeGestureRecognizer(target: self, action: #selector(tapForSwipe))
        swipe.direction = .right
        swipe.numberOfTouchesRequired = 1
        self.view.addGestureRecognizer(swipe)*/
    }
    
    //MARK: Init Receive data from the ProfileViewcontroller
    init(model: CollectionTableCellModel?) {
        super.init(nibName: nil, bundle: nil)
    }
        
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }

    func segmentedProgressBarChangedIndex(index: Int) {
        print("Now showing index: \(index)")
        updateImage(index: index)
    }
    
    func segmentedProgressBarFinished() {
        print("Finished!")
    }
   
    private func updateImage(index: Int) {
        imageStoryView.image = images[index]
    }
    
    @objc func handleDismiss() {
        dismiss(animated: true, completion: nil)
    }
    
    @objc private func tappedView() {
        progressView.isPaused = !progressView.isPaused
   }
    
    @objc private func tapLeftForSingleFigure() {
        print("Tap left For Single Figure")
        progressView.rewind()
    }
    
    @objc private func tapRightForSingleFigure() {
        print("Tap right For Single Figure")
        progressView.skip()
    }
    
    @objc private func tapForSwipe(sender: UISwipeGestureRecognizer) {
        if sender.direction == .down {
            print("down Tap")
        } else if sender.direction == .up {
            print("up Tap")
        } else if sender.direction == .left {
            print("left Tap")
            progressView.skip()
        } else if sender.direction == .right {
            print("right Tap")
            progressView.rewind()
        }
    }
    
    @objc func textDidChange(textField: UITextField) {
        let validateBool = !inputTextfield.text!.isEmpty
        ///sendButton.isEnabled = !inputTextfield.text!.isEmpty
        if !validateBool {
            sendButton.isEnabled = validateBool
            sendButton.tintColor = Constants.Color.dark
            
        } else {
            sendButton.isEnabled = validateBool
            sendButton.tintColor = Constants.Color.purple
        }
    }
}
