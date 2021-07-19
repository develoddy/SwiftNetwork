//
//  CustomSharedCollectionViewCell.swift
//  SwiftNetwork
//
//  Created by Eddy Donald Chinchay Lujan on 9/7/21.
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
        /**textField.placeholder = "Eddy, dile al mundo lo que piensas"
        var imageView = UIImageView()
        var image = UIImage(systemName: "pencil")
        imageView.tintColor = .systemGray2
        imageView.image = image
        textField.rightView = imageView
        textField.rightViewMode = .always*/
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
        //addSubview(lineSeparatorLabel)
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
        
        /*lineSeparatorLabel.frame = CGRect(
            x: 0,
            y: postButton.bottom+10,
            width: width,
            height: 1)*/
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


///Boddy
class CustomSharedCollectionViewCell: UICollectionViewCell  {
    
    static let identifier = "CustomSharedCollectionViewCell"
    
    lazy var settingImage: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.masksToBounds = true
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.tintColor = Constants.Color.black
        return imageView
    }()
    
    let label: UILabel = {
        let label = UILabel()
        //label.text = "Setting"
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        backgroundColor = .systemBackground
    }
    
    func setupView() {
        addSubview(settingImage)
        addSubview(label)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let size = contentView.height-2
        settingImage.frame = CGRect(
            x: 10,
            y: 10,
            width: contentView.height/2,
            height: contentView.height/2)
        
        settingImage.layer.cornerRadius = settingImage.height/2
        
        let labelHeight = contentView.height/2
        label.frame = CGRect(
            x: settingImage.right+15,
            y: 10,
            width: contentView.width-(size*2)-10,
            height: labelHeight)
    }
    
    public func configure(model: Setting) {
        
        ///let config = UIImage.SymbolConfiguration(pointSize: 25, weight: .semibold)
        ///let image = UIImage(systemName: model.imageName, withConfiguration: config)
        ///settingImage.image = image
        
        settingImage.image = UIImage(systemName: model.imageName)
        label.text = model.name
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


protocol CustomSharedFooterCollectionViewCellDelegate: AnyObject {
    func didTapCancelButton()
}
///Footer
class CustomSharedFooterCollectionViewCell:  UICollectionReusableView {
    
    static let identifier = "CustomSharedFooterCollectionViewCell"
    
    public var delegate: CustomSharedFooterCollectionViewCellDelegate?
    
    private let cancelButton: UIButton = {
        let button = UIButton()
        button.setTitleColor(UIColor.black, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 20, weight: .bold)
        button.setTitle("Cancel", for: .normal)
        button.layer.masksToBounds = true
        button.clipsToBounds = true
        button.backgroundColor = Constants.Color.darkLigth
        button.addTarget(self, action: #selector(didTapCancelButton), for: .touchUpInside)
        
        //var border = UIView(frame: CGRectMake(0,0,self.view.bounds.width,1))
        
        
        return button
    }()
    
    //MARK: Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    @objc private func didTapCancelButton() {
        delegate?.didTapCancelButton()
    }

    func setupView() {
        backgroundColor = .systemBackground
        addSubview(cancelButton)
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        cancelButton.frame = CGRect(
            x: 10,
            y: 40,
            width: frame.width-20,
            height: 50)
        cancelButton.layer.cornerRadius = cancelButton.height/2
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
