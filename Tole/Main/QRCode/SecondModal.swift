//
//  firstModal.swift
//  Tole
//
//  Created by Ayaulym Alzhan on 13.06.2018.
//  Copyright © 2018 Ayaulym Alzhan. All rights reserved.
//

import UIKit
import Cartography
class SecondModal: UIView {
    lazy var doneTick:UIImageView = {
        let image = UIImageView(image: UIImage(named:"done"))
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    lazy var commentLabel : UILabel = {
        let l = UILabel()
        l.text = "Успешно добавлена!"
        l.font = UIFont.systemFont(ofSize: 18)
        l.textColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        l.textAlignment = .center
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
        self.addSubViews(views: [doneTick,commentLabel,okBtn])

    }
    
    func setupConstraints(){
        constrain(doneTick,commentLabel,okBtn,self){ done,com,ok,cv in
            done.width == 40
            done.height == 40
            done.centerX == cv.centerX
            done.top == cv.top + 5
            
            
            com.width == cv.width
            com.centerX == cv.centerX
            com.top == done.bottom + 20
            
            ok.width == cv.width * 0.9
            ok.centerX == cv.centerX
            ok.top == com.bottom + 20
            ok.height == 44
          
            
        }
    }
    
}

