//
//  ChangePasswordViewController.swift
//  Tole
//
//  Created by Nazhmeddin Babakhanov on 6/10/18.
//  Copyright © 2018 Beknar Danabek. All rights reserved.
//

import UIKit
import Cartography

class ChangePasswordViewController: UIViewController,UITextFieldDelegate {
    
    lazy var loginImage:UIImageView = {
        let image = UIImageView(image: UIImage(named:"loginImage"))
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    lazy var txtView:UIView = {
        let view = UIView()
        view.layer.masksToBounds = true
        vw.layer.borderWidth = 1
        vw.layer.borderColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        return view
    }()
    lazy var phoneField:UITextField = {
        let text = UITextField()
        text.textAlignment = NSTextAlignment.left
        // text.borderStyle = UITextBorderStyle.l
        let leftView = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: 0))
        text.leftView = leftView
        text.leftViewMode = .always
        text.delegate = self
        text.keyboardType = .default
        text.layer.borderColor = UIColor.gray.cgColor
        text.font = UIFont.init(name: "Helvetica", size: 17)
        text.textColor = UIColor.tableLabel
        text.backgroundColor = UIColor.white
        text.attributedPlaceholder = NSAttributedString(string: "Введите номер или эл.почту",
                                                        attributes: [NSAttributedStringKey.foregroundColor: UIColor.black])
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
        text.font = UIFont.init(name: "Helvetica", size: 17)
        text.textColor = UIColor.tableLabel
        text.isSecureTextEntry = true
        text.attributedPlaceholder = NSAttributedString(string: "Пороль",
                                                        attributes: [NSAttributedStringKey.foregroundColor: UIColor.black])
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
        text.isSecureTextEntry = true
        text.backgroundColor = UIColor.white
        text.textColor = UIColor.tableLabel
        text.attributedPlaceholder = NSAttributedString(string: "Введите новый пароль",
                                                        attributes: [NSAttributedStringKey.foregroundColor: UIColor.black])
        text.keyboardType = .numberPad
        
        
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
    
    lazy var vw:UIView = {
        let vw = UIView()
        vw1.backgroundColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        return vw
    }()
    
    lazy var vw1:UIView = {
        let vw1 = UIView()
        vw1.backgroundColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        return vw1
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setUpConstraints()
        setupNavigationBar()
    }
    
    //MARK: - Initial Setup
    func setupViews(){
        self.navigationItem.hidesBackButton = true
        
        txtView.addViews([phoneField,passwordField, vw,repeatPasswordField,vw1])
        self.view.addViews([txtView,loginImage,nextBtn])
        view.backgroundColor = #colorLiteral(red: 0.9607843137, green: 0.9607843137, blue: 0.9607843137, alpha: 1)
        
    }
    
    func setUpConstraints(){
        constrain(view,loginImage,txtView,phoneField,passwordField,nextBtn,vw,repeatPasswordField,vw1) { (vw,lg,txtView,phoneField,password,nextBtn,vwq,repeatP,vwq1) in
            lg.width == vw.width
            lg.height == vw.height*0.39
            lg.top == vw.top + 60
            lg.center == vw.center
            
            txtView.top == lg.bottom + 45
            txtView.centerX == txtView.superview!.centerX
            txtView.width == vw.width*0.8
            txtView.height == 0.255*view.bounds.height
            
            phoneField.width == txtView.width
            phoneField.top == txtView.top
            phoneField.leading == txtView.leading
            phoneField.height == txtView.height/3
            
            
            vwq.width == phoneField.width
            vwq.height == 1
            vwq.centerX == phoneField.centerX
            vwq.top == phoneField.bottom
            
            password.width == phoneField.width
            password.top == vwq.bottom
            password.centerX == phoneField.centerX
            password.height == phoneField.height
            
            vwq1.width == password.width
            vwq1.height == 1
            vwq1.centerX == password.centerX
            vwq1.top == password.bottom
            
            repeatP.width == phoneField.width
            repeatP.top == vwq1.bottom
            repeatP.centerX == phoneField.centerX
            repeatP.height == phoneField.height
            
            nextBtn.width == password.width
            nextBtn.height == password.height
            nextBtn.top == repeatP.bottom+10
            nextBtn.left == password.left
        }
    }
    // MARK: - Setup Navigation Bar
    func setupNavigationBar() -> Void {
        navigationItem.title = "Забыли пороль?"
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor:UIColor.navTitle]
        
        navigationItem.leftBarButtonItem = {
            let button = UIButton.init(type: .system)
            button.setTitle("Назад", for: .normal)
            button.setTitleColor(UIColor.navItem, for: .normal)
            button.addTarget(self, action: #selector(back), for: .touchUpInside)
            return UIBarButtonItem.init(customView: button)
        }()
    }
    @objc private func goBtnAction() {
        let vc = TabBarViewController()
        self.present(vc, animated: false, completion: nil)
    }
    
    @objc private func back(){
        navigationController?.popViewController(animated: false)
    }
    
}
