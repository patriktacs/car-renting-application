//
//  AppDelegate.swift
//  CarRentingApplication
//
//  Created by Ács Patrik Tamás on 2019. 10. 13..
//  Copyright © 2019. Ács Patrik Tamás. All rights reserved.
//

import UIKit

///Dependency Injection
import Swinject
import SwinjectStoryboard

import NSObject_Rx

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    fileprivate let assemblies: [Assembly] = [InteractorAssembly(),
                                  NetworkAssembly(),
                                  ManagerAssembly(),
                                  ViewAssembly()]
    
    var container: Container = {
        let container = Container()
        return container
    }()


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions:
        [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        Container.loggingFunction = nil
        
        let assembler = Assembler.init(container: container)
        assembler.apply(assemblies: assemblies)
        
        SwinjectStoryboard.defaultContainer = container
        
        let sessionManager = container.resolve(SessioningManager.self)!
        
        if !sessionManager.sessionStatus {
            let loginStoryboard = UIStoryboard(name: "Login", bundle: nil)
            if let loginMainController = loginStoryboard.instantiateInitialViewController() {
                self.window?.rootViewController = loginMainController
            }
        } else {
            let dashboardStoryboard = UIStoryboard(name: "Dashboard", bundle: nil)
            if let dashboardMainController = dashboardStoryboard.instantiateInitialViewController() {
                self.window?.rootViewController = dashboardMainController
            }
        }
        
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


}

