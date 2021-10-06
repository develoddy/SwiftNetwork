//
//  CollectionStoryFeaturedTableViewCell.swift
//  SwiftNetwork
//
//  Created by Eddy Donald Chinchay Lujan on 28/9/21.
//

import UIKit



class CollectionStoryFeaturedTableViewCell: UICollectionViewCell /*UITableViewCell*/ {
    
    static let identifier = "CollectionStoryFeaturedTableViewCell"
    
    let cellId = "cellId"
    
    let collectionView: UICollectionView = {
       let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 30
        layout.scrollDirection = .horizontal
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        return cv
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
        collectionViewDelegates()
    }
    
    func setup() {
        backgroundColor = .red
        addSubview(collectionView)
        collectionView.register(IconCell.self, forCellWithReuseIdentifier: IconCell.identifier) 
        
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        // Layout constraints for collectionView
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.bottomAnchor),
            collectionView.leftAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.leftAnchor),
            collectionView.rightAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.rightAnchor)
        ])
    }
    
    func collectionViewDelegates() {
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension CollectionStoryFeaturedTableViewCell : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
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
