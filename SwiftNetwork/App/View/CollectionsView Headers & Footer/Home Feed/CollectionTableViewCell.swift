//
//  CollectionTableViewCell.swift
//  SwiftNetwork
//
//  Created by Eddy Donald Chinchay Lujan on 25/4/21.
//

import UIKit

struct CollectionTableCellModel {
    let title: String
    let imageName: String
}

/// States of render cell
enum StoriesRenderType {
    case create(create: String)
    case stories(stories: [CollectionTableCellModel])
}

/// Model of  renderd Post
struct StoriesRenderViewModel {
    let renderType: StoriesRenderType
}





protocol CollectionTableViewCellDelegate: AnyObject {
    func didSelectItem(with model: CollectionTableCellModel)
}

class CollectionTableViewCell: UITableViewCell {
    
    public var delegate: CollectionTableViewCellDelegate?
    
    static let identifier = "CollectionTableViewCell"
    
    private var models = [CollectionTableCellModel]()
    private var renderModels = [StoriesRenderViewModel]()
    
    private let collectionView: UICollectionView
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 170, height: 170)
        layout.sectionInset = UIEdgeInsets(
            top     : 3,
            left    : 3,
            bottom  : 3,
            right   : 3)
        
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        collectionView.backgroundColor = .systemBackground 
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.showsVerticalScrollIndicator = false
    
        collectionView.register(TableCollectionViewCell.self, forCellWithReuseIdentifier: TableCollectionViewCell.identifier)
        collectionView.register(TableCreateStorieViewCell.self, forCellWithReuseIdentifier: TableCreateStorieViewCell.identifier)
        
        collectionView.delegate = self
        collectionView.dataSource = self
        contentView.addSubview(collectionView)
    }

    
    override func layoutSubviews() {
        super.layoutSubviews()
        collectionView.frame = contentView.bounds
    }
    
    public func configure(with models: [CollectionTableCellModel]) {
        self.models = models
        collectionView.reloadData()
        
//        guard let userPostModel = self.models else {
//            return
//        }
        
        renderModels.append(StoriesRenderViewModel(renderType: .create(create: "")))
        renderModels.append(StoriesRenderViewModel(renderType: .stories(stories: self.models)))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension CollectionTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return renderModels.count
    }
   
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        //return models.count
        switch renderModels[section].renderType {
        case .create(_): return 1
        case .stories(let stories): return stories.count > 0 ? stories.count : stories.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        /*let model = models[indexPath.row]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TableCollectionViewCell.identifier,
                                                      for: indexPath) as! TableCollectionViewCell
        cell.configure(with: model)
        return cell*/
        
        
        let model = renderModels[indexPath.section]
        switch model.renderType {
        case .create(_):
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TableCreateStorieViewCell.identifier, for: indexPath) as! TableCreateStorieViewCell
            return cell
        
        case .stories(let stories):
            let model = stories[indexPath.row]
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TableCollectionViewCell.identifier,
                                                          for: indexPath) as! TableCollectionViewCell
            cell.configure(with: model)
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let model = renderModels[indexPath.section]
        switch model.renderType {
        //case .actions(_): return 60 ///Actions
        case .create(_): return 50
        case .stories(_): return 50
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        ///return CGSize(width: collectionView.frame.width/2.9, height: collectionView.frame.width/1.4) //1.7
        return CGSize(width: collectionView.frame.width/3, height: collectionView.frame.width/1.7) //1.7
    }
        
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let model = models[indexPath.row]
        collectionView.deselectItem(at: indexPath, animated: true)
        delegate?.didSelectItem(with: model)
    }
}
