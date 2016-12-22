//
//  AppDelegate.swift
//  LaunchDemo
//
//  Created by wzdg-whl on 16/11/29.
//  Copyright © 2016年 WHL. All rights reserved.
//

import UIKit
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        self.window = UIWindow.init(frame: UIScreen.main.bounds)
        self.window?.backgroundColor = UIColor.white
        UIApplication.shared.statusBarStyle = .lightContent
        let rootNVC = UINavigationController(rootViewController : ViewController())
        rootNVC.navigationBar.barTintColor = UIColor.black
        rootNVC.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName:UIColor.white]
        rootNVC.navigationBar.tintColor = UIColor.white
        
        //判断用户是不是第一次启动APP
        if !UserDefaults.standard.bool(forKey: "firstLaunch") {
            UserDefaults.standard.set(true, forKey: "firstLaunch")
            //新手导引
            let launch = LaunchViewController.init(mainVC: rootNVC, viewControllerType: LaunchViewControllerType.GreenhandLaunchViewController)
            launch.imageNameArray = ["新手指导1","新手指导2"]
            self.window?.rootViewController = launch
            self.window?.makeKeyAndVisible()
        }else{
//            广告=======
            let launch = LaunchViewController.init(mainVC: rootNVC, viewControllerType: LaunchViewControllerType.ADLaunchViewController)
            launch.setImageURL(imageURL: "http://pic.qiantucdn.com/58pic/17/80/57/94s58PICA7j_1024.jpg")
            launch.adURL = "http://www.jianshu.com/users/e39da354ce50/latest_articles"
            //GIF
            //        let launch = LaunchViewController.init(mainVC: ViewController(), viewControllerType: LaunchViewControllerType.GifBackgroundLaunchViewController)
            //        launch.gifImageName = "动图"
            //        launch.gifImageURL = ""
            //滚动图
            //        let launch = LaunchViewController.init(mainVC: ViewController(), viewControllerType: LaunchViewControllerType.RollImageLaunchViewController)
            //        launch.rollImageName = "滚动图片.jpeg"
            self.window?.rootViewController = launch
            self.window?.makeKeyAndVisible()
        }
        self.setup3DTouch(application: application)
        return true
    }
    @available(iOS 9.0, *)
    func application(_ application: UIApplication, performActionFor shortcutItem: UIApplicationShortcutItem, completionHandler: @escaping (Bool) -> Void) {
        let nvc = self.window?.rootViewController as! UINavigationController
        if shortcutItem.type == "ONE" {
            let VC = UIViewController()
            VC.title = "第一个"
            VC.view.backgroundColor = UIColor.red
            nvc.pushViewController(VC, animated: true)
        }else if shortcutItem.type == "TWO"{
            let VC = UIViewController()
            VC.title = "第二个"
            VC.view.backgroundColor = UIColor.green
            nvc.pushViewController(VC, animated: true)
        }
    }

    func setup3DTouch(application : UIApplication){
        if #available(iOS 9.0, *) {
            let camereIcon = UIApplicationShortcutIcon.init(type: .compose)
            let camereItem = UIApplicationShortcutItem.init(type: "ONE", localizedTitle: "拍照", localizedSubtitle: "", icon: camereIcon, userInfo: nil)
            let shareIcon = UIApplicationShortcutIcon.init(type: .share)
            let shareItem = UIApplicationShortcutItem.init(type: "TWo", localizedTitle: "分享", localizedSubtitle: "", icon: shareIcon, userInfo: nil)
            application.shortcutItems = [camereItem,shareItem]
        }
    }
    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
        // Saves changes in the application's managed object context before the application terminates.
//        self.saveContext()
    }

    // MARK: - Core Data stack

    @available(iOS 10.0, *)
    lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
        */
        let container = NSPersistentContainer(name: "LaunchDemo")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                 
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    // MARK: - Core Data Saving support

//    func saveContext () {
//        if #available(iOS 10.0, *) {
//            let context = persistentContainer.viewContext
//        } else {
//            // Fallback on earlier versions
//        }
//        if context.hasChanges {
//            do {
//                try context.save()
//            } catch {
//                // Replace this implementation with code to handle the error appropriately.
//                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
//                let nserror = error as NSError
//                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
//            }
//        }
//    }

}

