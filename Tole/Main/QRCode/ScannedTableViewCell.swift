//
//  ScannedTableViewCell.swift
//  Tole
//
//  Created by Ayaulym Alzhan on 08.06.2018.
//  Copyright © 2018 Ayaulym Alzhan. All rights reserved.
//

import UIKit
import Cartography
class ScannedTableViewCell: UITableViewCell {
    lazy var productCard: ProductView = {
        let product = ProductView()
        product.translatesAutoresizingMaskIntoConstraints = false
        return product
    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
        setupConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView(){
        self.contentView.addSubview(productCard)
        contentView.backgroundColor = .white
    }
    
    func setupConstraints(){
        constrain(productCard,contentView){ pc,cv in
            
            pc.width == cv.width
            pc.height == cv.height
            pc.centerX == cv.centerX
            pc.centerY == cv.centerY
        }
    }

}
