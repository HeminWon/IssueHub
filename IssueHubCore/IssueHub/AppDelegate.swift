//
//  AppDelegate.swift
//  IssueHub
//
//  Created by HeminWon on 2017/10/22.
//  Copyright © 2017年 HeminWon. All rights reserved.
//

import UIKit
import DrawerController

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var drawerController: DrawerController!

    func application(_ application: UIApplication, willFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey : Any]? = nil) -> Bool {
        let leftSideDrawerVC = LeftSideDrawerViewController()
        let centerVC = CenterViewController()
        
        let centerNaviController = UINavigationController(rootViewController: centerVC)
        centerNaviController.restorationIdentifier = "CenterNavigationControllerRestorationKey"
        
        let leftSideDrawerNaviController = UINavigationController(rootViewController: leftSideDrawerVC)
        leftSideDrawerNaviController.restorationIdentifier = "LeftNavigationControllerRestorationKey"
        
        self.drawerController = DrawerController(centerViewController:centerNaviController, leftDrawerViewController:leftSideDrawerNaviController)
        self.drawerController.showsShadows = false
        
        self.drawerController.restorationIdentifier = "Drawer"
        self.drawerController.maximumRightDrawerWidth = 200.0
        self.drawerController.openDrawerGestureModeMask = .all
        self.drawerController.closeDrawerGestureModeMask = .all
        
        self.drawerController.drawerVisualStateBlock = { (drawerController, drawerSide, fractionVisible) in
            let block = DrawerVisualStateManager.sharedManager.drawerVisualStateBlock(for: drawerSide)
            block?(drawerController, drawerSide, fractionVisible)
        }
        self.window = UIWindow(frame: UIScreen.main.bounds)
        let tintColor = UIColor(red: 29 / 255.0, green: 173 / 255.0, blue: 234 / 255.0, alpha: 1.0)
        self.window?.tintColor = tintColor
        
        self.window?.rootViewController = self.drawerController
        return true
    }

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        self.window?.backgroundColor = UIColor.white
        self.window?.makeKeyAndVisible()

        return true
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
    }

    func application(_ application: UIApplication, viewControllerWithRestorationIdentifierPath identifierComponents: [Any], coder: NSCoder) -> UIViewController? {
        if let key = identifierComponents.last as? String {
            if key == "Drawer" {
                return self.window?.rootViewController
            } else if key == "CenterNavigationControllerRestorationKey" {
                return (self.window?.rootViewController as! DrawerController).centerViewController
            } else if key == "RightNavigationControllerRestorationKey" {
                return (self.window?.rootViewController as! DrawerController).rightDrawerViewController
            } else if key == "LeftNavigationControllerRestorationKey" {
                return (self.window?.rootViewController as! DrawerController).leftDrawerViewController
            } else if key == "LeftSideDrawerController" {
                if let leftVC = (self.window?.rootViewController as? DrawerController)?.leftDrawerViewController {
                    if leftVC.isKind(of: UINavigationController.self) {
                        return (leftVC as! UINavigationController).topViewController
                    } else {
                        return leftVC
                    }
                }
            } else if key == "RightSideDrawerController" {
                if let rightVC = (self.window?.rootViewController as? DrawerController)?.rightDrawerViewController {
                    if rightVC.isKind(of: UINavigationController.self) {
                        return (rightVC as! UINavigationController).topViewController
                    } else {
                        return rightVC
                    }
                }
            }
        }
        
        return nil
    }
}

