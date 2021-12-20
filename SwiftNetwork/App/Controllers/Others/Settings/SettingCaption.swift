//
//  SettingCaption.swift
//  SwiftNetwork
//
//  Created by Eddy Donald Chinchay Lujan on 5/12/21.
//

import UIKit

class SettingCaption: NSObject {
    
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

    var postController: PostViewController?
    
    //MARK: Init
    override init() {
        super.init()
        //collectionDelegates()
        //collectionConfigure()
    }
    
    /// Settings
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
        
        let cellHeigth: CGFloat = 50
        
        let height: CGFloat = CGFloat(settings.count)*cellHeigth
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
                //self.postController?.showControllerForSetting(index: index, setting: setting, post: <#T##Userpost?#>)
            }
        }
    }
    
}
