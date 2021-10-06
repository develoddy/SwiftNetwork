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
    //case create(create: String)
    case create(create: [CollectionTableCellModel])
    case stories(stories: [CollectionTableCellModel])
}

/// Model of  renderd Post
struct StoriesRenderViewModel {
    let renderType: StoriesRenderType
}

protocol CollectionTableViewCellDelegate: AnyObject {
    func didSelectItem(with model: CollectionTableCellModel, type: String)
    func didPushUpStoryButton()
}

class CollectionTableViewCell: UITableViewCell {
    
    public var delegate: CollectionTableViewCellDelegate?
    
    static let identifier = "CollectionTableViewCell"
    
    private var models = [CollectionTableCellModel]()
    
    private var story = [CollectionTableCellModel]()
    
    private var renderModels = [StoriesRenderViewModel]()
    
    private let collectionView: UICollectionView
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Stories"
        label.font = .systemFont(ofSize: 22, weight: .bold)
        label.tintColor = .black
        return label
    }()
    
    private let arrowUpImageButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "arrow.up.left.and.down.right.and.arrow.up.right.and.down.left"), for: .normal)
        button.contentMode = .scaleAspectFit
        button.contentHorizontalAlignment = .right
        button.semanticContentAttribute = .forceRightToLeft
        button.tintColor = .black
        return button
    }()
    
    
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
//        collectionView.showsHorizontalScrollIndicator = false
//        collectionView.showsVerticalScrollIndicator = false
    
        collectionView.register(TableCollectionViewCell.self, forCellWithReuseIdentifier: TableCollectionViewCell.identifier)
        collectionView.register(TableCreateStorieViewCell.self, forCellWithReuseIdentifier: TableCreateStorieViewCell.identifier)
        
        collectionView.delegate = self
        collectionView.dataSource = self
        contentView.addSubview(collectionView)
        
        setupView()
    }
    
    func setupView() {
        addSubview(titleLabel)
        addSubview(arrowUpImageButton)
        arrowUpImageButton.addTarget(self, action: #selector(didPushUpStoryButton), for: .touchUpInside)
    }
    
    @objc private func didPushUpStoryButton() {
        delegate?.didPushUpStoryButton()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        collectionView.frame = contentView.bounds
        
        let buttonWidth = collectionView.width > 500 ? 320.0 : collectionView.width/4
        
        titleLabel.frame = CGRect(
            x: 10,
            y: 5,
            width: collectionView.width-8-buttonWidth,
            height: 30)
        
        //arrowUpImageButton.backgroundColor = .systemBackground
        arrowUpImageButton.frame = CGRect(
            x: titleLabel.right,
             y: 5,
             width: buttonWidth-20,
             height: 30)
    }
    
    public func configure(with models: [CollectionTableCellModel], with story: [CollectionTableCellModel] ) {
        self.models = models
        self.story = story
        collectionView.reloadData()
        
//        guard let userPostModel = self.models else {
//            return
//        }
        
        renderModels.append(StoriesRenderViewModel(renderType: .create(create: self.story)))
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
        let model = renderModels[indexPath.section]
        switch model.renderType {
        case .create(let create):
            let story = create[indexPath.row]
                let cell = collectionView.dequeueReusableCell(
                    withReuseIdentifier: TableCreateStorieViewCell.identifier,
                    for: indexPath) as! TableCreateStorieViewCell
                cell.configure(with: story)
                return cell
            
            case .stories(let stories):
                let model = stories[indexPath.row]
                let cell = collectionView.dequeueReusableCell(
                    withReuseIdentifier: TableCollectionViewCell.identifier,
                    for: indexPath) as! TableCollectionViewCell
                cell.configure(with: model)
                return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width/3.2, height: collectionView.frame.width/2) //1.7
    }
        
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        /**let model = models[indexPath.row]
        print(indexPath.item)
        print(model)
        collectionView.deselectItem(at: indexPath, animated: true)
        delegate?.didSelectItem(with: model)*/
        
        let model = renderModels[indexPath.section]
        switch model.renderType {
        case .create(let create):
            print(indexPath.item)
            let model = create[indexPath.row]
            collectionView.deselectItem(at: indexPath, animated: true)
            delegate?.didSelectItem(with: model, type: Constants.storyCollections.createStory)
        case .stories(let stories):
            print(indexPath.item)
            let model = stories[indexPath.row]
            collectionView.deselectItem(at: indexPath, animated: true)
            delegate?.didSelectItem(with: model, type: Constants.storyCollections.collections)
        }
    }
}
