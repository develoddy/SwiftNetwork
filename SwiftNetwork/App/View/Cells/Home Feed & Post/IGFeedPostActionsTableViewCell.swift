//
//  IGFeedPostActionsTableViewCell.swift
//  SwiftNetwork
//
//  Created by Eddy Donald Chinchay Lujan on 14/4/21.
//

import UIKit

protocol IGFeedPostActionsTableViewCellDelegate: AnyObject {
    func didTapLikeButton()
    func didTapCommentButton(model: UserPostViewModel)
    func didTapSendButton()
}

class IGFeedPostActionsTableViewCell: UITableViewCell {
    
    static let identifier = "IGFeedPostActionsTableViewCell"
    
    public var delegate: IGFeedPostActionsTableViewCellDelegate?
    
    private var model: UserPostViewModel?
    
    private let likeButton: UIButton = {
        let button = UIButton()
        let config = UIImage.SymbolConfiguration(pointSize: 24, weight: .regular) //semibold, regular, thin
        let image = UIImage(systemName: "hand.thumbsup", withConfiguration: config)
        button.setImage(image, for: .normal)
        button.tintColor = .darkGray
        //button.titleLabel?.font = .systemFont(ofSize: 8, weight: .regular)
        return button
    }()
    
    private let commentButton: UIButton = {
        let button = UIButton()
        let config = UIImage.SymbolConfiguration(pointSize: 24, weight: .regular) //semibold, regular, thin
        let image = UIImage(systemName: "message", withConfiguration: config) ///message
        button.setImage(image, for: .normal)
        button.tintColor = .darkGray
        return button
    }()
    
    private let shareButton: UIButton = {
        let button = UIButton()
        let config = UIImage.SymbolConfiguration(pointSize: 24, weight: .regular) //semibold, regular, thin
        let image = UIImage(systemName: "arrowshape.turn.up.right", withConfiguration: config) ///arrowshape.turn.up.right
        button.setImage(image, for: .normal)
        button.tintColor = .darkGray
        return button
    }()
    
    
    private let sendButton: UIButton = {
        let button = UIButton()
        let config = UIImage.SymbolConfiguration(pointSize: 24, weight: .regular) //semibold, regular, thin
        let image = UIImage(systemName: "paperplane", withConfiguration: config) ///paperplane
        button.setImage(image, for: .normal)
        button.tintColor = .darkGray
        return button
    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        //contentView.backgroundColor = .systemPink
        contentView.addSubview(likeButton)
        contentView.addSubview(commentButton)
        contentView.addSubview(sendButton)
        contentView.addSubview(shareButton)
        
        likeButton.addTarget(self, action: #selector(didTapLikeButton), for: .touchUpInside)
        commentButton.addTarget(self, action: #selector(didTapCommetnButton), for: .touchUpInside)
        sendButton.addTarget(self, action: #selector(didTapSendButton), for: .touchUpInside)
        
        addTextOnLikeButton()
        addTextOnCommentButton()
        addTextOnShareButton()
        addTextOnSendButton()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func configure(with post: UserPostViewModel) {
        model = post
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        // like, comment, send, shared
        /*let buttonSize = contentView.height-10
        let buttons = [likeButton, commentButton, sendButton, shareButton]
        for x in 0..<buttons.count {
            let button = buttons[x]
            button.frame = CGRect(
                x: (CGFloat(x)*buttonSize)+(10*CGFloat(x+1)),
                y: 5,
                width: buttonSize,
                height: buttonSize)
        }*/
        
        //let buttonSize = contentView.height
        
        let buttons = [likeButton, commentButton, shareButton, sendButton ]
        let widthSize = (contentView.width / CGFloat(buttons.count))//-6
        
        for x in 0..<buttons.count {
            let button = buttons[x]
            button.backgroundColor = .systemBackground
            ///button.layer.cornerRadius = 5
            button.frame = CGRect(
                x: (CGFloat(x)*widthSize)+(1*CGFloat(x)), //x+1
                y: 5,
                width: widthSize,
                height: widthSize/2)
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
    }
    
    @objc private func didTapLikeButton() {
        delegate?.didTapLikeButton()
    }
    
    @objc private func didTapCommetnButton() {
        
        guard let model = model else {
            return
        }
        
        delegate?.didTapCommentButton(model: model)
    }
    @objc private func didTapSendButton() {
        delegate?.didTapSendButton()
    }
}


//MARK: BUTTONS
extension IGFeedPostActionsTableViewCell {
    private func addTextOnLikeButton() {
        likeButton.titleLabel?.lineBreakMode = NSLineBreakMode.byWordWrapping
        let buttonText: NSString = "\nLike" // 10\nPost
        let newlineRange: NSRange = buttonText.range(of: "\n")
        
        //getting both substrings
        var substring1 = ""
        var substring2 = ""
        
        if(newlineRange.location != NSNotFound) {
            substring1 = buttonText.substring(to: newlineRange.location)
            substring2 = buttonText.substring(from: newlineRange.location)
        }
        
        let font1: UIFont = UIFont(name: "HelveticaNeue-Bold", size: 17.0)!
        ///label.font = UIFont.boldSystemFont(ofSize: 16.0)
        let attributes1 = [NSMutableAttributedString.Key.font: font1]
        let attrString1 = NSMutableAttributedString(string: substring1, attributes: attributes1)
        
        let font2: UIFont = UIFont(name: "Arial", size: 14.0)!
        let attributes2 = [NSMutableAttributedString.Key.font: font2]
        let attrString2 = NSMutableAttributedString(string: substring2, attributes: attributes2)
        
        //appending both attributed strings
        attrString1.append(attrString2)
        likeButton.setAttributedTitle(attrString1, for: [])
    }
    
    private func addTextOnCommentButton() {
        commentButton.titleLabel?.lineBreakMode = NSLineBreakMode.byWordWrapping
        let buttonText: NSString = "\nComment" // 10\nPost
        let newlineRange: NSRange = buttonText.range(of: "\n")
        
        //getting both substrings
        var substring1 = ""
        var substring2 = ""
        
        if(newlineRange.location != NSNotFound) {
            substring1 = buttonText.substring(to: newlineRange.location)
            substring2 = buttonText.substring(from: newlineRange.location)
        }
        
        let font1: UIFont = UIFont(name: "HelveticaNeue-Bold", size: 17.0)!
        ///label.font = UIFont.boldSystemFont(ofSize: 16.0)
        let attributes1 = [NSMutableAttributedString.Key.font: font1]
        let attrString1 = NSMutableAttributedString(string: substring1, attributes: attributes1)
        
        let font2: UIFont = UIFont(name: "Arial", size: 14.0)!
        let attributes2 = [NSMutableAttributedString.Key.font: font2]
        let attrString2 = NSMutableAttributedString(string: substring2, attributes: attributes2)
        
        //appending both attributed strings
        attrString1.append(attrString2)
        commentButton.setAttributedTitle(attrString1, for: [])
    }
    
    private func addTextOnShareButton() {
        shareButton.titleLabel?.lineBreakMode = NSLineBreakMode.byWordWrapping
        let buttonText: NSString = "\nShare" // 10\nPost
        let newlineRange: NSRange = buttonText.range(of: "\n")
        
        //getting both substrings
        var substring1 = ""
        var substring2 = ""
        
        if(newlineRange.location != NSNotFound) {
            substring1 = buttonText.substring(to: newlineRange.location)
            substring2 = buttonText.substring(from: newlineRange.location)
        }
        
        let font1: UIFont = UIFont(name: "HelveticaNeue-Bold", size: 17.0)!
        ///label.font = UIFont.boldSystemFont(ofSize: 16.0)
        let attributes1 = [NSMutableAttributedString.Key.font: font1]
        let attrString1 = NSMutableAttributedString(string: substring1, attributes: attributes1)
        
        let font2: UIFont = UIFont(name: "Arial", size: 14.0)!
        let attributes2 = [NSMutableAttributedString.Key.font: font2]
        let attrString2 = NSMutableAttributedString(string: substring2, attributes: attributes2)
        
        //appending both attributed strings
        attrString1.append(attrString2)
        shareButton.setAttributedTitle(attrString1, for: [])
    }
    
    private func addTextOnSendButton() {
        sendButton.titleLabel?.lineBreakMode = NSLineBreakMode.byWordWrapping
        let buttonText: NSString = "\nSend" // 10\nPost
        let newlineRange: NSRange = buttonText.range(of: "\n")
        
        //getting both substrings
        var substring1 = ""
        var substring2 = ""
        
        if(newlineRange.location != NSNotFound) {
            substring1 = buttonText.substring(to: newlineRange.location)
            substring2 = buttonText.substring(from: newlineRange.location)
        }
        
        let font1: UIFont = UIFont(name: "HelveticaNeue-Bold", size: 17.0)!
        ///label.font = UIFont.boldSystemFont(ofSize: 16.0)
        let attributes1 = [NSMutableAttributedString.Key.font: font1]
        let attrString1 = NSMutableAttributedString(string: substring1, attributes: attributes1)
        
        let font2: UIFont = UIFont(name: "Arial", size: 14.0)!
        let attributes2 = [NSMutableAttributedString.Key.font: font2]
        let attrString2 = NSMutableAttributedString(string: substring2, attributes: attributes2)
        
        //appending both attributed strings
        attrString1.append(attrString2)
        sendButton.setAttributedTitle(attrString1, for: [])
    }
}
