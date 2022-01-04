//
//  SettingsPost.swift
//  SwiftNetwork
//
//  Created by Eddy Donald Chinchay Lujan on 5/12/21.
//

import UIKit

class SettingsPost: NSObject {
    
    let tranparentView = UIView()
    private var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        var configuration = UICollectionLayoutListConfiguration(appearance: .grouped)
        configuration.showsSeparators = false
        collectionView.backgroundColor = .white
        collectionView.layer.cornerRadius = 20
        return collectionView
    }()
    
    let settings : [Setting] = {
        return [
            Setting(imageName: "trash.fill", name: "Delete"),
            Setting(imageName: "pencil", name: "Edit"),
            Setting(imageName: "square.and.arrow.up.fill", name: "Shared")
        ]
    }()
    
    var caption = ""
    
    //var model: Userpost?
    var model: CD0011_posts?
    
    var postController: PostViewController?
    
    let cellHeigth: CGFloat = 50
    
    let footerCollection : CGFloat = 120
    
    //MARK: Init
    override init() {
        super.init()
        collectionDelegates()
        collectionConfigure()
    }
    
    func collectionDelegates() {
        collectionView.dataSource = self
        collectionView.delegate = self
    }
    
    func collectionConfigure() {
        collectionView.register(CustomSharedHeaderCollectionViewCell.self,
                                forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                                withReuseIdentifier: CustomSharedHeaderCollectionViewCell.identifier)
        
        collectionView.register(CustomSharedCollectionViewCell.self,
                                forCellWithReuseIdentifier: CustomSharedCollectionViewCell.identifier)
        
        collectionView.register(CustomSharedFooterCollectionViewCell.self,
                                forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter,
                                withReuseIdentifier: CustomSharedFooterCollectionViewCell.identifier)
    }
    
    /// Settings
    //func showSettings(post: Userpost) {
    func showSettings(post: CD0011_posts) {
        let windows = UIApplication.shared.connectedScenes
                .filter({$0.activationState == .foregroundActive})
                .map({$0 as? UIWindowScene})
                .compactMap({$0})
                .first?.windows
                .filter({$0.isKeyWindow}).first
        tranparentView.backgroundColor = UIColor.black.withAlphaComponent(0.9)
        
        
        self.model = post
        
        
        guard let caption = model?.content else { return }
        self.caption = caption
        
        windows?.addSubview(tranparentView)
        windows?.addSubview(collectionView)
        
        let height: CGFloat = CGFloat(settings.count)*cellHeigth+footerCollection
        let y = windows!.frame.height - height
        collectionView.frame = CGRect(
            x: 0,
            y: windows!.frame.height,
            width: windows!.frame.width,
            height: height)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleDismiss))
        tranparentView.addGestureRecognizer(tapGesture)
        tranparentView.frame = windows!.frame
        tranparentView.alpha = 0.5
        
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            self.tranparentView.alpha = 0.5
            self.collectionView.frame = CGRect(
                x: 0,
                y: y,
                width: windows!.frame.width,
                height: height)
        }, completion: nil)
    }
    
    @objc func handleDismiss(index:Int, setting: Setting) {
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            self.tranparentView.alpha = 0
            let window = UIApplication.shared.connectedScenes
                    .filter({$0.activationState == .foregroundActive})
                    .map({$0 as? UIWindowScene})
                    .compactMap({$0})
                    .first?.windows
                    .filter({$0.isKeyWindow}).first
            
            self.collectionView.frame = CGRect(
                x: 0,
                y: window!.frame.height,
                width: self.collectionView.frame.width,
                height: self.collectionView.frame.height)
        }) { (complted: Bool) in
            print(index)
            if index != 4 || setting.name != "" || setting.name != "Cancel" {
                self.postController?.showControllerForSetting(index: index, setting: setting, post: self.model)
            }
        }
    }
    
    @objc func handleCancelDismiss() {
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            self.tranparentView.alpha = 0
            let window = UIApplication.shared.connectedScenes
                    .filter({$0.activationState == .foregroundActive})
                    .map({$0 as? UIWindowScene})
                    .compactMap({$0})
                    .first?.windows
                    .filter({$0.isKeyWindow}).first
            self.collectionView.frame = CGRect(
                x: 0,
                y: window!.frame.height,
                width: self.collectionView.frame.width,
                height: self.collectionView.frame.height)
        }) { (complted: Bool) in
        }
    }
}

//MARK: - COLLECTIONS
extension SettingsPost: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    ///Count optiones
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return settings.count
    }
    
    ///CollectionsViewCell Options
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let model = settings[indexPath.row]
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CustomSharedCollectionViewCell.identifier,
                                                                for: indexPath) as? CustomSharedCollectionViewCell else {
                fatalError("Unable to deque cell")
            }
            cell.configure(model: model)
            return cell
    }
    
    ///Widht & height cell
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: cellHeigth)
    }
    
    ///Spacin cell
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    ///Add Header & Footer
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard let cellFooter = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionFooter,
                                                                               withReuseIdentifier: CustomSharedFooterCollectionViewCell.identifier,
                                                                               for: indexPath) as? CustomSharedFooterCollectionViewCell else {
            fatalError("Unable to deque cell")
        }
        cellFooter.delegate = self
        return cellFooter
    }
    
    ///Footer height
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }

    ///Select Item cell
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let index = indexPath.item
        let setting = self.settings[indexPath.item]
        //guard let caption = self.model?.content else { return }
        //self.caption = caption
        
        handleDismiss(index: index, setting: setting)
    }
}

//MARK: - Extension
///Button cancel
extension SettingsPost: CustomSharedFooterCollectionViewCellDelegate {
    func didTapCancelButton() {
        self.handleCancelDismiss()
    }
}
