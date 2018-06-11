//
//  ProductModel.swift
//  Tole
//
//  Created by Ayaulym Alzhan on 07.06.2018.
//  Copyright © 2018 Ayaulym Alzhan. All rights reserved.
//

import Foundation
class ProductModel {
   let image : String?
    let productTitle: String?
    let price: String?
    let count: String?
    
    
    init(image: String ,productTitle: String,price: String, count: String) {
        self.image = image
        self.productTitle = productTitle
        self.price = price
        self.count = count
    }
}
