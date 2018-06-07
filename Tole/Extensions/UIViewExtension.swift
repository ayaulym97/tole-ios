//
//  UIViewExtension.swift
//  Tole
//
//  Created by NURZHAN on 02.04.2018.
//  Copyright © 2018 Beknar Danabek. All rights reserved.
//

import UIKit

extension UIView {
    
    func addSubViews(views: [UIView]) {
        for view in views {
            self.addSubview(view)
        }
    }
    
}
