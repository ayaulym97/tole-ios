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
//        self.navigationItem.hidesBackButton = true;
        view.backgroundColor = UIColor.white
        setupTabBar()
        
    }
    func setupTabBar() {
        let HomeVC = createNavController(vc: HomeViewController(), unselected: #imageLiteral(resourceName: "home"), tag: 0)
        let QRCodeVC = createNavController(vc: ScannerVC(), unselected: #imageLiteral(resourceName: "qrcode"), tag: 1)
        let AddVC = createNavController(vc: AddAndSaleProductViewController(), unselected: #imageLiteral(resourceName: "add"), tag: 2)
        let StorageVC = createNavController(vc: StorageViewController(), unselected: #imageLiteral(resourceName: "storage"), tag: 3)
        let SettingsVC = createNavController(vc: MyProfileViewController(), unselected: #imageLiteral(resourceName: "setting"), tag: 4)
        
        viewControllers = [HomeVC,QRCodeVC,AddVC,StorageVC,SettingsVC]
        guard let items = tabBar.items else { return }
        
        for item in items {
            item.imageInsets = UIEdgeInsetsMake(4, 0, -4, 0)
        }
    }
}
extension UITabBarController {
    
    func createNavController(vc: UIViewController, unselected: UIImage, tag: Int) -> UINavigationController {
        let viewController = vc
        let navController = UINavigationController(rootViewController: viewController)
        navController.tabBarItem.image = unselected
        navController.tabBarItem.tag = tag
        return navController
    }
}
