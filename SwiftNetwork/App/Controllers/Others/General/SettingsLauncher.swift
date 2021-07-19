//
//  SettingsLauncher.swift
//  SwiftNetwork
//
//  Created by Eddy Donald Chinchay Lujan on 9/7/21.
//

import UIKit

class Setting: NSObject {
    let imageName: String
    let name: String
    
    init(imageName: String, name: String) {
        self.imageName = imageName
        self.name = name
    }
}

///SettingLauncher
class SettingsLauncher: NSObject {
    
    var homeController: HomeViewController?
    
    let tranparentView = UIView()
    //let heigth: CGFloat = 250
    private var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .white
        collectionView.layer.cornerRadius = 20
        return collectionView
    }()
    
    let cellHeigth: CGFloat = 50
    let headerCollection : CGFloat = 400 //300
    
    let settings : [Setting] = {
        return [
            Setting(imageName: "circle.dashed", name: "Share in your story"),
            Setting(imageName: "paperplane.circle", name: "Send by messenger"),
            Setting(imageName: "gearshape", name: "Settings"),
            Setting(imageName: "ellipsis.circle", name: "More options"),
            Setting(imageName: "bookmark.circle", name: "Save element")
        ]
    }()
    
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
        collectionView.register(CustomSharedHeaderCollectionViewCell.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: CustomSharedHeaderCollectionViewCell.identifier)
        collectionView.register(CustomSharedCollectionViewCell.self, forCellWithReuseIdentifier: CustomSharedCollectionViewCell.identifier)
        collectionView.register(CustomSharedFooterCollectionViewCell.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: CustomSharedFooterCollectionViewCell.identifier)
    }

    func showSettings() {
        let windows = UIApplication.shared.connectedScenes
                .filter({$0.activationState == .foregroundActive})
                .map({$0 as? UIWindowScene})
                .compactMap({$0})
                .first?.windows
                .filter({$0.isKeyWindow}).first
        tranparentView.backgroundColor = UIColor.black.withAlphaComponent(0.9)
        
        windows?.addSubview(tranparentView)
        windows?.addSubview(collectionView)
        
        let height: CGFloat = CGFloat(settings.count)*cellHeigth+headerCollection  //400
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
                self.homeController?.showControllerForSetting(index: index, setting: setting)
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
extension SettingsLauncher: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    ///Count optiones
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return settings.count
    }
    
    ///CollectionsViewCell Options
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let model = settings[indexPath.row]
            guard let cell = collectionView.dequeueReusableCell(
                    withReuseIdentifier: CustomSharedCollectionViewCell.identifier,
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
        if kind == UICollectionView.elementKindSectionFooter {
            guard let cellFooter = collectionView.dequeueReusableSupplementaryView(
                    ofKind: UICollectionView.elementKindSectionFooter,
                    withReuseIdentifier: CustomSharedFooterCollectionViewCell.identifier,
                    for: indexPath) as? CustomSharedFooterCollectionViewCell else {
               fatalError("Unable to deque cell")
            }
            cellFooter.delegate = self
            return cellFooter
        }
        
        guard let cellHeader = collectionView.dequeueReusableSupplementaryView(
                ofKind: UICollectionView.elementKindSectionHeader,
                withReuseIdentifier: CustomSharedHeaderCollectionViewCell.identifier,
                for: indexPath) as? CustomSharedHeaderCollectionViewCell else {
            fatalError("Unable to deque cell")
         }
        let border = UIView(frame: CGRect(x: 0, y: collectionView.height/2.7, width: collectionView.bounds.width, height: 1))
        border.backgroundColor = .systemGray4
        cellHeader.addSubview(border)
         return cellHeader
    }
    
    ///Header height
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.width, height: collectionView.height/2.4-CGFloat(settings.count))  //collectionView.height/3 collectionView.height
    }
    
    ///Footer height
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height/5)
    }

    ///Select Item cell
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let index = indexPath.item
        let setting = self.settings[indexPath.item]
        handleDismiss(index: index, setting: setting)
    }
}


//MARK: - EXTENSION
///Button cancel
extension SettingsLauncher: CustomSharedFooterCollectionViewCellDelegate {
    func didTapCancelButton() {
        self.handleCancelDismiss()
    }
}
