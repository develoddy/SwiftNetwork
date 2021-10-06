//
//  StoryCollectionViewCell.swift
//  SwiftNetwork
//
//  Created by Eddy Donald Chinchay Lujan on 6/10/21.
//

import UIKit

class StoryCollectionViewCell: UICollectionViewCell {
     
    static let identifier = "StoryCollectionViewCell"
    
    let storybutton = UIButton()
    let usernameLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .systemBackground
        setupview()
        configureStoryButtom()
        configureUsernameLabel()
    }
    
    private func setupview() {
        contentView.addSubview(storybutton)
        contentView.addSubview(usernameLabel)
    }
    
    private func configureStoryButtom() {
        storybutton.backgroundColor = .systemYellow
        storybutton.frame = storybutton.bounds
    }
    
    private func configureUsernameLabel() {
        usernameLabel.text = "eddylujann"
        usernameLabel.backgroundColor = .systemBackground
        usernameLabel.textAlignment = .center
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let center = contentView.frame.size.width/3
        storybutton.frame = CGRect(x: center, y:10, width:50, height: 50)
        storybutton.layer.cornerRadius = storybutton.height/2
        
        let usernameLabelLabelSize = usernameLabel.sizeThatFits(frame.size)
        usernameLabel.frame = CGRect(x: 5, y: storybutton.bottom+2, width: contentView.width-10, height: usernameLabelLabelSize.height).integral
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
