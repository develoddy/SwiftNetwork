//
//  PhotosTableViewCell.swift
//  SwiftNetwork
//
//  Created by Eddy Donald Chinchay Lujan on 6/10/21.
//

import UIKit

protocol PhotosCollectionTableViewCellDelegate {
    func profileOpenDidTapPost( _header:  PhotosCollectionTableViewCell)
}


//MARK:  PhotosTableViewCell
class PhotosCollectionTableViewCell: UITableViewCell {
    
    static  let identifier = "PhotosTableViewCell"
    
    public var delegate: PhotosCollectionTableViewCellDelegate?
    
    let list = [String](repeating: "Task_", count: 7)
    
    public let label: UILabel = {
        let v = UILabel()
        v.textAlignment = .center
        return v
    }()
    
    public lazy var collectionView: UICollectionView = { [unowned self] in
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        let v = UICollectionView(frame: .zero, collectionViewLayout: layout)
        v.register(PhotosCollectionViewCell.self, forCellWithReuseIdentifier: PhotosCollectionViewCell.identifier)
        v.delegate = self
        v.dataSource = self
        v.isScrollEnabled = false
        return v
    }()

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .systemYellow
        collectionView.backgroundColor = .systemPurple
        commonInit()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    func commonInit() {
       contentView.addSubview(label)
       contentView.addSubview(collectionView)
       updateConstraints()
    }
    
    override func updateConstraints() {
        label.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: topAnchor),
            label.leadingAnchor.constraint(equalTo: leadingAnchor),
            label.trailingAnchor.constraint(equalTo: trailingAnchor)
            ])
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: label.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: bottomAnchor),
            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
            ])
        super.updateConstraints()
    }
    
    public func photos() -> CGFloat {
        return CGFloat(list.count)
    }
}


extension PhotosCollectionTableViewCell: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return list.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PhotosCollectionViewCell.identifier, for: indexPath) as! PhotosCollectionViewCell
        cell.label.text = "\(list[indexPath.item])\(indexPath.item+1)"
        cell.label.textAlignment = .center
        return cell
    }
}
extension PhotosCollectionTableViewCell: UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        
        print(indexPath.row)
        // get the model and open post controller
//        let model = userPostViewModel[indexPath.row]
//        let vc = PostViewController(model: model)
//        vc.navigationItem.largeTitleDisplayMode = .never
//        navigationController?.pushViewController(vc, animated: true)
//        vc.title = "Posts"
        ///model.postType.rawValue
        
        
    }
}

extension PhotosCollectionTableViewCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.width/3, height: 150)
    }
}
