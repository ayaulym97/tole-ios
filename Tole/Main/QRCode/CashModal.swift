//
//  CashModal.swift
//  Tole
//
//  Created by Ayaulym Alzhan on 19.06.2018.
//  Copyright © 2018 Ayaulym Alzhan. All rights reserved.
//

import UIKit
import Cartography
class CashModal: UIView,UITextFieldDelegate {
//    var sum = 0
//    var num = 0
    lazy var header : UILabel = {
        let l = UILabel()
        l.text = "Оплата наличными"
        l.font = UIFont.systemFont(ofSize: 20)
        l.textColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        l.textAlignment = .center
        return l
    }()
    lazy var sumLabel : UILabel = {
        let l = UILabel()
        l.text = "Общая сумма"
        l.font = UIFont.systemFont(ofSize: 18)
        l.textColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        l.textAlignment = .left
        return l
    }()
    lazy var sumValue : UILabel = {
        let l = UILabel()
        l.text = "240"
        l.font = UIFont.systemFont(ofSize: 18)
        l.textColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        l.textAlignment = .right
        return l
    }()
    lazy var sumField:UITextField = {
        let text = UITextField()
        text.textAlignment = NSTextAlignment.left
        text.borderStyle = UITextBorderStyle.roundedRect
        let leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 0))
        text.leftView = leftView
        text.leftViewMode = .always
        text.delegate = self
        text.keyboardType = .numberPad
        text.layer.borderColor = UIColor.gray.cgColor
        text.font = UIFont.init(name: "Arial", size: 17)
        text.textColor = UIColor.tableLabel
        text.backgroundColor = UIColor.white
        text.placeholder = "Внести сумму"
        text.text = "100"
        return text
    }()
    lazy var surrenderLabel : UILabel = {
        let l = UILabel()
        l.text = "Сдача: "
        l.font = UIFont.systemFont(ofSize: 18)
        l.textColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        l.textAlignment = .left
        return l
    }()
    
    lazy var okBtn: UIButton = {
        let btn = UIButton()
        let yourAttributes : [NSAttributedStringKey: Any] = [
            NSAttributedStringKey.font : UIFont.systemFont(ofSize: 18),
            NSAttributedStringKey.foregroundColor : UIColor.white
        ]
        let attributeString = NSMutableAttributedString(string: "Готово",
                                                        attributes: yourAttributes)
        btn.setAttributedTitle(attributeString, for: .normal)
        btn.layer.cornerRadius = 3
        btn.backgroundColor = UIColor.aqua
        return btn
    }()
    lazy var cancel: UIButton = {
        let btn = UIButton()
        let yourAttributes : [NSAttributedStringKey: Any] = [
            NSAttributedStringKey.font : UIFont.systemFont(ofSize: 18),
            NSAttributedStringKey.foregroundColor : UIColor.gray
        ]
        let attributeString = NSMutableAttributedString(string: "Отмена",
                                                        attributes: yourAttributes)
        btn.setAttributedTitle(attributeString, for: .normal)
        btn.layer.cornerRadius = 3
        btn.layer.borderColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
        btn.layer.borderWidth = 1
        btn.backgroundColor = UIColor.white
      
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
        
        self.addSubViews(views: [header,sumField,sumLabel,surrenderLabel,sumValue,okBtn,cancel])
        }
        
        
    
    
    func setupConstraints(){
        constrain(header,sumField,sumLabel,sumValue,surrenderLabel,okBtn,cancel,self){ header,sumF,sumL,sumV,surrender,ok,cancel,cv in
            header.top == cv.top + 15
            header.centerX == cv.centerX
            header.width == cv.width
            
            sumL.top == header.bottom + 20
            sumL.width == header.width * 0.45
            sumL.left == cv.left + 5
            
            sumV.top == header.bottom + 20
            sumV.width == sumL.width
            sumV.left == sumL.right
            
            sumF.top == sumL.bottom + 10
            sumF.width == sumL.width
            sumF.height == ok.height
            sumF.left == cv.left + 5
            
            surrender.top == sumV.bottom + 30
            surrender.width == sumF.width
            surrender.left == sumF.right
            
            cancel.top == sumF.bottom + 10
            cancel.width == cv.width * 0.45
            cancel.height == 44
            cancel.left == cv.left + 5
            
            
            ok.top == sumF.bottom + 10
            ok.width == cancel.width
            ok.height == 44
            ok.left == cancel.right + 10
            
            
        }
    }
    

}
