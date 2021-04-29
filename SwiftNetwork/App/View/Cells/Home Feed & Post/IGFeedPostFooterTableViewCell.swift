//
//  IGFeedPostFooterTableViewCell.swift
//  SwiftNetwork
//
//  Created by Eddy Donald Chinchay Lujan on 28/4/21.
//

import UIKit

class IGFeedPostFooterTableViewCell: UITableViewCell {
    
    static let identifier = "IGFeedPostFooterTableViewCell"
    
    private let profilePhotoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.layer.masksToBounds = true
        imageView.tintColor = .label
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private let boxTextField : UITextField = {
        let textField = UITextField()
        textField.backgroundColor = .systemBackground
        textField.placeholder = "Añade un comentario..."
        return textField
    }()
    
    private let toPostButton: UIButton = {
       let button = UIButton()
        button.tintColor = .red //.label
        button.setImage(UIImage(systemName:"heart.fill"), for: .normal)
        return button
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = .systemBackground
        contentView.addSubview(profilePhotoImageView)
        contentView.addSubview(boxTextField)
        contentView.addSubview(toPostButton)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let size = contentView.height-4
        profilePhotoImageView.frame = CGRect(
            x: 2,
            y: 2,
            width: size,
            height: size)
        profilePhotoImageView.layer.cornerRadius = size/2
        
        boxTextField.frame = CGRect(
            x: profilePhotoImageView.right+10,
            y: 2,
            width: contentView.width-(size*2)-15,
            height: contentView.height-4)
        
        toPostButton.frame = CGRect(
            x: contentView.width-size,
            y: 2,
            width: size,
            height: size)
    }
    
    public func configure() {
        profilePhotoImageView.image = UIImage(systemName: "person.circle")
    }
    
    override func prepareForReuse() {
    }
    
}
