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
    lazy var productImage : UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
        setupConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView(){
        self.contentView.addSubview(productImage)
        self.contentView.addSubview(productCard)
    }
    
    func setupConstraints(){
        constrain(productCard,productImage,contentView){ pc,im,cv in
            im.width == 78
            im.height == 78
            im.centerY == cv.centerY
            im.left == cv.left + 5
            
            pc.width == cv.width * 0.7
            pc.height == cv.height
            pc.left == im.right
            pc.centerY == cv.centerY
        }
    }

}
