//
//  StorageTableViewCell.swift
//  Tole
//
//  Created by Ayaulym Alzhan on 20.06.2018.
//  Copyright © 2018 Ayaulym Alzhan. All rights reserved.
//

import UIKit
import Cartography
class StorageTableViewCell: UITableViewCell {

    lazy var productCard: ProductView = {
        let product = ProductView()
        product.backgroundColor = .white
        product.translatesAutoresizingMaskIntoConstraints = false
        return product
    }()
    lazy var nextBtn: UIButton = {
        let btn = UIButton()
        btn.setImage(#imageLiteral(resourceName: "next"), for: .normal)
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
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
        self.contentView.addSubViews(views: [productCard,nextBtn])
        contentView.backgroundColor = .white
    }
    
    func setupConstraints(){
        constrain(productCard,nextBtn,contentView){ card,btn,cv in
            card.width == cv.width * 0.8
            card.height == cv.height
            card.top == cv.top
            card.centerY == cv.centerY
            
            btn.width == cv.width * 0.2
            btn.height == cv.height
            btn.top == cv.top
            btn.centerY == cv.centerY
            btn.left == card.right
        }
    }

}
