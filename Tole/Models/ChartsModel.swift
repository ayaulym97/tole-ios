//
//  ChartsModel.swift
//  Tole
//
//  Created by Ayaulym Alzhan on 06.06.2018.
//  Copyright © 2018 Beknar Danabek. All rights reserved.
//

import Foundation
class ChartsModel{
    
    let sale: Int? // продажа
    let sold: Int? //продано
    let profit: Int? //прибыль
    let goods: Int? // товары в обороте
    
    init(sale: Int, sold: Int,profit:Int, goods:Int) {
        self.sale = sale
        self.sold = sold
        self.profit = profit
        self.goods = goods
    }
}
