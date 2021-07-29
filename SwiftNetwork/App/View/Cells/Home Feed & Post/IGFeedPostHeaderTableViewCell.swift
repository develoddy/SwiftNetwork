//
//  IGFeedPostHeaderTableViewCell.swift
//  SwiftNetwork
//
//  Created by Eddy Donald Chinchay Lujan on 14/4/21.
//

import UIKit
import SDWebImage

protocol IGFeedPostHeaderTableViewCellDelegate: AnyObject {
    func didTapMoreButton()
}

class IGFeedPostHeaderTableViewCell: UITableViewCell {
    
    static let identifier = "IGFeedPostHeaderTableViewCell"
    
    public var delegate: IGFeedPostHeaderTableViewCellDelegate?
    
    private let profilePhotoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.tintColor = .label
        imageView.layer.masksToBounds = true
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    /*
     private let likeButton: UIButton = {
         let button = UIButton()
         let config = UIImage.SymbolConfiguration(pointSize: 25, weight: .semibold)
         let image = UIImage(systemName: "heart", withConfiguration: config)
         button.setImage(image, for: .normal)
         button.tintColor = Constants.Color.black
         return button
     }()
     */
    
    private let usernameLabelButton: UIButton = {
        let button = UIButton()
        button.setTitleColor(Constants.Color.black, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 16, weight: .semibold)
        button.contentHorizontalAlignment = .left
        let config = UIImage.SymbolConfiguration(pointSize: 12, weight: .semibold)
        button.setImage(UIImage(systemName: "checkmark.seal.fill", withConfiguration: config)?.withRenderingMode(.alwaysOriginal).withTintColor(Constants.Color.purple), for: .normal)
        button.semanticContentAttribute = .forceRightToLeft
        return button
    }()
    
    private let postTimeLabel: UILabel = {
        let label = UILabel()
        label.text = "44 min"
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
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = .systemBackground
        contentView.addSubview(profilePhotoImageView)
        contentView.addSubview(usernameLabelButton)
        contentView.addSubview(postTimeLabel)
        contentView.addSubview(moreButton)
        moreButton.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let size = contentView.height-4
        profilePhotoImageView.frame = CGRect(
            x: 5,
            y: 15,
            width: contentView.height/1.5, ///size
            height: contentView.height/1.5) ///size
        profilePhotoImageView.layer.cornerRadius = profilePhotoImageView.height/2 
        
        
        let labelHeight = contentView.height/3
        usernameLabelButton.frame = CGRect(
            x: profilePhotoImageView.right+10,
            y: 15,
            width: contentView.width-(size*2)-15,
            height: labelHeight)//contentView.height-4)
        
        //postTimeLabel.backgroundColor = .yellow
        let postTimeLabelSize = postTimeLabel.sizeThatFits(frame.size)
        postTimeLabel.frame = CGRect(
            x: profilePhotoImageView.right+10,
            y: usernameLabelButton.bottom-2,
            width: contentView.width-(size*2)-15,
            height: postTimeLabelSize.height).integral
        
        moreButton.frame = CGRect(
            x: contentView.width-size,
            y: 2,
            width: size,
            height: size)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        usernameLabelButton.setTitle(nil, for: .normal)
        profilePhotoImageView.image = nil
        
    }
    
    public func configure(with model: UserViewModel) {
        //usernameLabel.text = model.username
        usernameLabelButton.setTitle(model.username, for: .normal)
        profilePhotoImageView.image = UIImage(systemName: "person.circle")
    }
    
    
    
    
    @objc private func didTapButton() {
        delegate?.didTapMoreButton()
    }
}
