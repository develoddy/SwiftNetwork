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
    
    private let totalLikeLabel: UILabel = {
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
    
    private let seeMoreCommentsButton: UIButton = {
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
        contentView.addSubview(totalLikeLabel)
        contentView.addSubview(descriptionLabel)
        contentView.addSubview(seeMoreCommentsButton)
        contentView.addSubview(labelTextComment)
        contentView.addSubview(viewImage)
        seeMoreCommentsButton.addTarget(self, action: #selector(didTapCommetnButton), for: .touchUpInside)
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
        
        let buttonSize = contentView.height
        for x in 0..<3 {
            let image = UIImageView()
            image.image = UIImage(named: "eddy")
            image.backgroundColor = .systemPink
            image.tintColor = Constants.Color.black
            image.layer.borderWidth = 2
            image.layer.borderColor = UIColor.white.cgColor
            image.clipsToBounds = true
            image.layer.masksToBounds = true
            image.contentMode = .scaleAspectFill
            viewImage.addSubview(image)
            
            image.frame = CGRect(
                x: (15*CGFloat(x)),
                y: 0,
                width: buttonSize/3,
                height: buttonSize/3)
            image.layer.cornerRadius = image.height/2
        }
    
        let totalLikeLabellSize = totalLikeLabel.sizeThatFits(frame.size)
        totalLikeLabel.frame = CGRect(
            x: viewImage.right+5,
            y: 2,
            width: totalLikeLabellSize.width,
            height: 25)
        
        descriptionLabel.frame = CGRect(
            x: 15,
            y: totalLikeLabel.bottom,
            width: contentView.width-20,
            height: 40)
        
        seeMoreCommentsButton.frame = CGRect(
            x: 15,
            y: descriptionLabel.bottom+5,
            width: contentView.width-20,
            height: 10)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    public func configure(with model: Userpost) {
        ///Models
        self.model = model
        
        ///Caption de post
        guard let author = model.userAuthor?.username, let caption = model.content else { return }
        let authorName = joinText(username: author, description: caption)
        descriptionLabel.attributedText = authorName
        
        ///Likes
        guard let likes = model.likes?.count else { return }
        
        
        ///Hay que coprobar si el array de likes está vacio o no.
        if likes == 0 {
            print("array vacio...")
            let likesUsername = joinTextLike(text: "A nadie", description: "le gusta")
            totalLikeLabel.attributedText = likesUsername
        } else {
            guard let username = model.likes?[0].userlike?.username  else { return }
            var text = ""
            var textLikes = ""
            if (likes-1) != 0 {
                text = "Les gusta a"
                textLikes = "\(username) y a \(likes-1) personas más"
            } else {
                text = "Les gusta a"
                textLikes = "\(username)"
            }
            let likesUsername = joinTextLike(text: text, description: textLikes)
            totalLikeLabel.attributedText = likesUsername
        }
        
        
        
        
        ///Comments
        guard let comments = model.comments?.count else { return }
        seeMoreCommentsButton.setTitle("Ver los \(comments) comentarios", for: .normal)
    }
    
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
    
    private func joinText(username:String, description:String) -> NSMutableAttributedString {
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
