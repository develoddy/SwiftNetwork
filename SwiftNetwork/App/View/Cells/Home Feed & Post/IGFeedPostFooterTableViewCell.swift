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
        textField.layer.borderWidth = 1.0
        textField.layer.borderColor = Constants.Color.whiteLight.cgColor //UIColor.secondaryLabel.cgColor //
        textField.layer.cornerRadius = Constants.Constants.cornerRadius //22
        textField.placeholder = "Añade un comentario..."
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 0))
        textField.leftViewMode = .always
        return textField
    }()
    
    private let toPostButton: UIButton = {
       let button = UIButton()
        button.tintColor = .red //.label
        let config = UIImage.SymbolConfiguration(pointSize: 16, weight: .thin)
        let image = UIImage(systemName: "suit.heart", withConfiguration: config)
        button.setImage(image, for: .normal)
        return button
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = .systemBackground
        contentView.addSubview(profilePhotoImageView)
        contentView.addSubview(boxTextField)
        //contentView.addSubview(toPostButton)
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
            width: 40,//size,
            height: 40)//size)
        profilePhotoImageView.layer.cornerRadius = size/2
        
        boxTextField.backgroundColor = Constants.Color.whiteLight
        boxTextField.frame = CGRect(
            x: profilePhotoImageView.right+10,
            y: 2,
            width: contentView.width-(size*1)-20,
            height: contentView.height-5)
        boxTextField.layer.cornerRadius = size/2
        
        toPostButton.frame = CGRect(
            x: contentView.width-25,
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
