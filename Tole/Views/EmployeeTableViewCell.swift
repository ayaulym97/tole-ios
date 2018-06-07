//
//  EmployeeTableViewCell.swift
//  Tole
//
//  Created by Nursultan on 03.04.2018.
//  Copyright © 2018 Beknar Danabek. All rights reserved.
//

import UIKit
import Cartography

class EmployeeTableViewCell: UITableViewCell {
    
        
    lazy var customView: UIView = {
        let c = UIView()
        c.backgroundColor = .white
        return c
    }()
    
    lazy var sellerLabel: UILabel = {
        let s = UILabel()
        s.font = UIFont(name: Fonts.helvetica, size: 18)
        s.textColor = .darkGray
        s.text = "Продавец 1"
        return s
    }()
    
    lazy var telephoneNumberTextField: UITextField = {
        let t = UITextField()
        t.font = UIFont(name: Fonts.helvetica, size: 19)
        t.textColor = .black
        t.keyboardType = .numberPad
        t.placeholder = Constant.telephoneNumberTextFieldPlaceHolder
        let leftView = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: 0))
        t.leftView = leftView
        t.leftViewMode = .always
        t.layer.borderColor = UIColor.gray.cgColor
        t.layer.borderWidth = 0.5
        return t
    }()
    
    lazy var sendInfoLabel: UILabel = {
        let s = UILabel()
        s.textColor = .gray
        s.font = UIFont(name: Fonts.helvetica, size: 16)
        s.text = Constant.sendInfoLabelText
        return s
    }()
    
    lazy var senderButton: UIButton = {
        let s = UIButton(type: .system)
        s.setTitle(Constant.sendText, for: .normal)
        s.setTitleColor(.white, for: .normal)
        s.backgroundColor  = .aqua
        s.layer.cornerRadius = 5
        return s
    }()
    
    lazy var acceptInfoLabel: UILabel = {
        let a = UILabel()
        a.textColor = .darkGray
        a.font = UIFont(name: Fonts.helvetica, size: 18)
        a.text = Constant.acceptInfoLabelText
        return a
    }()
    
    lazy var acceptSwitch: UISwitch = {
        let a = UISwitch()
        a.onTintColor = .aqua
        return a
    }()

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = .windowBackgroundColor
        addViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    func addViews(){
        self.addSubview(customView)
        constrain(customView,self){c,v in
            c.center == v.center
            c.width == v.width
            c.height == v.height * 0.98
        }
        
        customView.addSubview(sellerLabel)
        constrain(sellerLabel,customView){s,v in
            s.left == v.left + 20
            s.width == v.width * 0.4
            s.top == v.top + 20
        }
        customView.addSubview(telephoneNumberTextField)
        constrain(telephoneNumberTextField,sellerLabel,customView){t,s,v in
            t.left == v.left - 5
            t.right == v.right + 5
            t.top == s.bottom + 20
            t.height == v.height * 0.2
        }
        customView.addSubview(sendInfoLabel)
        constrain(sendInfoLabel,telephoneNumberTextField,customView){s,t,v in
            s.left == v.left + 20
            s.right == v.right - 20
            s.top == t.bottom + 20
            s.height == v.height * 0.1
        }
        customView.addSubview(senderButton)
        constrain(senderButton,sendInfoLabel,customView){sb,sl,v in
            sb.left == sl.left
            sb.right == sl.right
            sb.height == v.height * 0.15
            sb.top == sl.bottom + 10
        }
        customView.addSubview(acceptInfoLabel)
        constrain(acceptInfoLabel,senderButton,customView){a,s,v in
            a.left == s.left
            a.width == v.width * 0.7
            a.height == v.height * 0.1
            a.top == s.bottom + 20
        }
        customView.addSubview(acceptSwitch)
        constrain(acceptSwitch,acceptInfoLabel,senderButton){asw,al, s in
            asw.left == al.right + 20
            asw.right == s.right
            asw.top == s.bottom + 20
//            asw.height == al.height
        }
    }
    
}
