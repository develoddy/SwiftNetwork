//
//  TableStoryFeaturedViewCell.swift
//  SwiftNetwork
//
//  Created by Eddy Donald Chinchay Lujan on 28/9/21.
//

import UIKit



class TableStoryFeaturedViewCell: UICollectionViewCell {
    
    public static let identifier = "TableStoryFeaturedViewCell"
    
    let collectionView: UICollectionView = {
       let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 30
        layout.scrollDirection = .horizontal
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = .clear
        return cv
    }()
   
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
        collectionViewDelegates()
        backgroundColor = .systemGreen
    }
    
    func setup() {
        backgroundColor = .gray
        
        collectionView.register(IconCell.self, forCellWithReuseIdentifier: IconCell.identifier)
//        collectionView.showsHorizontalScrollIndicator = false
//        collectionView.showsVerticalScrollIndicator = false
        
        //collectionView.setAnchor(top: .topAnchor, left: .leftAnchor, bottom: .bottomAnchor, right: .righAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom:0, paddingRight: 0)
        
//        collectionView.translatesAutoresizingMaskIntoConstraints = false
//        let constraints = [
//            collectionView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 0),
//            collectionView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 0),
//            collectionView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 0),
//            collectionView.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: 0)
//        ]
//        NSLayoutConstraint.activate(constraints)
        
        addSubview(collectionView)
    }
    
    func collectionViewDelegates() {
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        collectionView.frame = contentView.bounds
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    public func configure() {
    }
}

extension TableStoryFeaturedViewCell : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: IconCell.identifier, for: indexPath) as! IconCell
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 200, height: frame.height - 20)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 14, bottom: 0, right: 14)
    }
    
    private class IconCell: UICollectionViewCell {
        static let identifier = "IconCell"
        override init(frame: CGRect) {
            super.init(frame: frame)
            backgroundColor = .systemBlue
        }
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
    }
}
