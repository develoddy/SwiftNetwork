//
//  ProfileAdapter.swift
//  SwiftNetwork
//
//  Created by Eddy Donald Chinchay Lujan on 11/1/22.
//

import Foundation
import UIKit

// MARK: Adapter
class ProfileAdapter: NSObject {
    
    let delegate: ProfileProtocol
    
    let delegateHeader : ProfileReusableViewProtocol
    
    // MARK: Constructor
    init(delegate: ProfileProtocol, delegateHeader: ProfileReusableViewProtocol) {
        self.delegate = delegate
        self.delegateHeader = delegateHeader
    }
}


// MARK: Exetension TableView
extension ProfileAdapter: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return delegate.retrieveNumberOfSections()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 { return 0 }
        if section == 1 { return 0 }
        return delegate.retrieveNumberOfRowsInSection(section: section)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PhotoCollectionViewCell.identifier, for: indexPath) as? PhotoCollectionViewCell else {
            fatalError("PhotoCollectionViewCell -> cell not exists")
        }
        let model = delegate.getData(indexPath: indexPath)
        cell.configure(with: model)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return delegate.retrieveSizeForItemAt()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        delegate.retrieveInsetForSectionAt()
    }
    
    // MARK: Header & Story & Tabs
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        guard kind == UICollectionView.elementKindSectionHeader else {
            return UICollectionReusableView()
        }
        
        switch indexPath.section {
        case 0:
            let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind,
                                                                         withReuseIdentifier:ProfileInfoHeaderCollectionReusableView.identifier,
                                                                         for: indexPath) as! ProfileInfoHeaderCollectionReusableView
            guard let user = delegate.getUserData(indexPath: indexPath) else {
                return UICollectionReusableView()
            }
            header.configureProfile(with: user)
            header.delegate = delegateHeader
            return header
        case 1:
            let storyHeader = collectionView.dequeueReusableSupplementaryView(ofKind: kind,
                                                                              withReuseIdentifier: StoryFeaturedCollectionTableViewCell.identifier,
                                                                              for: indexPath) as! StoryFeaturedCollectionTableViewCell
            return storyHeader
        case 2:
            let tabsHeader = collectionView.dequeueReusableSupplementaryView(ofKind: kind,
                                                                             withReuseIdentifier: ProfileTabsCollectionReusableView.identifier,
                                                                             for: indexPath) as! ProfileTabsCollectionReusableView
            //tabsHeader.delegate = self
            return tabsHeader
        default:
            break
        }
        
        return UICollectionReusableView()
    }
    
    // MARK: Header & Story & Tabs
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        
        if section == 0 { return CGSize(width: collectionView.width, height: collectionView.height/2.5) }
        if section == 1 { return CGSize(width: collectionView.width, height: 90) }
        return CGSize(width: collectionView.width, height: 50)
    }
     
    // MARK: Item Selected
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        delegate.itemSelected(indexPath: indexPath)
    }
}
