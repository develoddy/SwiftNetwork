//
//  AppDelegate.swift
//  SwiftNetwork
//
//  Created by Eddy Donald Chinchay Lujan on 13/4/21.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    var objUsuarioSesion : ResponseTokenBE?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
<<<<<<< HEAD
    
    func applicationWillTerminate(_ application: UIApplication) {
        self.saveContext()
    }
    
    //MARK: Initialize a Persistent Container
    lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the sotore fail.
         */
        let container = NSPersistentContainer(name: "CoreData")
        container.loadPersistentStores { description, error in
            if let error = error as NSError? {
                //Replace this implementation with code to handle the error appropriately.
                //fatalError() causes the application to generate a crash log and terminate. You should not use this functions in a shipping aplication, although it may be useful during development.
                
                /*
                 Typical reason for an error here include:
                 * the parent directory does not exist, cannot be created, or disallow writing.
                 * The persistent store is not accesible, due to permissions or data protection when device is locked.
                 * The device is out of  space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                //fatalError("Unable to load persistent stores: \(error), \(error.userInfo)")
                fatalError("Unable to load persistent stores: \(error)")
            }
        }
        return container
    }()
    
    //MARK: Save Context
    func saveContext() {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this incompletion with to handle the error apropetistely.
                // fatalError() causes the aplication to generate a crash log mi terminate. you should not was this function in a shipping aplication alhough it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
=======


>>>>>>> parent of 684acd5... Post update caption
}
