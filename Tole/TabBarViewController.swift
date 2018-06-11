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
        let qrCodeNav:UINavigationController?
        qrCodeNav = UINavigationController(rootViewController: ScannerVC())
       //let QRCodeViewController = ScannerVC()


//      qrCodeNav.viewControllers = [QRCodeViewController]
        qrCodeNav?.tabBarItem = UITabBarItem(title: "", image: #imageLiteral(resourceName: "qrcode"), tag: 1)
   //  QRCodeViewController.tabBarItem = UITabBarItem(title: "", image: #imageLiteral(resourceName: "qrcode"), tag: 1)
        let addViewController = AddAndSaleProductViewController()
        addViewController.tabBarItem = UITabBarItem(title: "", image: #imageLiteral(resourceName: "add"), tag: 2)
        let storageViewController = GoodsViewController()
        storageViewController.tabBarItem = UITabBarItem(title: "", image: #imageLiteral(resourceName: "storage"), tag: 3)
        let settingViewController = MyProfileViewController()
        settingViewController.tabBarItem = UITabBarItem(title: "", image: #imageLiteral(resourceName: "setting"), tag: 4)
        let viewControllerList = [ homeViewController,qrCodeNav, addViewController,storageViewController,settingViewController ]
        viewControllers = viewControllerList as? [UIViewController]
    }
    
  

 

}
