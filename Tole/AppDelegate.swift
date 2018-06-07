//
//  AppDelegate.swift
//  Tole
//
//  Created by Ayaulym Alzhan on 01/04/2018.
//  Copyright © 2018 Ayaulym Alzhan. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        setupWindow()
        return true
    }
    
    func setupWindow() {
        let navigationController:UINavigationController?
        let launchedBefore = UserDefaults.standard.bool(forKey: "launchedBefore")
        if launchedBefore  {
            print("Not first launch.")
            navigationController = UINavigationController(rootViewController: LoginViewController())
        } else {
            print("First launch, setting UserDefault.")
            UserDefaults.standard.set(true, forKey: "launchedBefore")
            navigationController = UINavigationController(rootViewController: TutorialCollectionViewController())
        }
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = navigationController
        window?.backgroundColor = .white
        UINavigationBar.appearance().layer.borderWidth = 2
        UINavigationBar.appearance().layer.borderColor = UIColor.black.cgColor
        UINavigationBar.appearance().backgroundColor = .white
        
        window?.makeKeyAndVisible()
    }



}

