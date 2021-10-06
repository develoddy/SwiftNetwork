//
//  TaggedCollectionViewCell.swift
//  SwiftNetwork
//
//  Created by Eddy Donald Chinchay Lujan on 18/5/21.
//

import UIKit

class TaggedCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "TaggedCollectionViewCell"
    
    let containerView = UIView(frame: CGRect(x:0,y:0,width:320,height:500))
    
    private let photoImageView: UIImageView = {
       let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.backgroundColor = .systemBlue
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        photoImageView.frame = contentView.bounds
    }
    
    private func setupView() {
        contentView.backgroundColor = .systemBlue
        contentView.layer.cornerRadius = 0
        contentView.layer.masksToBounds = true
        contentView.addSubview(photoImageView)
    }
    
    public func configure() {
        
    }
    
    override func prepareForReuse() {
        
    }
}
