//
//  AppDelegate.swift
//  TT2_IOS
//
//  Created by KaiHao  on 2019/5/20.
//  Copyright © 2019 NTUST. All rights reserved.
//

import UIKit

extension UIColor {
    convenience init(red: Int, green: Int, blue: Int) {
        assert(red >= 0 && red <= 255, "Invalid red component")
        assert(green >= 0 && green <= 255, "Invalid green component")
        assert(blue >= 0 && blue <= 255, "Invalid blue component")
        
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
    }
    
    convenience init(rgb: Int) {
        self.init(
            red: (rgb >> 16) & 0xFF,
            green: (rgb >> 8) & 0xFF,
            blue: rgb & 0xFF
        )
    }
}

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        // UITabBar
        // UITabBar.appearance().tintColor = UIColor(rgb: 0x00C800) // 圖示 的顏色
        UITabBar.appearance().tintColor = UIColor.white // 圖示 的顏色
        UITabBar.appearance().barTintColor = UIColor.black // Bar 的顏色
        
        
        // Helper.plist
        let fm = FileManager.default
        // 取得 Helper.plist 在專案中的路徑
        let src = Bundle.main.path(forResource: "Helper", ofType: "plist")
        // 取得要複製到的目的路徑
        let dst = NSHomeDirectory() + "/Documents/Helper.plist"
        // 檢查目的路徑的 Property List.plist 檔案是否已經存在，如果不存在則複製檔案
        if !fm.fileExists(atPath: dst) {
            try! fm.copyItem(atPath: src!, toPath: dst)
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

