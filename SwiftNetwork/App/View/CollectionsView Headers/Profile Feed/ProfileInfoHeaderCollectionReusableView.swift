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
        //let imageView = UIImageView(image: UIImage(named: "user5"))
        let imageView = UIImageView(image: UIImage(systemName: "person.circle.fill"))
        imageView.tintColor = .black
        imageView.layer.masksToBounds = true
        return imageView
    }()

    ///Buttons
    private let postButton : UIButton = {
        let button = UIButton()
        button.titleLabel?.font = .systemFont(ofSize: 14, weight: .thin)
        button.titleLabel?.textAlignment = .center
        button.backgroundColor = .systemBackground
        button.setTitleColor(.label, for: .normal)
        return button
    }()
    
    
    private let followersButton : UIButton = {
        let button = UIButton()
        button.titleLabel?.font = .systemFont(ofSize: 14, weight: .thin)
        button.titleLabel?.textAlignment = .center
        button.backgroundColor = .systemBackground
        button.setTitleColor(.label, for: .normal)
        return button
    }()
    
    private let followingButton : UIButton = {
        let button = UIButton()
        button.titleLabel?.font = .systemFont(ofSize: 14, weight: .thin)
        button.titleLabel?.textAlignment = .center
        button.backgroundColor = .systemBackground
        button.setTitleColor(.label, for: .normal)
        return button
    }()
    
    private let editProfileButton : UIButton = {
        let button = UIButton()
        button.setTitle("Edit Your Profile", for: .normal)
        button.backgroundColor = Constants.ProfileInfoHeaderCollectionReusableViewColor.colorPink
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 16, weight: .bold)
        button.layer.cornerRadius = 26
        return button
    }()
    
    private let nameLabel : UILabel = {
        let label = UILabel()
        label.text = "Eddy Lujan"
        label.numberOfLines = 1
        label.font = .systemFont(ofSize: 22, weight: .bold)
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
        
        addTextOnPostButton()
        addTextOnFollowersButton()
        addTextOnFollowingButton()
        backgroundColor = .systemBackground
        clipsToBounds = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
   
    private func addSubviews() {
        addSubview(profilePhotoImageView)
        
        addSubview(postButton)
        addSubview(followersButton)
        addSubview(followingButton)
        
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
        
        ///Buttons
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
            y: 15 + buttonHeight,
            width: countButtonWidth*3,
            height: buttonHeight
        ).integral
        
        nameLabel.frame = CGRect(
            x: 10,
            y: 5+profilePhotoImageView.bottom,
            width: width-10,
            height: 50
        ).integral
        
        let bioLabelSize = bioLabel.sizeThatFits(frame.size)
        bioLabel.frame = CGRect(
            x: 10,
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


//MARK: Add text on buttons
extension ProfileInfoHeaderCollectionReusableView {
    private func addTextOnPostButton() {
        postButton.titleLabel?.lineBreakMode = NSLineBreakMode.byWordWrapping
        let buttonText: NSString = "10\nPost"
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
        let buttonText: NSString = "105 mil\nFollower"
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
        let buttonText: NSString = "78\nFollowing"
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
