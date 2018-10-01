//
//  AppDelegate.swift
//  goToWork
//
//  Created by 张博 on 2018/9/13.
//  Copyright © 2018年 Devin. All rights reserved.
//

import UIKit
import ESTabBarController_swift
@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        self.window?.rootViewController = tabbarWithNavigationStyle()
        UserDefaults.standard.set("oA5Pi5KB-UlTN4L9dk4TzkaMdecA", forKey: "user_id")
        window?.makeKeyAndVisible()
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
//
extension AppDelegate {
     func tabbarWithNavigationStyle() -> ESTabBarController {
        let tabBarController = ESTabBarController()
        let jobListViewController = JobListViewController()
        let scheduleListViewController = ScheduleListViewController()
        let rewardViewController = RewardViewController()
        let mineViewController = MineViewController()

        jobListViewController.tabBarItem = ESTabBarItem.init(ExampleBouncesContentView(),title: "职位", image: UIImage(named: "home_normal"), selectedImage: UIImage(named: "home_selected"))
        scheduleListViewController.tabBarItem = ESTabBarItem.init(ExampleBouncesContentView(),title: "日程", image: UIImage(named: "schedule_normal"), selectedImage: UIImage(named: "schedule_selected"))
        rewardViewController.tabBarItem = ESTabBarItem.init(ExampleBouncesContentView(),title: "收入", image: UIImage(named: "reward_normal"), selectedImage: UIImage(named: "reward_selected"))
        mineViewController.tabBarItem = ESTabBarItem.init(ExampleBouncesContentView(),title: "个人", image: UIImage(named: "mine_normal"), selectedImage: UIImage(named: "mine_selected"))
        
        let jobNav = BaseNavgationController.init(rootViewController: jobListViewController)
        let sceduleNav = BaseNavgationController.init(rootViewController: scheduleListViewController)
        let rewardNav = BaseNavgationController.init(rootViewController: rewardViewController)
        let mineNav = BaseNavgationController.init(rootViewController: mineViewController)
        
        jobListViewController.title = "职位"
        scheduleListViewController.title = "日程"
        rewardViewController.title = "收入"
        mineViewController.title = "个人"
        
        tabBarController.viewControllers = [jobNav, sceduleNav, rewardNav, mineNav]
        
        return tabBarController
    }
}

