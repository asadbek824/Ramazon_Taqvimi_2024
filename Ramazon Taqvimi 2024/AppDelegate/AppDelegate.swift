//
//  AppDelegate.swift
//  Ramazon Taqvimi 2024
//
//  Created by Asadbek Yoldoshev on 14/02/24.
//

import UIKit

@main
final class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        
        let mainView = UINavigationController(rootViewController: MainViewController())
        
        mainView.tabBarItem = UITabBarItem(
            title: "Nomoz vaqtlari",
            image: UIImage(named: "preyerTime"),
            tag: 1
        )
        
        let daysView = UINavigationController(rootViewController: DaysViewController())
        
        daysView.tabBarItem = UITabBarItem(
            title: "Taqvim",
            image: UIImage(named: "calendarIcon"),
            tag: 1
        )
        
        let duoView = UINavigationController(rootViewController: DuaViewController())
        
        duoView.tabBarItem = UITabBarItem(
            title: "Duolar",
            image: UIImage(named: "duoPicture"),
            tag: 1
        )
                
        let tabBarVC = UITabBarController()
        
        tabBarVC.viewControllers = [mainView, daysView, duoView]
        tabBarVC.selectedIndex = 0
        tabBarVC.tabBar.tintColor = .appColor.tabBarTintColor
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = tabBarVC
        window?.makeKeyAndVisible()
        window?.overrideUserInterfaceStyle = .light
        
        setUpTabBar()
        
        return true
    }
}

extension AppDelegate {
    
    private func setUpTabBar() {
        
        let tabBarApperance = UITabBarAppearance()
        
        tabBarApperance.configureWithOpaqueBackground()
        tabBarApperance.backgroundColor = .appColor.tabBarColor
        UITabBar.appearance().standardAppearance = tabBarApperance
        
        if #available(iOS 15.0, *) {
            UITabBar.appearance().scrollEdgeAppearance = tabBarApperance
        }
    }
}

