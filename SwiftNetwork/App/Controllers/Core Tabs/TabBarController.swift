//
//  TabBarController.swift
//  SwiftNetwork
//
//  Created by Eddy Donald Chinchay Lujan on 14/4/21.
//

import UIKit


class TabBarController: UITabBarController, UITabBarControllerDelegate  {
    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
        
        UITabBar.appearance().barTintColor = .white
        UITabBar.appearance().backgroundColor = .systemBackground
        UITabBar.appearance().isTranslucent = false
       
        let home = generateNavController(
            vc: HomeViewController(),
            selected: (UIImage(systemName: "house")!),
            unselected: (UIImage(systemName: "house")?.withTintColor(Constants.Color.black))!)
        
        let profile = generateNavController(
            //vc: PruebaViewController(),
            vc: PruebaViewController(with: getUserToken()?.usertoken?.email ?? ""),
            selected: (UIImage(systemName: "person")!),
            unselected: (UIImage(systemName: "person")?.withTintColor(Constants.Color.black))!)
        
        let explorer = generateNavController(
            vc: SearchViewController(), //ExplorerViewController(),
//            title: "Explore",
            selected: UIImage(systemName: "magnifyingglass")!,
            unselected: (UIImage(systemName: "magnifyingglass")?.withTintColor(Constants.Color.black))!)
       
        let notification = generateNavController(
            vc: NotificationsViewController(),
//            title: "Notifications",
            selected: UIImage(systemName: "bell")!,
            unselected: (UIImage(systemName: "bell.fill")?.withTintColor(Constants.Color.black))! )
        
        /*let profile = generateNavController(
            vc: ProfileViewController(),
//            title: "Profile",
            selected: (UIImage(systemName: "person")!),
            unselected: (UIImage(systemName: "person")?.withTintColor(Constants.Color.black))!)*/
        
        /*let menu = generateNavController(
            vc: MenuViewController(),
            title: "Menu",
            selected: (UIImage(systemName: "line.horizontal.3.circle")!), //text.justify
            unselected: (UIImage(systemName: "line.horizontal.3.circle")?.withTintColor(Constants.Color.purple))!)*/
    
        //viewControllers = [ home, menu, profile, explorer, notification  ]
//        viewControllers = [ profile, home, explorer, notification ]
        viewControllers = [home, profile, explorer, notification ]
        colorNavController()
    }
    
    fileprivate func generateNavController(vc: UIViewController, /*title: String,*/ selected: UIImage, unselected: UIImage) -> UINavigationController {
        let navController = UINavigationController(rootViewController: vc)
        navController.tabBarItem.image = selected.withRenderingMode(.alwaysOriginal)
        navController.tabBarItem.selectedImage =  unselected.withRenderingMode(.alwaysOriginal)
        
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
            //item.imageInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
            item.imageInsets =  UIEdgeInsets(top: 20, left: 10, bottom: 20, right: 10)
            let unselectedItem = [NSAttributedString.Key.foregroundColor: UIColor.secondaryLabel]
            let selectedItem = [NSAttributedString.Key.foregroundColor: Constants.Color.whiteLight]
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

