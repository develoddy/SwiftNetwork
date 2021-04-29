//
//  IGFeedPostDescriptionTableViewCell.swift
//  SwiftNetwork
//
//  Created by Eddy Donald Chinchay Lujan on 27/4/21.
//

import UIKit

class IGFeedPostDescriptionTableViewCell: UITableViewCell {
    
    static let identifier = "IGFeedPostDescriptionTableViewCell"
    
    private let totalLikeLabel: UILabel = {
        let label = UILabel()
        //label.backgroundColor = .green
        label.font = .systemFont(ofSize: 16, weight: .semibold)
        return label
    }()
    
    private let usernameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .semibold)
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
        label.font = .systemFont(ofSize: 16, weight: .regular)
        //label.backgroundColor = .systemGray
        label.textColor = .gray
        return label
    }()
    
    private let labelTextComment: UILabel = {
        let label = UILabel()
        label.backgroundColor = .red
        return label
    }()
    
    /*private var labelArr: [UILabel] = {
        let label = UILabel()
        return [label]
    }()*/

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(totalLikeLabel)
        contentView.addSubview(descriptionLabel)
        contentView.addSubview(seeMoreCommentsLabel)
        contentView.addSubview(labelTextComment)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        totalLikeLabel.frame = CGRect(
            x: 10,
            y: 5,
            width: contentView.width-20,
            height: 20)
        
        descriptionLabel.frame = CGRect(
            x: 10,
            y: totalLikeLabel.bottom+5,
            width: contentView.width-20,
            height: 40)
        
        seeMoreCommentsLabel.frame = CGRect(
            x: 10,
            y: descriptionLabel.bottom+5,
            width: contentView.width-20,
            height: 20)

    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
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
    
    public func configure(with model: UserPost) {
        
        ///Caption de post
        let usernameText = model.owner.username
        guard let description = model.caption else { return  }
    
        let attributedString = joinText(username: usernameText, description: description)
        descriptionLabel.attributedText = attributedString
        
        ///Total Likes
        let countLikes = model.likeCount.count
        var likes : Int = 0
        for i in 0..<countLikes {
            likes = i
        }
        totalLikeLabel.text = "\(likes) Me gusta"
        
        ///Ver mas comentarios
        let countComment = model.comments.count
        seeMoreCommentsLabel.text = "Ver los \(countComment) comentarios"
        
    }
}
