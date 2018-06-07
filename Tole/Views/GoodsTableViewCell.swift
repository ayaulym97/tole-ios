//
//  GoodsTableViewCell.swift
//  Tole
//
//  Created by Almas on 03.04.18.
//  Copyright © 2018 Beknar Danabek. All rights reserved.
//

import UIKit
import Cartography
class GoodsTableViewCell: UITableViewCell {

    lazy var goodsImage: UIImageView = {
        let image = UIImageView(frame: .zero)
        image.contentMode = .scaleToFill
        return image
    }()
    
    lazy var goodsNameLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.font = UIFont.systemFont(ofSize: 21)
        label.textColor = .black
        return label
    }()
    
    lazy var priceLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.font = UIFont.systemFont(ofSize: 18)
        label.textColor = .lightGray
        return label
    }()

    lazy var weightLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.font = UIFont.systemFont(ofSize: 18)
        label.textColor = .lightGray
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
        self.contentView.addSubview(goodsImage)
        self.contentView.addSubview(goodsNameLabel)
        self.contentView.addSubview(priceLabel)
        self.contentView.addSubview(weightLabel)
    }
    
    func setupConstraints(){
        constrain(goodsNameLabel, priceLabel, weightLabel, goodsImage, contentView){ gl,pl,wl,gi,cv in
            gi.width == 78
            gi.height == 78
            gi.left == cv.left + 10
            gi.top == cv.top + 10
            gi.top == cv.top + 10
            
            gl.left == gi.right + 20
            gl.top == cv.top + 10
    
            pl.left == gi.right + 20
            pl.bottom == cv.bottom - 20
            wl.right == cv.right - 20
            wl.bottom == cv.bottom - 20
        }
    }
}
