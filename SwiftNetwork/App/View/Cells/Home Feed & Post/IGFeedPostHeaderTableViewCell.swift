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
    
    private let usernameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.numberOfLines = 1
        label.font = .systemFont(ofSize: 18, weight: .medium)
        return label
    }()
    
    private let postTimeLabel: UILabel = {
        let label = UILabel()
        label.text = "44 min"
        label.font = .systemFont(ofSize: 12, weight: .regular)
        label.backgroundColor = .systemBackground
        return label
    }()
    
    private let moreButton: UIButton = {
       let button = UIButton()
        button.tintColor = .label
        button.tintColor = Constants.Color.blue
        button.setImage(UIImage(systemName:"ellipsis"), for: .normal)
        return button
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = .systemBackground
        contentView.addSubview(profilePhotoImageView)
        contentView.addSubview(usernameLabel)
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
        profilePhotoImageView.layer.cornerRadius = profilePhotoImageView.height/2 //size/2
        
        
        let labelHeight = contentView.height/3
        //usernameLabel.backgroundColor = .systemRed
        usernameLabel.frame = CGRect(
            x: profilePhotoImageView.right+10,
            y: 15,
            width: contentView.width-(size*2)-15,
            height: labelHeight)//contentView.height-4)
        
        postTimeLabel.frame = CGRect(
            x: profilePhotoImageView.right+10,
            y: usernameLabel.bottom,
            width: contentView.width-(size*2)-15,
            height: labelHeight)
        
        moreButton.frame = CGRect(x: contentView.width-size, y: 2, width: size, height: size)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        usernameLabel.text = nil
        profilePhotoImageView.image = nil
        
    }
    
    public func configure(with model: UserViewModel) {
        usernameLabel.text = model.username
        //profilePhotoImageView.image = UIImage(systemName: "person.circle")
        profilePhotoImageView.image = UIImage(named: "user5")
        //profilePhotoImageView.sd_setImage(with: model.profilePicture, completed: nil)
    }
    
    
    
    
    @objc private func didTapButton() {
        delegate?.didTapMoreButton()
    }
}
