//
//  PhotoCollectionViewCell.swift
//  SwiftNetwork
//
//  Created by Eddy Donald Chinchay Lujan on 15/4/21.
//

import SDWebImage
import UIKit

class PhotoCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "PhotoCollectionViewCell"
    
    let containerView = UIView(frame: CGRect(x:0,y:0,width:320,height:500))
    
    private let photoImageView: UIImageView = {
       let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let label: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.text = "Name"
        label.font = .systemFont(ofSize: 22, weight: .semibold)
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
        contentView.backgroundColor = .secondarySystemBackground
        contentView.layer.cornerRadius = 8
        contentView.layer.masksToBounds = true
        
        contentView.addSubview(photoImageView)
        contentView.addSubview(label)
        //contentView.clipsToBounds = true
        accessibilityLabel = ""
        accessibilityHint = "Double-tap to open post"
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        photoImageView.frame = contentView.bounds
        label.frame = CGRect(x: 10, y: contentView.height/2, width: contentView.width-20, height: contentView.height/2)
    }
    
    override func prepareForReuse() {
        photoImageView.image = nil
        label.text = nil
    }
    
    public func configure(with model: UserPost) {
        let url = model.thumbnailImage
        photoImageView.sd_setImage(with: url, completed: nil)
        
        contentView.backgroundColor = colors.randomElement()
        /*let task = URLSession.shared.dataTask(with: url, completionHandler: { data, _, _ in
            self.photoImageView.image = UIImage(data: data!)
            
        })*/
    }
    
    //public func configure(debug imageName: /*String*/) {
      //  photoImageView.image = UIImage(named: imageName)
    //}
}

