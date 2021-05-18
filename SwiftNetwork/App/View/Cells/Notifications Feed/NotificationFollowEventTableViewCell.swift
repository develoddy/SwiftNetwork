//
//  NotificationFollowEventTableViewCell.swift
//  SwiftNetwork
//
//  Created by Eddy Donald Chinchay Lujan on 18/4/21.
//

import UIKit

protocol NotificationFollowEventTableViewCellDelegate: AnyObject {
    func didTapFollowUnFollowButton(model: UserNotification)
}

class NotificationFollowEventTableViewCell: UITableViewCell {

    static let identifier = "NotificationFollowEventTableViewCell"
    
    public var delgate: NotificationFollowEventTableViewCellDelegate?
    
    private var model: UserNotification?
    
    private let profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.masksToBounds = true
        imageView.backgroundColor = .red
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private let label: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.numberOfLines = 0
        label.text = "@kanyeWest followed you"
        return label
    }()
    
    private let followButton: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = 4
        button.layer.masksToBounds = true
        ///button.setTitleColor(.white, for: .normal)
        return button
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.clipsToBounds = true
        contentView.addSubview(profileImageView)
        contentView.addSubview(label)
        contentView.addSubview(followButton)
        followButton.addTarget(self, action: #selector(didTaoFollowButton), for: .touchUpInside)
        
        configureForFollow()
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
        
        let size: CGFloat = 100
        let buttonHeight: CGFloat = 40
        followButton.frame = CGRect(
            x: contentView.width-5-size,
            y: (contentView.height-buttonHeight)/2,
            width: size,
            height: buttonHeight)
        followButton.backgroundColor = Constants.Color.green
        
        label.frame = CGRect(
            x: profileImageView.right+5,
            y: 0,
            width: contentView.width-size-profileImageView.width-16,
            height: contentView.height)
    }
    
    public func configure(with model: UserNotification) {
        self.model = model
      
        switch model.type {
        case .like(_):
            return
        case .follow(let state):
            // Configure button
            switch state {
            case .following:
                configureForFollow()
                
            case .not_following:
                followButton.setTitle("Follow", for: .normal)
                followButton.setTitleColor(.white, for: .normal)
                followButton.layer.borderWidth = 1
                followButton.backgroundColor = .link
            }
            break
        }
        label.text = model.text
        profileImageView.sd_setImage(with: model.user.profilePicture, completed: nil)
    }
    
    private func configureForFollow() {
        followButton.setTitle("Unfollow", for: .normal)
        followButton.setTitleColor(.white, for: .normal)
        followButton.layer.borderWidth = 1
        followButton.layer.borderColor = UIColor.secondaryLabel.cgColor
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        followButton.setTitle(nil, for: .normal)
        followButton.backgroundColor = nil
        followButton.layer.borderWidth = 0
        label.text = nil
        profileImageView.image = nil
    }
    
    @objc private func didTaoFollowButton() {
        guard let model = model else {
            return
        }
        delgate?.didTapFollowUnFollowButton(model: model)
    }
}
