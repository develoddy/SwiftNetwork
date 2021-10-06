//
//  MenuCollectionViewCell.swift
//  SwiftNetwork
//
//  Created by Eddy Donald Chinchay Lujan on 1/6/21.
//

import UIKit

class MenuCollectionViewCell: UICollectionViewCell {
    static let identifier = "MenuCollectionViewCell"
    
    let containerView = UIView(frame: CGRect(x:0,y:0,width:320,height:500))
    
    private let boxView: UIView = {
       let view = UIImageView()
        view.clipsToBounds = true
        view.contentMode = .scaleAspectFill //.scaleAspectFit //
        return view
    }()
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.contentMode =  .scaleAspectFit //.scaleAspectFill
        return imageView
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .semibold)
        return label
    }()
    
    private var colors: [UIColor] = [
        .systemPink,
        .systemBlue,
        .systemPurple,
        .systemOrange,
        .systemGreen,
        .systemRed,
        .systemYellow,
        .darkGray,
        .systemTeal
    ]
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .white
        contentView.layer.cornerRadius = 5
        contentView.layer.masksToBounds = true
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        contentView.addSubview(boxView)
        //contentView.backgroundColor = colors.randomElement()
        
        boxView.addSubview(imageView)
        boxView.addSubview(nameLabel)
        
    }
    
    override func layoutSubviews() {
        boxView.frame = contentView.bounds
        
        
        imageView.frame = CGRect(
            x: 5,
            y: 10,
            width: 30,
            height: 30)
        imageView.layer.cornerRadius = imageView.height/2
        
        let nameLabelSize = nameLabel.sizeThatFits(frame.size)
        nameLabel.frame = CGRect(
            x: 10,
            y: imageView.bottom+5,
            width: nameLabelSize.width,
            height: nameLabelSize.height).integral
    }
    
    override func prepareForReuse() {
    }
    
    public func configure(model: MenuCollectionViewModel) {
        imageView.image = model.image
        imageView.tintColor = model.color
        nameLabel.text = model.title
    }
}
