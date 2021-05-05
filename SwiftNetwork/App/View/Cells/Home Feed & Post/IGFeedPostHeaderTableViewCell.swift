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
    
    private let moreButton: UIButton = {
       let button = UIButton()
        button.tintColor = .label
        button.tintColor = .systemPurple
        button.setImage(UIImage(systemName:"ellipsis"), for: .normal)
        return button
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        //contentView.backgroundColor = .purple
        contentView.addSubview(profilePhotoImageView)
        contentView.addSubview(usernameLabel)
        contentView.addSubview(moreButton)
        moreButton.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc private func didTapButton() {
        delegate?.didTapMoreButton()
    }
    
    public func configure(with model: User) {
        usernameLabel.text = model.username
        //profilePhotoImageView.image = UIImage(systemName: "person.circle")
        profilePhotoImageView.image = UIImage(named: "user5")
        //profilePhotoImageView.sd_setImage(with: model.profilePicture, completed: nil)
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
        
        usernameLabel.frame = CGRect(
            x: profilePhotoImageView.right+10,
            y: 2,
            width: contentView.width-(size*2)-15,
            height: contentView.height-4)
        
        moreButton.frame = CGRect(x: contentView.width-size, y: 2, width: size, height: size)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        usernameLabel.text = nil
        profilePhotoImageView.image = nil
        
    }
}
