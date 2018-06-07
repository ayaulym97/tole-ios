//
//  NotificationModel.swift
//  Tole
//
//  Created by Nurbek Ismagulov on 11.03.18.
//  Copyright © 2018 Beknar Danabek. All rights reserved.
//

import Foundation
import UIKit

class NotificationModel{
    private var leftLabel: String?
    private var rightLabel: String?
    
    static var arr: [NotificationModel] = [
        NotificationModel(leftLabel: "Coca-Cola", rightLabel: "Осталось 10л"),
        NotificationModel(leftLabel: "Био-С", rightLabel: "Нет"),
        NotificationModel(leftLabel: "Salted Caramel Square", rightLabel: "Осталось 5"),
        NotificationModel(leftLabel: "Red Berry Danish", rightLabel: "Нет"),
        NotificationModel(leftLabel: "Chocolate Croissant", rightLabel: "Осталось 9шт"),
        NotificationModel(leftLabel: "Omelette", rightLabel: "Осталось 8шт"),
        NotificationModel(leftLabel: "Morning Salad", rightLabel: "Нет"),
        NotificationModel(leftLabel: "Something", rightLabel: "Осталось 5шт")
    ]
    init(leftLabel: String, rightLabel: String) {
        self.leftLabel = leftLabel
        self.rightLabel = rightLabel
    }
    
    func getLeftLabel() -> String{
        return leftLabel!
    }
    func getRightLabel() -> String{
        return rightLabel!
    }
    
    
    //Later need to write here logic to differ which color UIView must be
}
