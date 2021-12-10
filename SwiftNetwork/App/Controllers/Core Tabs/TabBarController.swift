//
//  TabBarController.swift
//  SwiftNetwork
//
//  Created by Eddy Donald Chinchay Lujan on 14/4/21.
//

import UIKit

//MARK: TabBarController
class TabBarController: UITabBarController, UITabBarControllerDelegate  {
    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
        
        UITabBar.appearance().barTintColor = .white
        UITabBar.appearance().backgroundColor = .systemBackground
        UITabBar.appearance().isTranslucent = false
       
        let home = generateNavController(vc: HomeViewController(),selected: (UIImage(systemName: "house")!),
                                         unselected: (UIImage(systemName: "house")?.withTintColor(Constants.Color.black))!)
        
        let profile = generateNavController(vc: PruebaViewController(with: getUserToken()?.usertoken?.email ?? ""),
                                            selected: (UIImage(systemName: "person")!),
                                            unselected: (UIImage(systemName: "person")?.withTintColor(Constants.Color.black))!)
        
        let explorer = generateNavController(vc: SearchViewController(),
                                             selected: UIImage(systemName: "magnifyingglass")!,
                                             unselected: (UIImage(systemName: "magnifyingglass")?.withTintColor(Constants.Color.black))!)
       
        let notification = generateNavController(vc: NotificationsViewController(),
                                                 selected: UIImage(systemName: "bell")!,
                                                 unselected: (UIImage(systemName: "bell.fill")?.withTintColor(Constants.Color.black))! )
        
        viewControllers = [profile      ,
                           home         ,
                           explorer     ,
                           notification ]
        colorNavController()
    }
    
    fileprivate func generateNavController(vc: UIViewController, selected: UIImage, unselected: UIImage) -> UINavigationController {
        let navController                       = UINavigationController(rootViewController: vc)
        navController.tabBarItem.image          = selected.withRenderingMode(.alwaysOriginal)
        navController.tabBarItem.selectedImage  =  unselected.withRenderingMode(.alwaysOriginal)
        navController.title = title
        return  navController
    }
    
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        let tabBarIndex = tabBarController.selectedIndex
        switch (tabBarIndex) {
        case 0:
            print("Online")
        case 1:
            print("profile")
        case 2:
            print("notification")
        case 3:
            print("explorer")
        default:
            break
        }
    }
    
    private func colorNavController() {
        guard let items = tabBar.items else { return }
        for item in items {
            item.imageInsets    =  UIEdgeInsets(top: 20, left: 10, bottom: 20, right: 10)
            let unselectedItem  = [NSAttributedString.Key.foregroundColor: UIColor.secondaryLabel]
            let selectedItem    = [NSAttributedString.Key.foregroundColor: Constants.Color.whiteLight]
            item.setTitleTextAttributes(unselectedItem, for: .normal)
            item.setTitleTextAttributes(selectedItem, for: .selected)
        }
    }
    
    public func getUserToken() -> ResponseTokenBE? {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        guard let token = appDelegate.objUsuarioSesion else {
            return getUserToken()
        }
        return token
    }
}
