//
//  StorageButton.swift
//  Tole
//
//  Created by Ayaulym Alzhan on 21.06.2018.
//  Copyright © 2018 Ayaulym Alzhan. All rights reserved.
//

import UIKit
import Cartography
class StorageButton: UIView {
    lazy var upLabel:UILabel = {
        let l = UILabel()
        l.textColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
         l.font = UIFont.init(name: "Arial", size: 10)
        l.textAlignment = .center
        return l
    }()
    lazy var numLabel:UILabel = {
        let l = UILabel()
        l.textColor = #colorLiteral(red: 0.4823529412, green: 0.09019607843, blue: 0.09803921569, alpha: 1)
        l.font = UIFont.init(name: "Arial", size: 17)
        l.textAlignment = .right
        return l
    }()
    lazy var countLabel:UILabel = {
        let l = UILabel()
        l.textColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        l.font = UIFont.init(name: "Arial", size: 17)
        l.text = "шт"
        return l
    }()
    lazy var down:UIButton = {
        let d = UIButton()
        d.setImage(#imageLiteral(resourceName: "down"), for: .normal)
        return d
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        setupConstraints()
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView(){
        self.backgroundColor = .white
        self.addSubViews(views: [upLabel,numLabel,countLabel,down])
    }
    
    func setupConstraints(){
        constrain(upLabel,numLabel,countLabel,down,self){ up,num,count,down,cv in
            up.width == cv.width
            up.height == cv.height * 0.5
            up.centerX == cv.centerX
            up.top == cv.top
            
            num.width == cv.width * 0.3
            num.left == cv.left + 10
            num.top == up.bottom
            
            count.width == num.width * 0.5
            count.left == num.right
            count.top == up.bottom
            
            down.width == count.width
            down.left == count.right
            down.top == up.bottom 
            
            
        }
    }

}
