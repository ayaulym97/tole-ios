//
//  ProductTableViewCell.swift
//  Tole
//
//  Created by Ayaulym Alzhan on 13.06.2018.
//  Copyright © 2018 Ayaulym Alzhan. All rights reserved.
//

import UIKit
import Cartography
class ProductTableViewCell: UITableViewCell {
    let tapped : Bool = true
    lazy var productTitle : UILabel = {
        let l = UILabel()
        
        return l
    }()
    lazy var sum : UILabel = {
        let l = UILabel()
        
        return l
    }()
    lazy var star: UIButton = {
        let btn = UIButton()
        btn.setBackgroundImage(#imageLiteral(resourceName: "star"), for: .normal)
        btn.imageEdgeInsets = UIEdgeInsetsMake(10, 10, 10, 10)
        
    //    btn.addTarget(self, action: #selector(tap), for: .touchUpInside)
        return btn
    }()

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
        setupConstraints()
    }
    @objc func tap(){
       
//        tapped != tapped
//        tapped ? star.setBackgroundImage( #imageLiteral(resourceName: "star") , for: .normal) : star.setBackgroundImage( #imageLiteral(resourceName: "fillStar") , for: .normal)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView(){
        self.contentView.addSubViews(views: [productTitle,sum,star])
        star.setBackgroundImage(#imageLiteral(resourceName: "fillStar"), for: .normal)

    }
    
    func setupConstraints(){
        constrain(productTitle,sum,star,contentView){ pTitle,sum,star,cv in
            pTitle.centerY == cv.centerY
            pTitle.width == cv.width * 0.6
            pTitle.left == cv.left + 15
            
            sum.centerY == cv.centerY
            sum.width == cv.width * 0.1
            sum.left == pTitle.right + 5
            
            star.width == 30
            star.height == 30
            star.centerY == cv.centerY
            star.left == sum.right + 10
        }
    }

}
