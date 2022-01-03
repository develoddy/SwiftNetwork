//
//  IGFeedPostHeaderTableViewCell.swift
//  SwiftNetwork
//
//  Created by Eddy Donald Chinchay Lujan on 14/4/21.
//

import UIKit
import SDWebImage

protocol IGFeedPostHeaderTableViewCellDelegate: AnyObject {
    func didTapMoreButton(post: Userpost)
}

class IGFeedPostHeaderTableViewCell: UITableViewCell {
    
    static let identifier = "IGFeedPostHeaderTableViewCell"
    
    public var delegate: IGFeedPostHeaderTableViewCellDelegate?
    
    private var model: CD0011_posts?
    
    private let profilePhotoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.tintColor = .black
        imageView.layer.masksToBounds = true
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
   
    /*private let usernameLabelButton: UIButton = {
        let button = UIButton()
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 16, weight: .semibold)
        button.contentHorizontalAlignment = .left
        let config = UIImage.SymbolConfiguration(pointSize: 12, weight: .semibold)
        button.setImage(UIImage(systemName: "checkmark.seal.fill", withConfiguration: config)?.withRenderingMode(.alwaysOriginal).withTintColor(.white), for: .normal)
        button.semanticContentAttribute = .forceRightToLeft
        return button
    }()*/
    
    private let usernameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = .systemFont(ofSize: 14, weight: .semibold)
        return label
    }()
    
    private let postTimeLabel: UILabel = {
        let label = UILabel()
        label.text = "44 min"
        label.font = .systemFont(ofSize: 12, weight: .regular)
        label.textColor = .black
        return label
    }()
    
    private let moreButton: UIButton = {
       let button = UIButton()
        button.tintColor = .white
        button.tintColor = Constants.Color.black
        button.setImage(UIImage(systemName:"ellipsis"), for: .normal)
        return button
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
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
        profilePhotoImageView.frame = CGRect(x      : 5                         ,
                                             y      : 15                        ,
                                             width  : contentView.height/1.5    ,
                                             height : contentView.height/1.5    ).integral
        profilePhotoImageView.layer.cornerRadius = profilePhotoImageView.height/2
        
        let labelHeight = contentView.height/3
        usernameLabel.frame = CGRect(x      : profilePhotoImageView.right+10    ,
                                     y      : 15                                ,
                                     width  : contentView.width-(size*2)-15     ,
                                     height : labelHeight                       ).integral
        
        let postTimeLabelSize = postTimeLabel.sizeThatFits(frame.size)
        postTimeLabel.frame = CGRect(x      : profilePhotoImageView.right+10    ,
                                     y      : usernameLabel.bottom-2            ,
                                     width  : contentView.width-(size*2)-15     ,
                                     height : postTimeLabelSize.height          ).integral
        
        moreButton.frame = CGRect(x     : contentView.width-size    ,
                                  y     : 2                         ,
                                  width : size                      ,
                                  height: size                      ).integral
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        usernameLabel.text          = nil
        profilePhotoImageView.image = nil
    }
    
    //MARK: Setup Userpost values.
    public func setCellWithValuesOf(with model: CD0011_posts) {
        updateUI(username   : model.userAuthor?.cd01_username                   ,
                 imageHeader: model.userAuthor?.cd01_profile?.cd08_image_header )
    }
    
    //MARK: Update the UI Views.
    private func updateUI(username: String?, imageHeader: String?) {
        guard let username      = username,
              let imageHeader   = imageHeader else {
            return
        }
        self.usernameLabel.text = username
        profilePhotoImageView.sd_setImage(with: URL(string: imageHeader), completed: nil)
    }
    
    @objc private func didTapButton() {
        //guard let post = self.model else {
          //  return
        //}
        //delegate?.didTapMoreButton(post: post)
    }
}
