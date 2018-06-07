//
//  CustomCellForProfile.swift
//  Tole-app
//
//  Created by I on 03.04.2018.
//  Copyright © 2018 Beknar Danabek. All rights reserved.
//

import Foundation
import UIKit
import  Cartography

class CustomCellForProfile:UITableViewCell,UITextFieldDelegate{
    
    // MARK: - Properties
    lazy var line:UIView = {
        let line = UIView.init()
        line.backgroundColor = UIColor.line
        return line
    }()
    
    lazy var textField:UITextField = {
        let text = UITextField()
        text.borderStyle = UITextBorderStyle.none
        text.textAlignment = NSTextAlignment.right
        text.delegate = self
        text.font = UIFont.init(name: "Arial", size: self.bounds.height * 0.35)
        text.textColor = UIColor.tableLabel
        return text
    }()
    
    lazy var label:UILabel = {
        let label = UILabel.init()
        label.textAlignment = .left
        label.textColor = UIColor.tableLabel
        label.font = UIFont.init(name: "Arial", size: self.bounds.width * 0.055)
        return label
    }()
    
    
     // MARK: - Initializer
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
        setupConstrains()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
     // MARK: - Setup View
    func setupView() -> Void {
        self.addSubview(line)
        self.addSubview(label)
        self.addSubview(textField)
        
    }
    
     // MARK: - As initializer
    func set(label:String,text:String,enabledTextField:Bool) -> Void {
        self.label.text = label
        self.textField.text = text
        self.textField.isEnabled = enabledTextField
        if enabledTextField == true{
            self.textField.textColor = UIColor.edit
        }
        layoutIfNeeded()
    }
    
    // MARK: - Constrains
    func setupConstrains() -> Void {
        constrain(line,label,textField){ line,label,textField in
            
            line.width == (line.superview?.width)!
            line.height == 1
            line.bottom == (line.superview?.bottom)!
            
            label.width == (label.superview?.width)! * 0.45 - self.bounds.width * 0.03
            label.height == (label.superview?.width)! * 0.6
            label.centerY == (label.superview?.centerY)!
            label.left == (label.superview?.left)! + self.bounds.height * 0.07
            
            textField.width == (textField.superview?.width)! * 0.55 - self.bounds.height * 0.07
            textField.height == label.height
            textField.centerY == label.centerY
            textField.right == (textField.superview?.right)! - self.bounds.width * 0.07

        }
    }
}
