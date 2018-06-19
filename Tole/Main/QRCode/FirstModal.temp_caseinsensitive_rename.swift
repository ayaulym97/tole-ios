//
//  firstModal.swift
//  Tole
//
//  Created by Ayaulym Alzhan on 13.06.2018.
//  Copyright © 2018 Ayaulym Alzhan. All rights reserved.
//
import UIKit
import Cartography
class firstModal: UIView {
    var hide = true
    var cur = 0;
    lazy var upView: UIView = {
        let v = UIView()
        return v
    }()
    lazy var downView: UIView = {
        let v = UIView()
        return v
    }()
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
    lazy var plusBtn: UIButton = {
        let btn = UIButton()
        btn.setBackgroundImage(#imageLiteral(resourceName: "plus"), for: .normal)
        btn.addTarget(self, action: #selector(add), for: .touchUpInside)
        return btn
    }()
    lazy var minusBtn: UIButton = {
        let btn = UIButton()
        btn.setBackgroundImage(#imageLiteral(resourceName: "minus"), for: .normal)
        btn.addTarget(self, action: #selector(drop), for: .touchUpInside)
        return btn
    }()
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.white
        setupView()
        setupConstraints()
        
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    @objc func add(){
        cur = Int(pCount.text!)!
        self.pCount.text = String(cur + 1);
        
        
    }
    @objc func drop(){
        cur = Int(pCount.text!)!
        self.pCount.text = String(cur - 1);
    }
    
    
    
    func setupView(){
        self.addSubViews(views: [productTitle,upView,downView])
        self.upView.addSubViews(views: [plusBtn,minusBtn])
        self.downView.addSubViews(views: [price,pCount])
    }
    
    func setupConstraints(){
        constrain(upView,downView,productTitle, price, pCount,plusBtn,minusBtn,self){ up,down,pt,pl,cl,pB,mB,cv in
            pt.width == cv.width * 0.8
            pt.height == cv.height * 0.5
            pt.left == cv.left + 10
            pt.top == cv.top + 5
            
            up.top == cv.top + 5
            up.width == cv.width * 0.2
            up.height == cv.height
            up.left == pt.right
            
            pB.width == 25
            pB.height == 25
            pB.centerX == up.centerX
            pB.top == up.top + 5
            
            
            mB.width == 25
            mB.height == 25
            mB.centerX == up.centerX
            mB.top == pB.bottom + 10
            
            
            down.width == pt.width
            down.height == pt.height
            down.top == pt.bottom
            down.right == up.left
            
            pl.width == down.width * 0.5
            pl.left == cv.left + 10
            pl.centerY == down.centerY
            
            
            
            
            cl.width == pl.width
            cl.centerY == down.centerY
            cl.left == pl.right
            
            
        }
    }
}

