//
//  ExploreViewController.swift
//  Blubinn
//
//  Created by Eddy Donald Chinchay Lujan on 13/4/21.
//

import UIKit

class ExplorerViewController: UIViewController {
    
    private let searchBar: UISearchBar = {
       let searchBar = UISearchBar()
        searchBar.backgroundColor =  .secondarySystemBackground
        return searchBar
    }()
    
    private var collectionView: UICollectionView?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        configureSearchBar()
    }
    
    private func setupView() {
        title = "Explore"
        view.backgroundColor = .systemBackground
    }
    
    private func configureSearchBar() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        navigationController?.navigationBar.topItem?.titleView = searchBar
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        
        collectionView?.delegate = self
        collectionView?.dataSource = self
        
        guard let collectionView = collectionView else {
            return
        }
        view.addSubview(collectionView)
    }
}


extension ExplorerViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
    }
    
}
