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
    func profileWritePostDidTapEditProfileButton( _post:  ProfileInfoHeaderCollectionReusableView)
}

final class ProfileInfoHeaderCollectionReusableView: UICollectionReusableView {
    
    var stackView = UIStackView()
    
    static let identifier = "ProfileInfoHeaderCollectionReusableView"
    
    public var delegate: ProfileInfoHeaderCollectionReusableViewDelegate?
    
    let gradient = CAGradientLayer()
    
    ///Profile image
    private let profilePhotoImageView : UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "eddy"))
        imageView.tintColor = .black
        imageView.layer.masksToBounds = true
        imageView.layer.borderWidth = 2.5
        imageView.layer.borderColor = UIColor.white.cgColor
        return imageView
    }()
    ///Username
    private let usernameLabel : UIButton = { //checkmark.seal.fill
        let button = UIButton()
        button.setTitle("@eddylujann", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.contentHorizontalAlignment = .center
        button.setImage(UIImage(systemName: "checkmark.seal.fill"), for: .normal)
        button.semanticContentAttribute = .forceRightToLeft
        button.titleLabel?.font = .systemFont(ofSize: 14, weight: .semibold)
        return button
    }()
    ///PostButton
    private let postButton : UIButton = {
        let button = UIButton()
        button.titleLabel?.font = .systemFont(ofSize: 14, weight: .thin)
        button.titleLabel?.textAlignment = .center
        button.backgroundColor = .systemBackground
        button.setTitleColor(.label, for: .normal)
        return button
    }()
    ///Followers
    private let followersButton : UIButton = {
        let button = UIButton()
        button.titleLabel?.font = .systemFont(ofSize: 14, weight: .thin)
        button.titleLabel?.textAlignment = .center
        button.backgroundColor = .systemBackground
        button.setTitleColor(.label, for: .normal)
        return button
    }()
    ///Following
    private let followingButton : UIButton = {
        let button = UIButton()
        button.titleLabel?.font = .systemFont(ofSize: 14, weight: .thin)
        button.titleLabel?.textAlignment = .center
        button.backgroundColor = .systemBackground
        button.setTitleColor(.label, for: .normal)
        return button
    }()
    ///Bio
    private let bioLabel : UILabel = {
        let label = UILabel()
        label.backgroundColor = .systemBackground
        label.font = .systemFont(ofSize: 14, weight: .regular)
        label.text = "Life style is muy one bio \n#madrid"
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 3
        return label
    }()
    ///Edit profile
    private let editProfileButton : UIButton = {
        let button = UIButton()
        button.setTitle("Editar tu perfil", for: .normal)
        button.setImage(UIImage(systemName: "square.and.pencil"), for: .normal)
        button.tintColor = .white
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 16, weight: .bold)
        button.layer.cornerRadius = 26
        return button
    }()
    
    
    
    // MARK: -Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubviews()
        addButtonActions()
        addTextOnPostButton()
        addTextOnFollowersButton()
        addTextOnFollowingButton()
        configureButtonEditProfile()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addSubviews() {
        addSubview(profilePhotoImageView)
        addSubview(usernameLabel)
        addSubview(postButton)
        addSubview(followersButton)
        addSubview(followingButton)
        addSubview(bioLabel)
        addSubview(editProfileButton)
    }
    
    private func addButtonActions() {
        followersButton.addTarget(self, action: #selector(didTapFollowerButton), for: .touchUpInside)
        followingButton.addTarget(self, action: #selector(didTapFollowingButton), for: .touchUpInside)
        postButton.addTarget(self, action: #selector(didTapPostsButton), for: .touchUpInside)
        editProfileButton.addTarget(self, action: #selector(didTapEditProfileButton), for: .touchUpInside)
    }
    
    
    private func configureButtonEditProfile() {
        //gradient.colors = [UIColor(red: 0.50, green: 0.00, blue: 1.00, alpha: 1.00).cgColor, UIColor(red: 0.88, green: 0.00, blue: 1.00, alpha: 1.00).cgColor]
        gradient.colors = [UIColor(red: 0.50, green: 0.00, blue: 1.00, alpha: 1.00).cgColor, UIColor(red: 0.88, green: 0.00, blue: 1.00, alpha: 1.00).cgColor]
        gradient.startPoint = CGPoint(x: 0, y: 1)
        gradient.endPoint = CGPoint(x: 1, y: 1)
        editProfileButton.layer.insertSublayer(gradient, at: 0)
        editProfileButton.layer.masksToBounds = true
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        gradient.frame = bounds

        let profilePhotoSize = width/4
        profilePhotoImageView.frame = CGRect(x: width/2.7,y: 10,width: profilePhotoSize,height: profilePhotoSize).integral
        profilePhotoImageView.layer.cornerRadius = profilePhotoSize/2.0
        
        let usernameLabelSize = usernameLabel.sizeThatFits(frame.size)
        usernameLabel.frame = CGRect(
            x: 5,
            y: profilePhotoImageView.bottom+5,
            width: width-10,
            height: usernameLabelSize.height).integral
        
        let buttonHeight = profilePhotoSize/2
        let countButtonWidth = (width)/3
        
        ///Post
        postButton.frame = CGRect(
            x: 5,
            y: usernameLabel.bottom+5,
            width: countButtonWidth,
            height: buttonHeight
        ).integral
        
        ///Followers
        followersButton.frame = CGRect(
            x: postButton.right,
            y: usernameLabel.bottom+5,
            width: countButtonWidth,
            height: buttonHeight
        ).integral
        
        ///Following
        followingButton.frame = CGRect(
            x: followersButton.right,
            y: usernameLabel.bottom+5,
            width: countButtonWidth,
            height: buttonHeight
        ).integral
        
        ///Bio
        let bioLabelSizeWidth = (width-10)/1
        let bioLabelSize = bioLabel.sizeThatFits(frame.size)
        bioLabel.frame = CGRect(
            x: 10,
            y: followingButton.bottom+5,
            width: bioLabelSizeWidth ,
            height: bioLabelSize.height)
        
        ///Edit Profile
        editProfileButton.frame = CGRect(
            x: 10,
            y: bioLabel.bottom+10,
            width: (countButtonWidth*3)-20,
            height: buttonHeight).integral
    }
    
    override func prepareForReuse() {
        //usernameLabel.setTitle(nil, for: .normal)
    }
    
    
    public func configure(model: UserpostViewModel) {
        //usernameLabel.setTitle(model.owner.username, for: .normal)
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
    @objc private func didTapWritePostButton() {
        delegate?.profileWritePostDidTapEditProfileButton(_post: self)
    }
}


//MARK: Add text on buttons
extension ProfileInfoHeaderCollectionReusableView {
    private func addTextOnPostButton() {
        postButton.titleLabel?.lineBreakMode = NSLineBreakMode.byWordWrapping
        let buttonText: NSString = "10\nPublicaciones"
        let newlineRange: NSRange = buttonText.range(of: "\n")
        
        //getting both substrings
        var substring1 = ""
        var substring2 = ""
        
        if(newlineRange.location != NSNotFound) {
            substring1 = buttonText.substring(to: newlineRange.location)
            substring2 = buttonText.substring(from: newlineRange.location)
        }
        
        let font1: UIFont = UIFont(name: "HelveticaNeue-Bold", size: 17.0)!
        ///label.font = UIFont.boldSystemFont(ofSize: 16.0)
        let attributes1 = [NSMutableAttributedString.Key.font: font1]
        let attrString1 = NSMutableAttributedString(string: substring1, attributes: attributes1)
        
        let font2: UIFont = UIFont(name: "Arial", size: 14.0)!
        let attributes2 = [NSMutableAttributedString.Key.font: font2]
        let attrString2 = NSMutableAttributedString(string: substring2, attributes: attributes2)
        
        //appending both attributed strings
        attrString1.append(attrString2)
        postButton.setAttributedTitle(attrString1, for: [])
    }
    
    private func addTextOnFollowersButton() {
        followersButton.titleLabel?.lineBreakMode = NSLineBreakMode.byWordWrapping
        let buttonText: NSString = "105 mil\nSeguidor"
        let newlineRange: NSRange = buttonText.range(of: "\n")
        
        //getting both substrings
        var substring1 = ""
        var substring2 = ""
        
        if(newlineRange.location != NSNotFound) {
            substring1 = buttonText.substring(to: newlineRange.location)
            substring2 = buttonText.substring(from: newlineRange.location)
        }
        
        let font1: UIFont = UIFont(name: "HelveticaNeue-Bold", size: 17.0)!
        let attributes1 = [NSMutableAttributedString.Key.font: font1]
        let attrString1 = NSMutableAttributedString(string: substring1, attributes: attributes1)
        
        let font2: UIFont = UIFont(name: "Helvetica", size: 14.0)!
        
        let attributes2 = [NSMutableAttributedString.Key.font: font2]
        let attrString2 = NSMutableAttributedString(string: substring2, attributes: attributes2)
        
        //appending both attributed strings
        attrString1.append(attrString2)
        followersButton.setAttributedTitle(attrString1, for: [])
    }
    
    private func addTextOnFollowingButton() {
        followingButton.titleLabel?.lineBreakMode = NSLineBreakMode.byWordWrapping
        let buttonText: NSString = "78\nSiguiendo"
        let newlineRange: NSRange = buttonText.range(of: "\n")
        
        //getting both substrings
        var substring1 = ""
        var substring2 = ""
        
        if(newlineRange.location != NSNotFound) {
            substring1 = buttonText.substring(to: newlineRange.location)
            substring2 = buttonText.substring(from: newlineRange.location)
        }
        
        let font1: UIFont = UIFont(name: "HelveticaNeue-Bold", size: 17.0)!
        let attributes1 = [NSMutableAttributedString.Key.font: font1]
        let attrString1 = NSMutableAttributedString(string: substring1, attributes: attributes1)
        
        let font2: UIFont = UIFont(name: "Arial", size: 14.0)!
        let attributes2 = [NSMutableAttributedString.Key.font: font2]
        let attrString2 = NSMutableAttributedString(string: substring2, attributes: attributes2)
        
        //appending both attributed strings
        attrString1.append(attrString2)
        followingButton.setAttributedTitle(attrString1, for: [])
    }
}