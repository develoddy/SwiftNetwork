//
//  MenuHeaderCollectionReusableView.swift
//  SwiftNetwork
//
//  Created by Eddy Donald Chinchay Lujan on 1/6/21.
//

import UIKit

class MenuHeaderCollectionReusableView: UICollectionReusableView {
    static let identifier = "MenuHeaderCollectionReusableView"
    
    private let profileImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(systemName: "person.circle"))
        imageView.tintColor = .darkGray
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let usernameButton: UIButton = {
        let button = UIButton()
        button.setTitle("Eddy Lujan", for: .normal)
        button.contentHorizontalAlignment = .left
        button.setTitleColor(Constants.Color.black, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 20, weight: .semibold)
        return button
    }()
    
    private let label: UILabel = {
        let label = UILabel()
        label.text = "Ir a tu perfil"
        label.font = .systemFont(ofSize: 12, weight: .regular)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        //backgroundColor = .systemBackground
        clipsToBounds = true
        addSubviews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addSubviews() {
        addSubview(profileImageView)
        addSubview(usernameButton)
        addSubview(label)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        profileImageView.contentMode = .scaleAspectFit
        profileImageView.frame = CGRect(
            x: 10,
            y: 10,
            width: 60,
            height: 60)
        profileImageView.layer.cornerRadius = profileImageView.height/2
        
        let usernameButtonSize = usernameButton.sizeThatFits(frame.size)
        ///usernameButton.backgroundColor = .red
        usernameButton.frame = CGRect(
            x: profileImageView.right+10,
            y: 15,
            width: usernameButtonSize.width,
            height: 25)
        
        let labellSize = label.sizeThatFits(frame.size)
        ///label.backgroundColor = .blue
        label.frame = CGRect(
            x: profileImageView.right+10,
            y: usernameButton.bottom,
            width: labellSize.width,
            height: labellSize.height)
        
    }
    
    override func prepareForReuse() {
    }
    
    
    public func configure() {
    }
}
