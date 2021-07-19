//
//  TableCollectionViewCell.swift
//  SwiftNetwork
//
//  Created by Eddy Donald Chinchay Lujan on 25/4/21.
//

import UIKit



class TableCreateStorieViewCell: UICollectionViewCell {
    
    static let identifier = "TableCreateStorieViewCell"
    
    private let superStoryView: UIView = {
        let imageView = UIView()
        imageView.clipsToBounds = true
        imageView.layer.masksToBounds = true
        imageView.layer.borderWidth = 1
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 10
        imageView.layer.borderColor = UIColor.systemFill.cgColor
        return imageView
    }()
    
    private let myImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "eddy")
        imageView.layer.masksToBounds = true
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.layer.opacity = 1
        imageView.layer.cornerRadius = 0
        imageView.layer.borderWidth = 0
        imageView.layer.borderColor = UIColor.white.cgColor
        imageView.backgroundColor = .gray
        return imageView
    }()
    
    private let subView: UIView = {
        let label = UILabel()
        label.backgroundColor = Constants.Color.light
        return label
    }()
    
   
    private let plusImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "plus.circle.fill")
        imageView.tintColor = Constants.Color.purple
        //imageView.backgroundColor = .systemGreen
        imageView.layer.masksToBounds = true
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        //imageView.layer.borderWidth = 4
        //imageView.layer.borderColor = UIColor.white.cgColor
        return imageView
    }()
    
    private let labelText: UILabel = {
        let label = UILabel()
        label.text = "Create history"
        label.font = .systemFont(ofSize: 14, weight: .bold)
        label.textColor = .black
        label.textAlignment = .center
        //label.backgroundColor = .purple
        return label
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        ///contentView.backgroundColor = .yellow
        contentView.addSubview(superStoryView)
        //contentView.addSubview(myImageView)
        
        //contentView.addSubview(subView)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        superStoryView.frame = CGRect(
            x: 5,
            y: 15,
            width: contentView.width-10,
            height: contentView.height-5-25)
        superStoryView.addSubview(myImageView)
        
        
        myImageView.frame = CGRect(
            x: 0,
            y: 0,
            width: contentView.width-10,
            height: contentView.height/1.8)
        
        superStoryView.addSubview(subView)
        subView.frame = CGRect(
            x: 0,
            y: myImageView.bottom,
            width: contentView.width-10,
            height: contentView.height)
        
        subView.addSubview(plusImageView)
        
        plusImageView.frame = CGRect(
            x: subView.center.x/1.5,
            y: 3,
            width: contentView.height/6,
            height: contentView.height/6)
        plusImageView.layer.cornerRadius = plusImageView.height/2
        
        subView.addSubview(labelText)
        labelText.frame = CGRect(
            x: 0,
            y: plusImageView.bottom+3,
            width: contentView.width-15,
            height: 20)
        
        //label.frame = CGRect(x: 15, y: contentView.height/1.8, width: contentView.width-20, height: contentView.height/2)
        
    }
}





class TableCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "TableCollectionViewCell"
    
    private let superStoryView: UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.layer.masksToBounds = true
        imageView.layer.borderWidth = 2
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 10
        imageView.layer.borderColor = UIColor.systemFill.cgColor //Constants.ColorText.purple.cgColor
        return imageView
    }()
    
    private let myImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.masksToBounds = true
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.layer.opacity = 1
        imageView.layer.cornerRadius = 12
        imageView.layer.borderWidth = 5
        imageView.layer.borderColor = UIColor.white.cgColor
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
    
    private let label: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .systemFont(ofSize: 14, weight: .bold)
        label.text = "Name"
        return label
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(superStoryView)
        contentView.addSubview(label)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        superStoryView.frame = CGRect(
            x: 5,
            y: 15,
            width: contentView.width-10,
            height: contentView.height-5-25)
        //superStoryView.layer.cornerRadius = superView.height/2
        superStoryView.addSubview(myImageView)
        
        myImageView.frame = CGRect(
            x: 0,
            y: 0,
            width: contentView.width-10,
            height: contentView.height-5-25)
        
        label.frame = CGRect(x: 15, y: contentView.height/1.8, width: contentView.width-20, height: contentView.height/2)
        
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
        label.text = model.title
        myImageView.image = UIImage(named: model.imageName)
    }
}
