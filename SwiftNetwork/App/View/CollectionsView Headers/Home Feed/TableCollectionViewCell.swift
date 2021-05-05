//
//  TableCollectionViewCell.swift
//  SwiftNetwork
//
//  Created by Eddy Donald Chinchay Lujan on 25/4/21.
//

import UIKit



class TableSeeMoreButtomViewCell: UICollectionViewCell {
    
    static let identifier = "TableSeeMoreButtomViewCell"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        //contentView.backgroundColor = .yellow
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class TableCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "TableCollectionViewCell"
    
    private let myImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.layer.opacity = 1.0
        imageView.layer.cornerRadius = 12
        imageView.layer.borderWidth = 3
        imageView.layer.borderColor = UIColor.systemPurple.cgColor
        //imageView.backgroundColor = .systemRed
        return imageView
    }()
    
    private let myLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 16, weight: .regular)
        //label.backgroundColor = .systemBlue
        return label
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(myImageView)
        contentView.addSubview(myLabel)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        myImageView.frame = CGRect(
            x: 5,
            y: 5,
            width: contentView.width-10,
            height: contentView.height-5-25)
        
        
        myLabel.frame = CGRect(
            x: 5,
            y:   myImageView.bottom+5,//contentView.height-50,
            width: contentView.width-10,
            height: contentView.top+20) //30
        
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        myLabel.text = nil
    }
    
    public func configure(with model: CollectionTableCellModel) {
        myLabel.text = model.title
        myImageView.image = UIImage(named: model.imageName)
    }
}
