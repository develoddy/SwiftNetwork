//
//  NotificationLikeEventTableViewCell.swift
//  SwiftNetwork
//
//  Created by Eddy Donald Chinchay Lujan on 18/4/21.
//

import UIKit
import SDWebImage


protocol NotificationLikeEventTableViewCellDelegate: AnyObject {
    func didTapRelatedPostButton(model: UserNotification)
}

class NotificationLikeEventTableViewCell: UITableViewCell {

    static let identifier = "NotificationLikeEventTableViewCell"
    
    public var delgate: NotificationLikeEventTableViewCellDelegate?
    
    private var model: UserNotification?
    
    private let profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .systemPurple //.tertiarySystemBackground
        imageView.layer.masksToBounds = true
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private let label: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.numberOfLines = 0
        //label.text = "@joe liked your  photo"
        return label
    }()
    
    private let postButton: UIButton = {
        let button = UIButton()
        button.setBackgroundImage(UIImage(named: "test"), for: .normal)
        return button
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.clipsToBounds = true
        contentView.addSubview(profileImageView)
        contentView.addSubview(label)
        contentView.addSubview(postButton)
        postButton.addTarget(self, action: #selector(didTapPostButton), for: .touchUpInside)
        selectionStyle = .none
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        //photho, text, post button
        profileImageView.frame = CGRect(
            x: 3,
            y: 3,
            width: contentView.height-6,
            height: contentView.height-6)
        profileImageView.layer.cornerRadius = profileImageView.height/2
        
        let size = contentView.height-4
        label.frame = CGRect(
            x: profileImageView.right+5,
            y: 0,
            width: contentView.width-size-profileImageView.width-16,
            height: contentView.height)
        
        postButton.frame = CGRect(
            x: contentView.width-5-size,
            y: 2,
            width: size,
            height: size)
    }
    
    public func configure(with model: UserNotification) {
        
        //label.text = model.user.username
        //label.text = model.text
        
        /*
        let username = model.user.username
        let description = model.text
        
        
        let attributedString = joinText(username: username!, description: description)
        label.attributedText = attributedString
        
        self.model = model
        switch model.type {
        case .like(let post):
            let thumbnail = post.thumbnailImage
            guard !thumbnail.absoluteString.contains("google.com") else {
                return
            }
            postButton.sd_setBackgroundImage(with: thumbnail, for: .normal, completed: nil)
            break
            
        case .follow:
            break
        }
        
        
        profileImageView.sd_setImage(with: model.user.profilePicture, completed: nil)
        */
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
    
    override func prepareForReuse() {
        super.prepareForReuse()
        postButton.setTitle(nil, for: .normal)
        label.text = nil
        profileImageView.image = nil
    }
    
    
    @objc private func didTapPostButton() {
        guard let model = model else {
            return
        }
        
        delgate?.didTapRelatedPostButton(model: model)
    }
}

