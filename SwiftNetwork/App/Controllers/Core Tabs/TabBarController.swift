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
        
        let time = generateNavController(vc: TimeLineViewController(), title: "Time")
        let home = generateNavController(vc: HomeViewController(), title: "Home")
        let explorer = generateNavController(vc: ExplorerViewController(), title: "Explore")
        let notification = generateNavController(vc: NotificationsViewController(), title: "Notif")
        let profile = generateNavController(vc: ProfileViewController(), title: "Profile")

        viewControllers = [ profile, time, home, explorer, notification ]
    }
    
    fileprivate func generateNavController(vc: UIViewController, title: String) -> UINavigationController/*UIViewController*/ {
        //vc.navigationItem.title = title
        let navController = UINavigationController(rootViewController: vc)
        navController.title = title
        return  navController
    }
    
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        let tabBarIndex = tabBarController.selectedIndex
        
        switch (tabBarIndex) {
        case 0:
            print("Home")
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
}

