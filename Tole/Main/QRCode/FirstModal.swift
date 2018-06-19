//
//  firstModal.swift
//  Tole
//
//  Created by Ayaulym Alzhan on 13.06.2018.
//  Copyright © 2018 Ayaulym Alzhan. All rights reserved.
//

import UIKit
import Cartography
class FirstModal: UIView {
    lazy var doneTick:UIImageView = {
        let image = UIImageView(image: UIImage(named:"done"))
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    lazy var commentLabel : UILabel = {
        let l = UILabel()
        l.text = "Успешно добавлена"
        l.font = UIFont.systemFont(ofSize: 18)
        l.textColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        l.textAlignment = .center
        return l
    }()
    lazy var  subView: UIView = {
        let view = UIView(frame: .zero)
        view.layer.cornerRadius = 3
        view.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        view.layer.borderWidth = 1
        view.backgroundColor = UIColor.white
        return view
    }()
    lazy var sumLabel : UILabel = {
        let l = UILabel()
        l.text = "Cумма:"
        
        l.font = UIFont.systemFont(ofSize: 18)
        l.textAlignment = .right
        l.textColor = #colorLiteral(red: 0.2901960784, green: 0.2901960784, blue: 0.2901960784, alpha: 1)
        return l
    }()
    lazy var numLabel : UILabel = {
        let l = UILabel()
        l.text = "255тг "
        l.font = UIFont.systemFont(ofSize: 18)
        l.textColor = UIColor.aqua
        return l
    }()
    
    
    
    lazy var okBtn: UIButton = {
        let btn = UIButton()
        let yourAttributes : [NSAttributedStringKey: Any] = [
            NSAttributedStringKey.font : UIFont.systemFont(ofSize: 18),
            NSAttributedStringKey.foregroundColor : UIColor.white
        ]
        let attributeString = NSMutableAttributedString(string: "Ок",
                                                        attributes: yourAttributes)
        btn.setAttributedTitle(attributeString, for: .normal)
        btn.layer.cornerRadius = 3
        btn.backgroundColor = UIColor.aqua
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
    
    func setupView(){
        self.addSubViews(views: [doneTick,subView,commentLabel,okBtn])
        self.subView.addSubViews(views: [sumLabel,numLabel])
    }
    
    func setupConstraints(){
        constrain(doneTick,subView,commentLabel,sumLabel,numLabel,okBtn,self){ done,sub,com,sumL,numL,ok,cv in
            done.width == 40
            done.height == 40
            done.centerX == cv.centerX
            done.top == cv.top + 20
            
            com.width == cv.width
            com.centerX == cv.centerX
            com.top == done.bottom + 10
            
            sub.width == cv.width * 0.6
            sub.top == com.top + 25
            sub.centerX == cv.centerX
            sub.height == 44
            
            sumL.width == sub.width * 0.5
            sumL.top == sub.top
            sumL.left == sub.left
            sumL.centerY == sub.centerY
            
            numL.width == sumL.width
            numL.left == sumL.right + 10
            numL.top == sub.top
            numL.centerY == sub.centerY
            
            
            
            ok.width == cv.width * 0.9
            ok.centerX == cv.centerX
            ok.top == sub.bottom + 20
            ok.height == sub.height
            
            
            
        }
    }
    
}

