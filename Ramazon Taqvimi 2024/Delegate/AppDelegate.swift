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
        
        let profileVC = UINavigationController(
            rootViewController: DuaViewController())
        
        profileVC.tabBarItem = UITabBarItem(
            title: "Sozlamalar", image: UIImage(named: "mechet"), tag: 2
        )
        
        let tabBarVC = UITabBarController()
        tabBarVC.viewControllers = [profileVC]
  
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = tabBarVC
        window?.backgroundColor = .white
        window?.makeKeyAndVisible()
        
        setTabBarAppearance()
        setNavigationBarAppearance()
        return true
    }
    
    private func setTabBarAppearance() {
        let appearance = UITabBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .appColor.primary
        
        UITabBar.appearance().standardAppearance = appearance
        if #available(iOS 15.0, *) {
            UITabBar.appearance().scrollEdgeAppearance = appearance
        }
    }
    
    private func setNavigationBarAppearance() {
        let navigationBarAppearance = UINavigationBarAppearance()
        navigationBarAppearance.configureWithOpaqueBackground()
        navigationBarAppearance.backgroundColor = .appColor.primary

        UINavigationBar.appearance().scrollEdgeAppearance = navigationBarAppearance
    }
}
