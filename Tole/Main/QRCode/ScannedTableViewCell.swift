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
     var cur = 0;
    lazy var productCard: ProductView = {
        let product = ProductView()
        product.translatesAutoresizingMaskIntoConstraints = false
        return product
    }()
    lazy var plusBtn: UIButton = {
        let btn = UIButton()
        btn.setImage(#imageLiteral(resourceName: "plus"), for: .normal)
        btn.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        btn.layer.borderWidth = 1
        btn.layer.cornerRadius = 3
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.addTarget(self, action: #selector(add), for: .touchUpInside )
        return btn
    }()
    lazy var minusBtn: UIButton = {
        let btn = UIButton()
        btn.setImage(#imageLiteral(resourceName: "minus"), for: .normal)
        btn.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        btn.layer.borderWidth = 1
        btn.layer.cornerRadius = 3
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.addTarget(self, action: #selector(drop), for: .touchUpInside )
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
    @objc func add(){
        cur = Int(productCard.pCount.text!)!
        self.productCard.pCount.text = String(cur + 1);
    }
    @objc func drop(){
        cur = Int(productCard.pCount.text!)!
        self.productCard.pCount.text = String(cur - 1);
    }
    
    func setupView(){
        self.contentView.addSubViews(views: [productCard,plusBtn,minusBtn])
        contentView.backgroundColor = .white
    }
    
    func setupConstraints(){
        constrain(productCard,plusBtn,minusBtn,contentView){ pc,plus,minus,cv in
            
            pc.width == cv.width * 0.8
            pc.height == cv.height
            pc.left == cv.left
            pc.centerY == cv.centerY
            
            plus.width == cv.width * 0.2
            plus.height == cv.height * 0.5
            plus.top == cv.top
            plus.left == pc.right
            
            minus.width == plus.width
            minus.height == plus.height
            minus.top == plus.bottom
            minus.left == pc.right
            
            
        }
    }

}
