//
//  IGFeedPostDescriptionTableViewCell.swift
//  SwiftNetwork
//
//  Created by Eddy Donald Chinchay Lujan on 27/4/21.
//

import UIKit

class IGFeedPostDescriptionTableViewCell: UITableViewCell {
    
    static let identifier = "IGFeedPostDescriptionTableViewCell"
    
    private let profileImagesLikes: UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.layer.masksToBounds = true
        imageView.backgroundColor = .systemPink
        return imageView
    }()
    
    private let totalLikeLabel: UILabel = {
        let label = UILabel()
        //label.backgroundColor = .green
        label.font = Constants.fontSize.regular //.systemFont(ofSize: 16, weight: .regular)
        
        return label
    }()
    
    private let usernameLabel: UILabel = {
        let label = UILabel()
        label.font = Constants.fontSize.semibold //.systemFont(ofSize: 16, weight: .semibold)
        return label
    }()
   
    private let descriptionLabel: UILabel = {
        let label = UILabel.init()
        label.textAlignment = .left
        //label.font = .systemFont(ofSize: 16, weight: .regular)
        label.textColor = UIColor.black
        label.numberOfLines = 0
        return label
    }()
    
    private let seeMoreCommentsLabel: UILabel = {
        let label = UILabel()
        label.font = Constants.fontSize.regular //.systemFont(ofSize: 14, weight: .regular)
        //label.backgroundColor = .systemGray
        label.textColor = Constants.Color.dark
        return label
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
    
    ///init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(profileImagesLikes)
        contentView.addSubview(totalLikeLabel)
        contentView.addSubview(descriptionLabel)
        contentView.addSubview(seeMoreCommentsLabel)
        contentView.addSubview(labelTextComment)
        ///contentView.backgroundColor = .blue
        
        contentView.addSubview(viewImage)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        ///let viewImageSize = viewImage.sizeThatFits(frame.size)
        let imageSize = 60
        viewImage.frame = CGRect(
            x: 15,
            y: 2,
            width: imageSize,
            height: 25).integral
        
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
                width: buttonSize/4,
                height: buttonSize/4)
            image.layer.cornerRadius = image.height/2
        }
    
        let totalLikeLabellSize = totalLikeLabel.sizeThatFits(frame.size)
        totalLikeLabel.frame = CGRect(
            x: viewImage.right+5,
            y: 2,
            width: totalLikeLabellSize.width,//contentView.width/2,
            height: 25)
        
        
        /*totalLikeLabel.backgroundColor = .blue
        totalLikeLabel.frame = CGRect(
            x: 15,
            y: viewImage.bottom+5 ,//5,
            width: contentView.width-20,
            height: 20)*/
        
        descriptionLabel.backgroundColor = .systemBackground
        descriptionLabel.frame = CGRect(
            x: 15,
            y: totalLikeLabel.bottom+5,
            width: contentView.width-20,
            height: 40)
        
        seeMoreCommentsLabel.backgroundColor = .systemBackground
        seeMoreCommentsLabel.frame = CGRect(
            x: 15,
            y: descriptionLabel.bottom+5,
            width: contentView.width-20,
            height: 10)

    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    public func configure(with model: UserPostViewModel) {
        ///Caption de post
        let usernameText = model.owner.username
        guard let description = model.caption else { return  }
    
        let attributedString = joinText(username: usernameText ?? "", description: description)
        descriptionLabel.attributedText = attributedString
        
        ///Total Likes
        let countLikes = model.likeCount.count+1
        var likes : Int = 0
        for i in 0..<countLikes {
            likes = i
        }
        let text = "Les gusta a "
        let textLike = "rebeca y a \(likes) personas más"
        let attributedString2 = joinTextLike(text: text, description: textLike)
        totalLikeLabel.attributedText = attributedString2
        
        ///Ver mas comentarios
        let countComment = model.comments.count
        seeMoreCommentsLabel.text = "Ver los \(countComment) comentarios"
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
        let attrs = [NSAttributedString.Key.font : Constants.fontSize.semibold ] //UIFont.systemFont(ofSize: 16, weight: .bold) ]
        let attributedString = NSMutableAttributedString(string:boldText, attributes:attrs)
        
        let normalText = description
        let attrs2 = [NSAttributedString.Key.font : Constants.fontSize.regular ] //UIFont.systemFont(ofSize: 16, weight: .regular) ]
        let normalString = NSMutableAttributedString(string:normalText, attributes:attrs2)
        attributedString.append(normalString)
        return attributedString
    }
}
