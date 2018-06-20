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
   
    lazy var productTitle: UILabel = {
        let label = UILabel(frame: .zero)
        label.font = UIFont.systemFont(ofSize: 18)
        label.textColor = #colorLiteral(red: 0.2901960784, green: 0.2901960784, blue: 0.2901960784, alpha: 1)
        label.text = ""
        return label
    }()

    
    lazy var price: UILabel = {
        let label = UILabel(frame: .zero)
        label.font = UIFont.systemFont(ofSize: 17)
        label.textColor = .lightGray
        label.text = ""
        return label
    }()
    
    lazy var pCount: UILabel = {
        let label = UILabel(frame: .zero)
        label.font = UIFont.systemFont(ofSize: 17)
        label.textColor = .lightGray
        label.text = ""
        label.textAlignment = .right
        return label
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
        self.contentView.addSubViews(views: [productTitle,price,pCount])
        contentView.backgroundColor = .white
    }
    
    func setupConstraints(){
        constrain(productTitle,price,pCount,contentView){ pt,price,count,cv in
            pt.top == cv.top + 5
            pt.width == cv.width * 0.8
            pt.height == cv.height * 0.5
            pt.left == cv.left + 5
            
            price.top == pt.bottom + 5
            price.width == pt.width * 0.5
            price.height == pt.height
            price.left == cv.left + 5
            
            count.top == pt.bottom + 5
            count.width == price.width
            count.height == price.height
            count.left == price.right
        }
    }

}
