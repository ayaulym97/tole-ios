//
//  TabBarViewController.swift
//  Tole
//
//  Created by Ayaulym Alzhan on 02.06.2018.
//  Copyright © 2018 Ayaulym Alzhan. All rights reserved.
//

import UIKit
//MARK:main root
class TabBarViewController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        
        let homeViewController = HomeViewController()
        homeViewController.tabBarItem = UITabBarItem(title: "", image: #imageLiteral(resourceName: "home"), tag: 0)
        let nav1 = UINavigationController(rootViewController: homeViewController)
        
        let QRCodeViewController = ScannerVC()
        QRCodeViewController.tabBarItem = UITabBarItem(title: "", image: #imageLiteral(resourceName: "qrcode"), tag: 1)
        let nav2 = UINavigationController(rootViewController: QRCodeViewController)
        
        let addViewController = AddAndSaleProductViewController()
        addViewController.tabBarItem = UITabBarItem(title: "", image: #imageLiteral(resourceName: "add"), tag: 2)
        let nav3 = UINavigationController(rootViewController: addViewController)
        
        let storageViewController = StorageViewController()
        storageViewController.tabBarItem = UITabBarItem(title: "", image: #imageLiteral(resourceName: "storage"), tag: 3)
        let nav4 = UINavigationController(rootViewController: storageViewController)
        
        let settingViewController = MyProfileViewController()
        settingViewController.tabBarItem = UITabBarItem(title: "", image: #imageLiteral(resourceName: "setting"), tag: 4)
        let nav5 = UINavigationController(rootViewController: settingViewController)
        
        let viewControllerList = [ nav1,nav2,nav3,nav4,nav5]
        viewControllers = viewControllerList
    }
}
