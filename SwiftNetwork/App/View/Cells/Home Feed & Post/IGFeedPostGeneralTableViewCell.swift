//
//  IGFeedPostGeneralTableViewCell.swift
//  SwiftNetwork
//
//  Created by Eddy Donald Chinchay Lujan on 14/4/21.
//

import UIKit

/// Comments
/// IGFeedPostDescriptionTableViewCell
class IGFeedPostGeneralTableViewCell: UITableViewCell {
    
    static let identifier = "IGFeedPostGeneralTableViewCell"

    private let labelTextComment: UILabel = {
        let label = UILabel()
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
        ///contentView.backgroundColor = .red
        contentView.addSubview(labelTextComment)
        contentView.addSubview(likeButton)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let size = contentView.height-4
    
        labelTextComment.frame = CGRect(
            x: 10,
            y: 5,
            width: contentView.width-(size*2)-15,
            height: contentView.height-5) 
        
        likeButton.frame = CGRect(
            x: contentView.width-size,
            y: 2,
            width: size,
            height: size)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        labelTextComment.text = nil
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
    
    public func configure(with model: PostCommentsViewModel) {
        ///Comentarios
        let username = model.username
        let comment = model.content
        let attributedString = joinText(username: username, description: comment)
        labelTextComment.attributedText = attributedString
    }
}
