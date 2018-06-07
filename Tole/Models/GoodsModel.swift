//
//  GoodsModel.swift
//  Tole
//
//  Created by Almas on 02.04.18.
//  Copyright © 2018 Beknar Danabek. All rights reserved.
//

import Foundation
class GoodModel {
    let imageName: String?
    let goodsName: String?
    let price: String?
    let weight: String?
    
    init(imageName: String, goodsName: String, price: String, weight: String) {
        self.imageName = imageName
        self.goodsName = goodsName
        self.price = price
        self.weight = weight
    }
}
