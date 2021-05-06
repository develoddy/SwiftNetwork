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
    
    override func layoutSubviews() {
        photoImageView.frame = contentView.bounds
    }
    
    override func prepareForReuse() {
        photoImageView.image = nil
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .secondarySystemBackground
        contentView.addSubview(photoImageView)
        contentView.clipsToBounds = true
        accessibilityLabel = ""
        accessibilityHint = "Double-tap to open post"
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func configure(with model: UserPost) {
        let url = model.thumbnailImage
        photoImageView.sd_setImage(with: url, completed: nil)
        
        
        /*let task = URLSession.shared.dataTask(with: url, completionHandler: { data, _, _ in
            self.photoImageView.image = UIImage(data: data!)
            
        })*/
    }
    
    //public func configure(debug imageName: /*String*/) {
      //  photoImageView.image = UIImage(named: imageName)
    //}
}

