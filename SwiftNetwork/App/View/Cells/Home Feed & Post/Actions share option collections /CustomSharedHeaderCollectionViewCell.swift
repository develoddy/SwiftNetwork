//
//  CustomSharedHeaderCollectionViewCell.swift
//  SwiftNetwork
//
//  Created by Eddy Donald Chinchay Lujan on 19/7/21.
//

import UIKit


///Header
class CustomSharedHeaderCollectionViewCell:  UICollectionReusableView {
    
    static let identifier = "CustomSharedHeaderCollectionViewCell"
    
    private let titleLabel : UILabel = {
        let label = UILabel()
        label.text = "Share"
        label.font = .systemFont(ofSize: 20, weight: .semibold)
        label.textAlignment = .center
        return label
    }()
    
    lazy var imageProfile: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "person.circle")
        imageView.layer.masksToBounds = true
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.tintColor = Constants.Color.black
        //imageView.backgroundColor = .red
        return imageView
    }()
    
    lazy var username: UILabel = {
        let label = UILabel()
        label.text = "Eddy Lujan"
        label.font = .systemFont(ofSize: 20, weight: .semibold)
        //label.backgroundColor = .systemPink
        return label
    }()
    
    private let friendsLabel: UILabel = {
        let label = UILabel()
        //label.backgroundColor = .systemBlue
        label.text = "Friends"
        label.font = .systemFont(ofSize: 12, weight: .regular)
        label.textColor = Constants.Color.dark
        return label
    }()
    
    private let moreButton: UIButton = {
       let button = UIButton()
        button.tintColor = .label
        button.tintColor = Constants.Color.black
        button.setImage(UIImage(systemName:"ellipsis"), for: .normal)
        return button
    }()
    
    private let postTextField: UITextField = {
        let textField = UITextField()
        textField.backgroundColor = .systemBackground
        textField.attributedPlaceholder = NSAttributedString(string: "Eddy, dile al mundo lo que piensas", attributes: [NSAttributedString.Key.foregroundColor: Constants.Color.dark])
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: textField.frame.height))
        textField.leftView = paddingView
        textField.leftViewMode = UITextField.ViewMode.always
        return textField
    }()
    
    private let postButton: UIButton = {
       let button = UIButton()
        button.tintColor = .white
        button.setTitle("Share", for: .normal)
        button.layer.masksToBounds = true
        button.clipsToBounds = true
        button.backgroundColor = Constants.Color.purple
        return button
    }()
    
    private let lineSeparatorLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .systemGray4
        return label
    }()
    
    
    //MARK: Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    func setupView() {
        addSubview(titleLabel)
        addSubview(imageProfile)
        addSubview(username)
        addSubview(friendsLabel)
        addSubview(moreButton)
        addSubview(postTextField)
        addSubview(postButton)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let border = UIView(frame: CGRect(x: 0, y: 50, width: bounds.width, height: 1))
        border.backgroundColor = .systemGray4
        titleLabel.addSubview(border)
        
        titleLabel.frame = CGRect(
            x: 0,
            y: 0,
            width: width,
            height: 50)
        
        imageProfile.frame = CGRect(
            x: 10,
            y: titleLabel.bottom+10,
            width: 40,
            height: 40)
        imageProfile.layer.cornerRadius = imageProfile.height/2
        
        let size = (height/3)
        let usernameSize = username.sizeThatFits(frame.size)
        username.frame = CGRect(
            x: imageProfile.right+10,
            y: titleLabel.bottom+15,
            width: width-(size*2)-15,
            height: usernameSize.height).integral
        
        let friendsSize = friendsLabel.sizeThatFits(frame.size)
        friendsLabel.frame = CGRect(
            x: imageProfile.right+10,
            y: username.bottom-2,
            width: width-(size*2)-15,
            height: friendsSize.height).integral
        
        moreButton.frame = CGRect(
            x: width-size,
            y: titleLabel.bottom,
            width: 50,
            height: 50)
        moreButton.layer.cornerRadius = moreButton.height/2
        
        postTextField.backgroundColor = .systemBackground
        postTextField.frame = CGRect(
            x: 10,
            y: friendsLabel.bottom+5,
            width: width-20,
            height: 50)
        
        postButton.frame = CGRect(
            x: 10,
            y: postTextField.bottom+10,
            width: width-20,
            height: 50)
        postButton.layer.cornerRadius = postButton.height/2
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
