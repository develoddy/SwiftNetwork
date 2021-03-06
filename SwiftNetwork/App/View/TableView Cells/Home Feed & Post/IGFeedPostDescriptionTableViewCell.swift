//
//  IGFeedPostDescriptionTableViewCell.swift
//  SwiftNetwork
//
//  Created by Eddy Donald Chinchay Lujan on 27/4/21.
//

import UIKit

protocol IGFeedPostDescriptionTableViewCellDelegate: AnyObject {
    func didTapLikeButton()
    func didTapCommentButton(model: Userpost)
    func didTapSendButton()
}

class IGFeedPostDescriptionTableViewCell: UITableViewCell {
    
    static let identifier = "IGFeedPostDescriptionTableViewCell"
    
    private var model: Userpost?
    
    public var delegate: IGFeedPostDescriptionTableViewCellDelegate?
    
    private let profileImagesLikes: UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.layer.masksToBounds = true
        imageView.backgroundColor = .systemPink
        return imageView
    }()
    
    ///private let totalLikeLabel: UILabel = {
    private let likeCount: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = Constants.fontSize.regular
        return label
    }()
    
    private let usernameLabel: UILabel = {
        let label = UILabel()
        label.font = Constants.fontSize.semibold
        return label
    }()
   
    private let descriptionLabel: UILabel = {
        let label = UILabel.init()
        label.textAlignment = .left
        label.numberOfLines = 0
        return label
    }()
    
    private let commentCount: UIButton = {
        let button = UIButton()
        button.titleLabel?.font = .systemFont(ofSize: 14, weight: .regular)
        button.setTitleColor(UIColor.systemGray, for: .normal)
        button.contentHorizontalAlignment = .left
        return button
    }()
    
    private let labelTextComment: UILabel = {
        let label = UILabel()
        label.backgroundColor = .red
        return label
    }()
    
    private let viewImage: UIView = {
        let view = UIView()
        return view
    }()
    
    ///Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(profileImagesLikes)
        contentView.addSubview(likeCount)
        contentView.addSubview(descriptionLabel)
        contentView.addSubview(commentCount)
        contentView.addSubview(labelTextComment)
        contentView.addSubview(viewImage)
        commentCount.addTarget(self, action: #selector(didTapCommetnButton), for: .touchUpInside)
    }
    
    @objc private func didTapCommetnButton() {
        guard let model = model else {
            return
        }
        delegate?.didTapCommentButton(model: model)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let imageSize = 60
        viewImage.frame = CGRect(
            x: 15,
            y: 0,
            width: imageSize,
            height: 30).integral
    
        let totalLikeLabellSize = likeCount.sizeThatFits(frame.size)
        likeCount.frame = CGRect(
            x: viewImage.right+5,
            y: 2,
            width: totalLikeLabellSize.width,
            height: 25)
        
        descriptionLabel.frame = CGRect(
            x: 15,
            y: likeCount.bottom,
            width: contentView.width-20,
            height: 40)
        
        commentCount.frame = CGRect(
            x: 15,
            y: descriptionLabel.bottom+5,
            width: contentView.width-20,
            height: 10)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    // Setup userpost values.
    public func setCellWithValuesOf(countLikes: Int, countComments: Int, username: String?, content: String?, image: String?) {
        updateUI(countLikes: countLikes         ,
                 countComments: countComments   ,
                 username: username             ,
                 caption: content               ,
                 image: image                   )
    }
    
    //Update the UI Views.
    private func updateUI(countLikes: Int, countComments: Int, username: String?, caption: String?, image: String? ) {
        likeCount.text = "\(countLikes) Me gusta"
        commentCount.setTitle("Ver los \(countComments) comentarios", for: .normal)
        guard let username = username, let caption = caption else { return }
        let authorName = joinTextCaption(username: username, description: caption)
        descriptionLabel.attributedText = authorName
        imagesLikes(imageName: image)
    }
    
    //Images likes.
    func imagesLikes(imageName: String?) {
        let buttonSize = contentView.height
        for x in 0..<3 {
            let image = UIImageView()
            image.backgroundColor = .systemPink
            image.tintColor = Constants.Color.black
            image.layer.borderWidth = 2
            image.layer.borderColor = UIColor.white.cgColor
            image.clipsToBounds = true
            image.layer.masksToBounds = true
            image.contentMode = .scaleAspectFill
            image.sd_setImage(with: URL(string: imageName ?? ""), completed: nil)
            viewImage.addSubview(image)
            
            image.frame = CGRect(
                x: (15*CGFloat(x)),
                y: 0,
                width: buttonSize/3,
                height: buttonSize/3)
            image.layer.cornerRadius = image.height/2
        }
    }
    
    //Join text like.
    private func joinTextLike(text:String, description:String) -> NSMutableAttributedString {
        let boldText  = text + " "
        let attrs = [NSAttributedString.Key.font : Constants.fontSize.regular ]
        let attributedString = NSMutableAttributedString(string:boldText, attributes:attrs)
        
        let normalText = description
        let attrs2 = [NSAttributedString.Key.font : Constants.fontSize.semibold]
        let normalString = NSMutableAttributedString(string:normalText, attributes:attrs2)
        attributedString.append(normalString)
        return attributedString
    }
    
    //Join text caption.
    private func joinTextCaption(username:String, description:String) -> NSMutableAttributedString {
        let boldText  = username + " "
        let attrs = [NSAttributedString.Key.font : Constants.fontSize.semibold ]
        let attributedString = NSMutableAttributedString(string:boldText, attributes:attrs)
        
        let normalText = description
        let attrs2 = [NSAttributedString.Key.font : Constants.fontSize.regular ]
        let normalString = NSMutableAttributedString(string:normalText, attributes:attrs2)
        attributedString.append(normalString)
        return attributedString
    }
}
