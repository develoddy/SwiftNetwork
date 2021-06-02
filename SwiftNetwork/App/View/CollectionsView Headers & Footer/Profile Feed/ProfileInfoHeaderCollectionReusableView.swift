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
    
    static let identifier = "ProfileInfoHeaderCollectionReusableView"
    
    public var delegate: ProfileInfoHeaderCollectionReusableViewDelegate?
    
    private let uploadImageButton : UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: Constants.Icon.photo), for: .normal)
        button.backgroundColor = Constants.Color.blueLight
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 16, weight: .bold)
        button.layer.cornerRadius = 26
        return button
    }()
    
    private let downloadImageButton : UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: Constants.Icon.more), for: .normal)
        button.backgroundColor = Constants.Color.blueLight
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 16, weight: .bold)
        button.layer.cornerRadius = 26
        return button
    }()
    
    private let portadaImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "img6")
        imageView.backgroundColor = .blue
        return imageView
    }()

    
    private let profilePhotoImageView : UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "eddy"))
        imageView.tintColor = .black
        imageView.layer.masksToBounds = true
        imageView.layer.borderWidth = 2.5
        imageView.layer.borderColor = UIColor.white.cgColor
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
        button.setImage(UIImage(systemName: "square.and.pencil"), for: .normal)
        button.tintColor = .white
        button.backgroundColor = Constants.Color.purple
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 16, weight: .bold)
        button.layer.cornerRadius = 26
        return button
    }()
    
    private let nameLabel : UILabel = {
        let label = UILabel()
        //label.text = "Eddy Lujan"
        label.numberOfLines = 1
        label.font = .systemFont(ofSize: 22, weight: .bold)
        return label
    }()
    
    private let usernameLabel : UIButton = { //checkmark.seal.fill
        let button = UIButton()
        //button.setTitle("@eddylujann", for: .normal)
        button.setTitleColor(Constants.Color.lightDark, for: .normal)
        button.contentHorizontalAlignment = .left
        button.setImage(UIImage(systemName: "checkmark.seal.fill"), for: .normal)
        button.semanticContentAttribute = .forceRightToLeft
        button.titleLabel?.font = .systemFont(ofSize: 14, weight: .semibold)
        return button
    }()
    
    ///Ubication
    private let ubicationImageView : UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "location.circle.fill")
        //imageView.tintColor = .black
        imageView.layer.masksToBounds = true
        imageView.tintColor = .systemPink
        //imageView.backgroundColor = .red
        return imageView
    }()
    
    private let ubicationLabel : UILabel = {
        let label = UILabel()
        label.text = "Comunidad de Madrid, España"
        label.textColor = Constants.Color.black
        label.font = .systemFont(ofSize: 14, weight: .regular)
        label.numberOfLines = 0 // line wrap
        return label
    }()
    
    ///Date
    private let dateOfBirthImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "moon.circle.fill")
        imageView.tintColor = .systemBlue
        imageView.layer.masksToBounds = true
        return imageView
    }()
    private let dateOfBirthTextLabel : UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .regular)
        label.text = "Fecha de nacimiento 20 de diciembre de 1990"
        label.textColor = Constants.Color.black
        label.numberOfLines = 0
        return label
    }()
    
    ///Joined
    private let joinedImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "calendar.circle.fill")
        imageView.tintColor = .systemGreen
        imageView.layer.masksToBounds = true
        return imageView
    }()
    private let joinedLabelText : UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .regular)
        label.text = "Te uniste en Mayo de 2021"
        label.textColor = Constants.Color.black
        label.numberOfLines = 0
        return label
    }()
    
    ///Publications
    let labelTitlePublication: UILabel = {
        let label = UILabel()
        label.backgroundColor = .systemBackground
        label.font = .systemFont(ofSize: 22, weight: .bold)
        label.text = "Publication"
        return label
    }()
    
    private let moreButton: UIButton = {
       let button = UIButton()
        button.setTitleColor(Constants.Color.black, for: .normal)
        button.setImage(UIImage(systemName: Constants.Icon.filter), for: .normal)
        button.tintColor = Constants.Color.black
        button.setTitle("Filter", for: .normal)
        //button.setImage(UIImage(systemName:"ellipsis"), for: .normal)
        return button
    }()
    
    private let imageViewProfile: UIImageView = {
        //let imageView = UIImageView(image: UIImage(systemName: "person.circle"))
        let imageView = UIImageView(image: UIImage(named: "eddy"))
        imageView.contentMode = .scaleAspectFit
        imageView.layer.masksToBounds = true
        return imageView
    }()
    
    private let writePostButton: UIButton = {
        let button = UIButton()
        button.setTitle("¿Eddy, en que piensas?", for: .normal)
        button.contentHorizontalAlignment = .left
        button.setTitleColor(Constants.Color.lightDark, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 18, weight: .regular)
        //button.backgroundColor = .systemGreen
        return button
    }()
    
    ///LineAfterTextField
    private let LineAfterTextField: UILabel = {
        let label = UILabel()
        label.backgroundColor = Constants.Color.lightDark
        return label
    }()
    
    private let imageButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "photo.on.rectangle.angled"), for: .normal)
        button.tintColor = .systemGreen
        button.setTitle("Photo", for: .normal)
        button.setTitleColor(Constants.Color.black, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 14, weight: .semibold)
        button.layer.masksToBounds = true
        button.backgroundColor = Constants.Color.whiteLight
        return button
    }()
    
    private let audioButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "waveform"), for: .normal)
        button.setTitle("Audio", for: .normal)
        button.tintColor = .systemPurple
        button.setTitleColor(Constants.Color.black, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 14, weight: .semibold)
        button.layer.masksToBounds = true
        button.backgroundColor = Constants.Color.whiteLight
        return button
    }()
    
    private let ubicationButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "location.fill"), for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 14, weight: .semibold)
        button.setTitle("Ubication", for: .normal)
        button.tintColor = .systemRed
        button.setTitleColor(Constants.Color.black, for: .normal)
        button.layer.masksToBounds = true
        button.backgroundColor = Constants.Color.whiteLight
        return button
    }()
    
    private let administratorPostLabel : UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "gearshape.fill"), for: .normal)
        button.tintColor = .white
        button.backgroundColor = Constants.Color.lightDark
        button.titleLabel?.font = .systemFont(ofSize: 14, weight: .bold)
        button.setTitle("Manage posts", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.textAlignment  = .center
        button.layer.masksToBounds = true
        return button
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
        addSubview(portadaImageView)
        addSubview(profilePhotoImageView)
        
        addSubview(postButton)
        addSubview(followersButton)
        addSubview(followingButton)
        
        addSubview(editProfileButton)
        addSubview(nameLabel)
        addSubview(usernameLabel)
        
        addSubview(ubicationImageView)
        addSubview(ubicationLabel)
        
        addSubview(dateOfBirthImageView)
        addSubview(dateOfBirthTextLabel)
        
        addSubview(joinedImageView)
        addSubview(joinedLabelText)
        
        addSubview(labelTitlePublication)
        addSubview(moreButton)
        
        addSubview(imageViewProfile)
        addSubview(writePostButton)
        
        addSubview(imageButton)
        addSubview(audioButton)
        addSubview(ubicationButton)
        
        //addSubview(administratorPostLabel)
    }
    
    private func addButtonActions() {
        followersButton.addTarget(self, action: #selector(didTapFollowerButton), for: .touchUpInside)
        followingButton.addTarget(self, action: #selector(didTapFollowingButton), for: .touchUpInside)
        postButton.addTarget(self, action: #selector(didTapPostsButton), for: .touchUpInside)
        editProfileButton.addTarget(self, action: #selector(didTapEditProfileButton), for: .touchUpInside)
        writePostButton.addTarget(self, action: #selector(didTapWritePostButton), for: .touchUpInside)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        portadaImageView.frame = CGRect(
            x: 0,
            y: 0,
            width: width,
            height: 150)
        
        portadaImageView.addSubview(uploadImageButton)
        portadaImageView.addSubview(downloadImageButton)
        
        uploadImageButton.frame = CGRect(
            x: (width/1.3)-10,
            y: (portadaImageView.height/1.5),
            width: 40,
            height: 40).integral
        uploadImageButton.layer.cornerRadius = uploadImageButton.height/2
        
        downloadImageButton.frame = CGRect(
            x: uploadImageButton.right+15,
            y: (portadaImageView.height/1.5),
            width: 40,
            height: 40).integral
        downloadImageButton.layer.cornerRadius = downloadImageButton.height/2

        let botomButtons = portadaImageView.bottom+10
        let profilePhotoSize = width/4
        profilePhotoImageView.frame = CGRect(
            x: 5,
            y: portadaImageView.bottom-40,//5,
            width: profilePhotoSize,
            height: profilePhotoSize
        ).integral
        profilePhotoImageView.layer.cornerRadius = profilePhotoSize/2.0
        
        let buttonHeight = profilePhotoSize/2
        let countButtonWidth = (width-10-profilePhotoSize)/3
       
        ///Buttons
        postButton.frame = CGRect(
            x: profilePhotoImageView.right,
            y: botomButtons,//5,
            width: countButtonWidth,
            height: buttonHeight
        ).integral
        
        followersButton.frame = CGRect(
            x: postButton.right,
            y: botomButtons,
            width: countButtonWidth,
            height: buttonHeight
        ).integral
        
        followingButton.frame = CGRect(
            x: followersButton.right,
            y: botomButtons,
            width: countButtonWidth,
            height: buttonHeight
        ).integral
        
        editProfileButton.frame = CGRect(
            x: profilePhotoImageView.right+30,
            y: followingButton.bottom + 10, //15 + buttonHeight
            width: countButtonWidth*3-35,
            height: buttonHeight
        ).integral
        
        let nameLabelSize = nameLabel.sizeThatFits(frame.size)
        nameLabel.frame = CGRect(
            x: 10,
            y: 5+profilePhotoImageView.bottom,
            width: nameLabelSize.width, //width-editProfileButton.width-20,
            height: nameLabelSize.height).integral
        
        let usernameLabelSize = usernameLabel.sizeThatFits(frame.size)
        usernameLabel.frame = CGRect(
            x: 10,
            y: nameLabel.bottom+2,
            width: usernameLabelSize.width,
            height: usernameLabelSize.height).integral
        
        
        //MARK: Publicar Post
        ////Ubications
        let sizeRound = width/14
        ubicationImageView.frame = CGRect(
            x: 10,
            y: usernameLabel.bottom+20,
            width: sizeRound,
            height:sizeRound)
        ubicationImageView.layer.cornerRadius = sizeRound/2
        
        let ubicationLabelSize = ubicationLabel.sizeThatFits(frame.size)
        ubicationLabel.frame = CGRect(
            x: ubicationImageView.right+5,
            y: usernameLabel.bottom+25,
            width: width-10,
            height: ubicationLabelSize.height).integral
        
        ///Date
        dateOfBirthImageView.frame = CGRect(
            x: 10,
            y: ubicationImageView.bottom+5,
            width: sizeRound,
            height:sizeRound)
        dateOfBirthImageView.layer.cornerRadius = sizeRound/2
        
        let dateOfBirthTextLabelSize = dateOfBirthTextLabel.sizeThatFits(frame.size)
        dateOfBirthTextLabel.frame = CGRect(
            x: dateOfBirthImageView.right+5,
            y: ubicationLabel.bottom+17,
            width: width-10,
            height: dateOfBirthTextLabelSize.height).integral
        
        ///joinedLabel
        joinedImageView.frame = CGRect(
            x: 10,
            y: dateOfBirthImageView.bottom+5,
            width: sizeRound,
            height:sizeRound)
        joinedImageView.layer.cornerRadius = sizeRound/2
        
        let joinedLabelTextSize = joinedLabelText.sizeThatFits(frame.size)
        joinedLabelText.frame = CGRect(
            x: joinedImageView.right+5,
            y: dateOfBirthTextLabel.bottom+20,
            width: width-10,
            height: joinedLabelTextSize.height).integral
        
        //MARK: Publicar Post
        let labelTitlePublicationSize = labelTitlePublication.sizeThatFits(frame.size)
        labelTitlePublication.frame = CGRect(
            x: 10,
            y: joinedImageView.bottom+25,
            width: 150,
            height: labelTitlePublicationSize.height).integral
        
        let buttonWidth = width > 100 ? 70.0 : width/2
        let moreButtonSize = labelTitlePublication.sizeThatFits(frame.size)
        moreButton.frame = CGRect(
            x: width-5-buttonWidth,
            y: joinedImageView.bottom+25,
            width: buttonWidth,
            height: moreButtonSize.height).integral

        imageViewProfile.frame = CGRect(
            x: 10,
            y: labelTitlePublication.bottom+10,
            width: 50,
            height: 50)
        imageViewProfile.layer.cornerRadius = imageViewProfile.height/2
        
        writePostButton.frame = CGRect(
            x: 20+imageViewProfile.width,
            y: labelTitlePublication.bottom+5,
            width: width-35-imageViewProfile.width,
            height: 50)
    
        let heightButtons: CGFloat =  40
        let withButtons = (width/3)-5
        imageButton.frame = CGRect(
            x: 10,
            y: writePostButton.bottom+15,
            width: withButtons,
            height: heightButtons)
        imageButton.layer.cornerRadius = imageButton.height / 2
        
        audioButton.frame = CGRect(
            x: imageButton.right+5,
            y: writePostButton.bottom+15,
            width: withButtons,
            height: heightButtons)
        audioButton.layer.cornerRadius = audioButton.height / 2
        
        ubicationButton.frame = CGRect(
            x: audioButton.right+5,
            y: writePostButton.bottom+15,
            width: withButtons-10,
            height: heightButtons)
        ubicationButton.layer.cornerRadius = ubicationButton.height / 2
        
        administratorPostLabel.frame = CGRect(
            x: 10,
            y: ubicationButton.bottom+15,
            width: width-20,
            height: 40)
        administratorPostLabel.layer.cornerRadius = administratorPostLabel.height/2
    }
    
    override func prepareForReuse() {
        nameLabel.text = nil
        usernameLabel.setTitle(nil, for: .normal)
    }
    
    
    public func configure(model: UserPostViewModel) { //UserViewModel
        nameLabel.text = model.owner.name
        usernameLabel.setTitle(model.owner.username, for: .normal)
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
