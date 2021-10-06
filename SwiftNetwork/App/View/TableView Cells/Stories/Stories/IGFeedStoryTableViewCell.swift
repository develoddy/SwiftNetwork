//
//  IGFeedStoryTableViewCell.swift
//  SwiftNetwork
//
//  Created by Eddy Donald Chinchay Lujan on 23/7/21.
//

import UIKit

class IGFeedStoryTableViewCell: UITableViewCell {

    static let identifier = "IGFeedStoryTableViewCell"
    
    let imageStoryView: UIImageView = {
        let  imageView = UIImageView()
        imageView.backgroundColor = .systemGreen
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .systemRed
        setupView()
    }
    
    func setupView() {
        addSubview(imageStoryView)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        imageStoryView.frame = CGRect(
            x: 5,
            y: 5,
            width: width-10,
            height: height-10)
    }
    public func configure(model: Story) {
        imageStoryView.image = UIImage(named: model.imageName)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

}
