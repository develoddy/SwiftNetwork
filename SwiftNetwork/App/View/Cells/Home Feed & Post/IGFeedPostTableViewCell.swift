//
//  IGFeedPostTableViewCell.swift
//  SwiftNetwork
//
//  Created by Eddy Donald Chinchay Lujan on 14/4/21.
//

import UIKit
import SDWebImage
import AVFoundation

/// Cell for primary post conente
final class IGFeedPostTableViewCell: UITableViewCell {
    
    static let identifier = "IGFeedPostTableViewCell"
    
    /*let label: UILabel = {
        let label = UILabel.init()
        label.textAlignment = .left
        label.font = .systemFont(ofSize: 18, weight: .regular)
        label.textColor = UIColor.black
        label.numberOfLines = 0
        return label
    }()*/
    
    private let postImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.backgroundColor = nil
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private var player: AVPlayer?
    private var playerLayer =  AVPlayerLayer()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.layer.addSublayer(playerLayer)
        contentView.addSubview(postImageView)
        //contentView.addSubview(label)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func configure(with post: UserPost) {
        //postImageView.image = UIImage(named: "test")
        //return
        switch post.postType {
        case .photo:
            postImageView.image = UIImage(named: "img6")
            //label.text = post.caption
        case .video:
            //Load and play video
            player = AVPlayer(url: post.postURL)
            playerLayer.player = player
            playerLayer.player?.volume = 0
            playerLayer.player?.play()
        }
    }
    
    override func prepareForReuse() {
        postImageView.image = nil
        //label.text = nil
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        playerLayer.frame = contentView.bounds
        postImageView.frame = contentView.bounds
        //label.frame = contentView.bounds
    
        /*label.frame = CGRect(
            x: 5,
            y: 5,
            width: contentView.width-10,
            height: 50)
        
        postImageView.frame = CGRect(
            x: 0,
            y: label.frame.origin.y + label.frame.size.height+5,
            width: contentView.width,
            height: contentView.height-50)*/
    }
}
