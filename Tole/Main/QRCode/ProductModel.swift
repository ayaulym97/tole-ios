//
//  ProductModel.swift
//  Tole
//
//  Created by Ayaulym Alzhan on 07.06.2018.
//  Copyright © 2018 Ayaulym Alzhan. All rights reserved.
//

import Foundation
class ProductModel {
    let productTitle: String?
    let price: String?
    let count: String?
    
    
    init(productTitle: String,price: String, count: String) {

        self.productTitle = productTitle
        self.price = price
        self.count = count
    }
}
