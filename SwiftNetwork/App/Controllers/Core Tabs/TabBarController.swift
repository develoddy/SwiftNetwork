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
            title: "Online",
            selected: (UIImage(systemName: "house.fill")!),
            unselected: (UIImage(systemName: "house.fill")?.withTintColor(Constants.Color.blue))!)
        
        let explorer = generateNavController(
            vc: SearchViewController(), //ExplorerViewController(),
            title: "Explore",
            selected: UIImage(systemName: "binoculars.fill")!,
            unselected: (UIImage(systemName: "binoculars.fill")?.withTintColor(Constants.Color.blue))!)
       
        let notification = generateNavController(
            vc: NotificationsViewController(),
            title: "Notifications",
            selected: UIImage(systemName: "bell.fill")!,
            unselected: (UIImage(systemName: "bell.fill")?.withTintColor(Constants.Color.blue))! )
        
        let profile = generateNavController(
            vc: ProfileViewController(),
            title: "Profile",
            selected: (UIImage(systemName: "person.fill")!),
            unselected: (UIImage(systemName: "person.fill")?.withTintColor(Constants.Color.blue))!)
        
        let menu = generateNavController(
            vc: MenuViewController(),
            title: "Menu",
            selected: (UIImage(systemName: "line.horizontal.3.circle.fill")!), //text.justify
            unselected: (UIImage(systemName: "line.horizontal.3.circle.fill")?.withTintColor(Constants.Color.blue))!)
    
        viewControllers = [ profile, home, explorer, notification, menu ]
    
        colorNavController()
    }
    
    fileprivate func generateNavController(vc: UIViewController, title: String, selected: UIImage, unselected: UIImage) -> UINavigationController {
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
            print("explorer")
        case 2:
            print("notification")
        case 3:
            print("profile")
        default:
            break
        }
    }
    
    private func colorNavController() {
        guard let items = tabBar.items else { return }
        for item in items {
            item.imageInsets = UIEdgeInsets(top: 20, left: 10, bottom: 10, right: 10)
            let unselectedItem = [NSAttributedString.Key.foregroundColor: UIColor.secondaryLabel]
            let selectedItem = [NSAttributedString.Key.foregroundColor: Constants.Color.blue]
            item.setTitleTextAttributes(unselectedItem, for: .normal)
            item.setTitleTextAttributes(selectedItem, for: .selected)
        }
    }
}

