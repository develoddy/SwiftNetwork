//
//  PostCommentsListTableViewCell.swift
//  SwiftNetwork
//
//  Created by Eddy Donald Chinchay Lujan on 29/4/21.
//

import UIKit


class PostCommentsListTableViewCell: UITableViewCell {
    
    static let identifier = "PostCommentsListTableViewCell"
    
    private let userImageView: UIImageView = {
        let imageView = UIImageView() 
        imageView.contentMode = .scaleAspectFill
        imageView.layer.masksToBounds = true
        imageView.backgroundColor = .secondarySystemBackground
        return imageView
    }()
    
    private let commentlabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.numberOfLines = 1
        return label
    }()
    
    private let timeToPostCommentLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.font = .systemFont(ofSize: 16, weight: .regular)
        label.text = "1h"
        label.textColor = .secondaryLabel
        return label
    }()
    
    private let countLikesLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.font = .systemFont(ofSize: 12, weight: .regular)
        label.text = "4 Me gusta"
        label.textColor = .secondaryLabel
        return label
    }()
    
    private let replyToCommentLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.font = .systemFont(ofSize: 12, weight: .regular)
        label.text = "Responder"
        label.textColor = .secondaryLabel
        return label
    }()
    
    private let likeButton: UIButton = {
       let button = UIButton()
        button.tintColor = .label
        let config = UIImage.SymbolConfiguration(pointSize: 16, weight: .thin) //semibold, regular, thin
        let image = UIImage(systemName: "suit.heart", withConfiguration: config)
        button.setImage(image, for: .normal)
        return button
    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        //contentView.backgroundColor = .systemGreen
        contentView.addSubview(userImageView)
        contentView.addSubview(commentlabel)
        contentView.addSubview(likeButton)
        contentView.addSubview(timeToPostCommentLabel)
        contentView.addSubview(replyToCommentLabel)
        contentView.addSubview(countLikesLabel)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let size = contentView.height-4
        
        userImageView.frame = CGRect(
            x: 5,
            y: 10,
            width: contentView.height/2,
            height: contentView.height/2)
        userImageView.layer.cornerRadius = userImageView.height/2.0
        
        likeButton.frame = CGRect(
            x: contentView.width-size,
            y: 2,
            width: size,
            height: size)
        
        let labelHeight = contentView.height/2
        commentlabel.frame = CGRect(
             x: userImageView.right+5,
             y: 10,
             width: contentView.width-(size*2)-15,
             height: labelHeight)
        
        let  buttonSubLabelWidth = contentView.width > 100 ? 280.0 : contentView.width/3
        timeToPostCommentLabel.frame = CGRect(
            x: userImageView.right+5,
            y: commentlabel.bottom,
            width: 30,//contentView.width-8-userImageView.width-buttonSubLabelWidth,
            height: labelHeight-10)
        
        countLikesLabel.frame = CGRect(
            x: timeToPostCommentLabel.right+5,
            y: commentlabel.bottom,
            width: contentView.width-8-userImageView.width-buttonSubLabelWidth,
            height: labelHeight-10)
        
        
        replyToCommentLabel.frame = CGRect(
            x: countLikesLabel.right+5,
            y: commentlabel.bottom,
            width: contentView.width-8-userImageView.width-buttonSubLabelWidth,
            height: labelHeight-10)
    }
    
    
    private func joinText(username:String, description:String) -> NSMutableAttributedString {
        ///Username
        let boldText  = username + " "
        let attrs = [NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 14)]
        let attributedString = NSMutableAttributedString(string:boldText, attributes:attrs)
        ///Commentario
        let normalText = description
        let attrs2 = [NSAttributedString.Key.font : UIFont.systemFont(ofSize: CGFloat(14))]
        let normalString = NSMutableAttributedString(string:normalText, attributes:attrs2)
        attributedString.append(normalString)
        return attributedString
    }
    
    public func configure(with username: String, with model: String) {
        
        let username = username
        let comment = model
        
        let attributedString = joinText(username: username, description: comment)
        commentlabel.attributedText = attributedString
        userImageView.image = UIImage(named: "person.crop.circle")
    }
}


/*
extension PostCommentsListTableViewCell: UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return UICollectionViewCell()
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        print("\(collectionView.tag) ---- \(indexPath.item) ")
    }
}
*/
