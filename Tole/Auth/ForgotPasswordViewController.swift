//
//  ForgotPasswordViewController.swift
//  Tole
//
//  Created by Ayaulym Alzhan on 02.06.2018.
//  Copyright © 2018 Ayaulym Alzhan. All rights reserved.
//

import UIKit
import Cartography
class ForgotPasswordViewController: UIViewController,UITextFieldDelegate{
    
    lazy var loginImage:UIImageView = {
        let image = UIImageView(image: UIImage(named:"forgotBG"))
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    lazy var txtView:UIView = {
        let view = UIView();
        view.layer.borderColor = #colorLiteral(red: 0.9254901961, green: 0.9254901961, blue: 0.9294117647, alpha: 1)
        view.layer.borderWidth = 1.0
        view.layer.cornerRadius = 3
        view.layer.masksToBounds = true
        view.backgroundColor = .white
        return view
    }()
    lazy var phoneField:UITextField = {
        let text = UITextField()
        text.textAlignment = NSTextAlignment.left
        text.borderStyle = UITextBorderStyle.roundedRect
        let leftView = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: 0))
        text.leftView = leftView
        text.leftViewMode = .always
        text.delegate = self
        text.keyboardType = .default
        text.layer.borderColor = UIColor.gray.cgColor
        text.font = UIFont.init(name: "Arial", size: 17)
        text.textColor = UIColor.tableLabel
        text.backgroundColor = UIColor.white
        text.placeholder = " Введите номер"
        return text
    }()
    lazy var passwordField:UITextField = {
        let text = UITextField()
        text.textAlignment = NSTextAlignment.left
        text.borderStyle = UITextBorderStyle.none
        let leftView = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: 0))
        text.leftView = leftView
        text.leftViewMode = .always
        text.delegate = self
        text.font = UIFont.init(name: "Arial", size: 17)
        text.textColor = UIColor.white
        
        text.placeholder = "Код подтверждения"
        text.keyboardType = .numberPad
        
        
        return text
    }()
    lazy var repeatPasswordField:UITextField = {
        let text = UITextField()
        text.textAlignment = NSTextAlignment.left
        text.borderStyle = UITextBorderStyle.none
        let leftView = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: 0))
        text.leftView = leftView
        text.leftViewMode = .always
        text.delegate = self
        text.font = UIFont.init(name: "Arial", size: 17)
        text.textColor = UIColor.white
        
        text.placeholder = "Введите новый пароль"
        text.keyboardType = .numberPad
        
        
        return text
    }()
    lazy var forgotBtn: UIButton = {
        let btn = UIButton()
        let yourAttributes : [NSAttributedStringKey: Any] = [
            NSAttributedStringKey.font : UIFont.systemFont(ofSize: 15),
            NSAttributedStringKey.foregroundColor : UIColor.darkGray,
            NSAttributedStringKey.underlineStyle : NSUnderlineStyle.styleSingle.rawValue
        ]
        let attributeString = NSMutableAttributedString(string: "Переотправить",
                                                        attributes: yourAttributes)
        btn.setAttributedTitle(attributeString, for: .normal)
        btn.addTarget(self, action: #selector(goBtnAction), for: .touchUpInside)
        btn.contentHorizontalAlignment = .right
        return btn
    }()
    
    lazy var nextBtn: UIButton = {
        let btn = UIButton()
        let yourAttributes : [NSAttributedStringKey: Any] = [
            NSAttributedStringKey.font : UIFont.systemFont(ofSize: 18),
            NSAttributedStringKey.foregroundColor : UIColor.white,
            ]
        let attributeString = NSMutableAttributedString(string: "Далее",
                                                        attributes: yourAttributes)
        btn.setAttributedTitle(attributeString, for: .normal)
        
        btn.backgroundColor = UIColor.aqua
        btn.addTarget(self, action: #selector(goBtnAction), for: .touchUpInside)
        return btn
    }()
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setUpConstraints()
        setupNavigationBar()
    }
    //MARK: - Initial Setup
    func setupViews(){
        
        self.view.addSubview(txtView)
        self.view.addSubview(loginImage)
        txtView.addSubview(phoneField)
        txtView.addSubview(passwordField)
        
        self.view.addSubview(forgotBtn)
        self.view.addSubview(nextBtn)
        
        view.backgroundColor = #colorLiteral(red: 0.9607843137, green: 0.9607843137, blue: 0.9607843137, alpha: 1)
        
    }
    func setUpConstraints(){
        constrain(view,loginImage,txtView,phoneField,passwordField,forgotBtn,nextBtn) { (vw,lg,txtView,phoneField,password,forgotBtn,nextBtn) in
            lg.width == vw.width
            lg.height == vw.height*0.39
            lg.top == lg.superview!.top + (self.navigationController?.navigationBar.frame.height)! + 20
            
            txtView.top == lg.bottom + 45
            txtView.left == vw.left + 40
            txtView.width == vw.width * 0.8
            txtView.height == 0.17*view.bounds.height
        
            phoneField.width == txtView.width
            phoneField.top == txtView.top
            phoneField.leading == txtView.leading
            phoneField.height == txtView.height*0.5
            
            password.width == phoneField.width
            password.top == phoneField.bottom
            password.leading == txtView.leading
            password.height == phoneField.height
            
            forgotBtn.width == password.width
            forgotBtn.top == password.bottom
            forgotBtn.left == password.left
            
            nextBtn.width == forgotBtn.width
            nextBtn.height == password.height
            nextBtn.top == forgotBtn.bottom+10
            nextBtn.left == forgotBtn.left
            
            
        }
    }
    // MARK: - Setup Navigation Bar
    func setupNavigationBar() -> Void {
        navigationItem.title = "Забыли пароль"
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor:UIColor.navTitle]
        
    }
    @objc private func goBtnAction() {
       print("swipe")
        
        
    }
    @objc private func resendBtnAction() {
        print("send password")
        
    }
  
    
    
}
