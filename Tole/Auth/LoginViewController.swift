
//
//  LoginViewController.swift
//  Tole
//
//  Created by Ayaulym Alzhan on 02.06.2018.
//  Copyright © 2018 Ayaulym Alzhan. All rights reserved.
//

import UIKit
import Cartography
class LoginViewController: UIViewController,UITextFieldDelegate{
    
    lazy var loginImage:UIImageView = {
        let image = UIImageView(image: UIImage(named:"loginImage"))
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    lazy var txtView:UIView = {
        let view = UIView()
        view.layer.masksToBounds = true
        vw.layer.borderWidth = 1
        vw.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        return view
    }()
    lazy var phoneField:UITextField = {
        let text = UITextField()
        text.textAlignment = NSTextAlignment.left
        let leftView = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: 0))
        text.leftView = leftView
        text.leftViewMode = .always
        text.delegate = self
        text.keyboardType = .default
        text.layer.borderColor = UIColor.gray.cgColor
        text.font = UIFont.init(name: "Arial", size: 17)
        text.textColor = UIColor.tableLabel
        text.backgroundColor = UIColor.white
        text.placeholder = "Введите номер или эл.почту"
        text.isSecureTextEntry = true
        text.keyboardType = .emailAddress
        return text
    }()
    lazy var passwordField:UITextField = {
        let text = UITextField()
        text.textAlignment = NSTextAlignment.left
        let leftView = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: 0))
        text.leftView = leftView
        text.backgroundColor = .white
        text.leftViewMode = .always
        text.delegate = self
        text.font = UIFont.init(name: "Arial", size: 17)
        text.textColor = UIColor.tableLabel
        text.textColor = UIColor.white
        text.placeholder = "Пароль"
        return text
    }()
    lazy var nextBtn: UIButton = {
        let btn = UIButton()
        let yourAttributes : [NSAttributedStringKey: Any] = [
            NSAttributedStringKey.font : UIFont.systemFont(ofSize: 18),
            NSAttributedStringKey.foregroundColor : UIColor.white,
            ]
        let attributeString = NSMutableAttributedString(string: "Войти",
                                                        attributes: yourAttributes)
        btn.setAttributedTitle(attributeString, for: .normal)
        btn.layer.cornerRadius = 2
        btn.backgroundColor = #colorLiteral(red: 0.2705882353, green: 0.6431372549, blue: 0.6901960784, alpha: 1)
        btn.addTarget(self, action: #selector(goBtnAction), for: .touchUpInside)
        return btn
    }()
    lazy var forgotBtn: UIButton = {
        let btn = UIButton()
        let yourAttributes : [NSAttributedStringKey: Any] = [
            NSAttributedStringKey.font : UIFont.systemFont(ofSize: 15),
            NSAttributedStringKey.foregroundColor : UIColor.darkGray,
            NSAttributedStringKey.underlineStyle : NSUnderlineStyle.styleSingle.rawValue
        ]
        let attributeString = NSMutableAttributedString(string: "Забыли пароль?",
                                                        attributes: yourAttributes)
        btn.setAttributedTitle(attributeString, for: .normal)
        btn.addTarget(self, action: #selector(forgotBtnAction), for: .touchUpInside)
        btn.contentHorizontalAlignment = .right
        return btn
    }()
    
    lazy var vw:UIView = {
        let vw = UIView()
        vw.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        return vw
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setUpConstraints()
        setupNavigations()
    }
    
    //MARK: - Initial Setup
    func setupViews(){
        self.navigationItem.hidesBackButton = true
        
        txtView.addViews([phoneField,passwordField, vw])
        self.view.addViews([txtView,loginImage,forgotBtn,nextBtn])
        view.backgroundColor = #colorLiteral(red: 0.9607843137, green: 0.9607843137, blue: 0.9607843137, alpha: 1)
        
    }
    
    func setUpConstraints(){
        constrain(view,loginImage,txtView,phoneField,passwordField,forgotBtn,nextBtn,vw) { (vw,lg,txtView,phoneField,password,forgotBtn,nextBtn,vwq) in
            lg.width == vw.width
            lg.height == vw.height*0.39
            lg.top == lg.superview!.top  + 65
            
            txtView.top == lg.bottom + 45
            txtView.centerX == txtView.superview!.centerX
            txtView.width == vw.width*0.8
            txtView.height == 0.17*view.bounds.height
            
            phoneField.width == txtView.width
            phoneField.top == txtView.top
            phoneField.leading == txtView.leading
            phoneField.height == txtView.height*0.5
            
            vwq.width == phoneField.width
            vwq.height == 1
            vwq.centerX == phoneField.centerX
            vwq.top == phoneField.bottom
            
            password.width == phoneField.width
            password.top == vwq.bottom
            password.centerX == phoneField.centerX
            password.height == phoneField.height
            
            forgotBtn.width == txtView.width
            forgotBtn.top == password.bottom
            forgotBtn.left == password.left
            
            nextBtn.width == forgotBtn.width
            nextBtn.height == password.height
            nextBtn.top == forgotBtn.bottom+10
            nextBtn.left == forgotBtn.left
        }
    }
    // MARK: - Setup Navigation Bar
    func setupNavigations(){
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.navTitle]
        navigationItem.title = "Войти"
    }
    @objc private func goBtnAction() {
        let vc = TabBarViewController()
        self.present(vc, animated: false, completion: nil)
    }
    @objc private func forgotBtnAction() {
        let vc = UINavigationController.init(rootViewController: LoginViewController())
        vc.pushViewController(ForgotPasswordViewController(), animated: true)
        self.present(vc, animated: false, completion: nil)
    }
    
}

