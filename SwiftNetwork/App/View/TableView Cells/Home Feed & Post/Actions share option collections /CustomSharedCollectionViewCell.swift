//
//  CustomSharedCollectionViewCell.swift
//  SwiftNetwork
//
//  Created by Eddy Donald Chinchay Lujan on 9/7/21.
//

import UIKit

///Boddy
class CustomSharedCollectionViewCell: UICollectionViewCell  {
    
    static let identifier = "CustomSharedCollectionViewCell"
    
    lazy var settingImage: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.masksToBounds = true
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.tintColor = Constants.Color.black
        return imageView
    }()
    
    let label: UILabel = {
        let label = UILabel()
        return label
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        backgroundColor = .systemBackground
    }
    
    func setupView() {
        addSubview(settingImage)
        addSubview(label)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let size = contentView.height-2
        settingImage.frame = CGRect(
            x: contentView.width/2.7, //15,
            y: 10,
            width: contentView.height/2,
            height: contentView.height/2)
        
        settingImage.layer.cornerRadius = settingImage.height/4
        
        let labelHeight = contentView.height/2
        label.frame = CGRect(
            x: settingImage.right+15,
            y: 10,
            width: contentView.width-(size*2)-10,
            height: labelHeight)
    }
    
    public func configure(model: Setting) {
        ///let config = UIImage.SymbolConfiguration(pointSize: 25, weight: .semibold)
        ///let image = UIImage(systemName: model.imageName, withConfiguration: config)
        ///settingImage.image = image
        
        settingImage.image = UIImage(systemName: model.imageName)
        label.text = model.name
        
        //updateImage(index: 0)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
