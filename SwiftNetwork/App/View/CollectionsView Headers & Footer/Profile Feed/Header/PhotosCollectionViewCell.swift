//
//  PhotosCollectionViewCell.swift
//  SwiftNetwork
//
//  Created by Eddy Donald Chinchay Lujan on 6/10/21.
//

import UIKit

//MARK: - CollectionCell
class PhotosCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "CollectionCell"
    
    private let photoImageView: UIImageView = {
       let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.backgroundColor = .systemBlue
        return imageView
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
    
    let padding: CGFloat = 1
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    func commonInit() {
        backgroundColor = .systemBackground
        contentView.addSubview(photoImageView)
        contentView.addSubview(label)
        updateConstraints()
    }

    override func updateConstraints() {
        label.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: topAnchor, constant: padding),
            label.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding),
            label.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding),
            label.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -padding)
        ])
        super.updateConstraints()
    }

    public let label: UILabel = {
        let v = UILabel()
        v.textColor = .darkText
        v.minimumScaleFactor = 0.5
        v.numberOfLines = 1
        return v
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        photoImageView.frame = contentView.bounds
        photoImageView.frame = CGRect(x: 1, y: 1, width: contentView.width-2, height: contentView.height)
        label.frame = CGRect(x: 10, y: contentView.height/2, width: contentView.width-20, height: contentView.height/1.5)
    }
    
    public func configure(with model: UserPostViewModel) {
        ///let url = model.thumbnailImage
        ///photoImageView.sd_setImage(with: url, completed: nil)
        ///contentView.backgroundColor = colors.randomElement()
    }
}
