//
//  AppDelegate.swift
//  Viewer
//
//  Created by Dario Suarez on 13/06/2019.
//  Copyright © 2019 Dario Suarez. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        setupUI()
        
        return true
    }
    
    func setupUI() {
        window = UIWindow(frame: UIScreen.main.bounds)
        let searchVC = UIStoryboard(name: "SearchVC", bundle: nil).instantiateInitialViewController()
        let navigationVC = UINavigationController(rootViewController: searchVC!)
        window?.rootViewController = navigationVC
        window?.makeKeyAndVisible()
    }

}

