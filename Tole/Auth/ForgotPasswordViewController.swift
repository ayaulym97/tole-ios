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
        let view = UIView()
        view.layer.borderColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
        view.layer.borderWidth = 1.0
        view.layer.masksToBounds = true
        view.backgroundColor = .white
        return view
    }()
    lazy var phoneField:UITextField = {
        let text = UITextField()
        text.textAlignment = NSTextAlignment.left
        text.borderStyle = UITextBorderStyle.none
        let leftView = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: 0))
        text.leftView = leftView
        text.leftViewMode = .always
        text.delegate = self
        text.keyboardType = .default
        text.layer.borderColor = UIColor.gray.cgColor
        text.font = UIFont.init(name: "Helvetica", size: 17)
        text.textColor = UIColor.tableLabel
        text.backgroundColor = UIColor.white
        text.layer.borderColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
        text.layer.borderWidth = 1
        text.attributedPlaceholder = NSAttributedString(string: "Код подтверждения",
                                                        attributes: [NSAttributedStringKey.foregroundColor: UIColor.black])
        text.keyboardType = .numberPad
        return text
    }()
    
    lazy var textMore:UILabel = {
        let text = UILabel()
        text.font = UIFont.init(name: "Helvetica", size: 13)
        text.textColor = UIColor.tableLabel
        text.lineBreakMode = .byWordWrapping
        text.numberOfLines = 2
        text.text = "На указанный номер телефона будет отправлена сообщение с кодом подтверждения"
        return text
    }()
    
    lazy var viewPop:UIView = {
        let viewPop = UIView()
        viewPop.backgroundColor = .white
        viewPop.layer.borderColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
        viewPop.layer.borderWidth = 1.0
        viewPop.layer.masksToBounds = true
        viewPop.backgroundColor = .white
        viewPop.isHidden = true
        return viewPop
    }()
    
    lazy var passwordField:UITextField = {
        let text = UITextField()
        text.textAlignment = NSTextAlignment.left
        text.borderStyle = UITextBorderStyle.none
        let leftView = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: 0))
        text.leftView = leftView
        text.leftViewMode = .always
        text.delegate = self
        text.font = UIFont.init(name: "Helvetica", size: 17)
        text.textColor = UIColor.white
        text.attributedPlaceholder = NSAttributedString(string: "Введите номер",
                                                        attributes: [NSAttributedStringKey.foregroundColor: UIColor.black])
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
        txtView.addViews([phoneField])
        viewPop.addViews([passwordField])
        view.addViews([loginImage,forgotBtn,nextBtn,textMore,txtView,viewPop])
        view.backgroundColor = #colorLiteral(red: 0.9607843137, green: 0.9607843137, blue: 0.9607843137, alpha: 1)
        
    }
    
    func setUpConstraints(){
        constrain(view,loginImage,phoneField,forgotBtn,nextBtn,textMore,txtView,passwordField,viewPop) { (vw,lg,phoneField,forgotBtn,nextBtn,textMore,txtView,password,viewPop) in
            lg.width == vw.width
            lg.height == vw.height*0.39
            lg.top == vw.top + 60
            lg.center == vw.center
            
            txtView.top == lg.bottom + 45
            txtView.centerX == txtView.superview!.centerX
            txtView.width == vw.width*0.8
            txtView.height == 0.085*view.bounds.height
            
            viewPop.top == txtView.bottom+2
            viewPop.centerX == txtView.centerX
            viewPop.width == vw.width*0.8
            viewPop.height == 0.085*view.bounds.height
            
            phoneField.width == vw.width*0.8
            phoneField.height == vw.height*0.085
            phoneField.top == lg.bottom + 45
            phoneField.centerX == txtView.centerX
            
            
            password.width == viewPop.width
            password.top == phoneField.bottom
            password.centerX == viewPop.centerX
            password.height == viewPop.height
            
            forgotBtn.width == vw.width/3
            forgotBtn.top == viewPop.bottom
            forgotBtn.right == viewPop.right
            
            
            nextBtn.width == txtView.width
            nextBtn.height == vw.height*0.085
            nextBtn.top == forgotBtn.bottom+10
            nextBtn.centerX == txtView.centerX
            
            textMore.width == nextBtn.width
            textMore.height == nextBtn.height
            textMore.centerX == nextBtn.centerX
            textMore.top == nextBtn.bottom
        }
        
    }
    // MARK: - Setup Navigation Bar
    func setupNavigationBar() -> Void {
        navigationItem.leftBarButtonItem = {
            let button = UIButton.init(type: .system)
            button.setTitle("Назад", for: .normal)
            button.setTitleColor(UIColor.navItem, for: .normal)
            button.addTarget(self, action: #selector(back), for: .touchUpInside)
            return UIBarButtonItem.init(customView: button)
        }()
        
        
        navigationItem.title = "Забыли пороль?"
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor:UIColor.navTitle]
        
    }
    @objc private func goBtnAction() {
        if viewPop.isHidden{
            print("swipe")
            viewPop.isHidden = false
        }else{
            self.navigationController?.pushViewController(ChangePasswordViewController(), animated: false)
        }
    }
    @objc private func resendBtnAction() {
        print("send password")
        
    }
    
    @objc private func back(){
        navigationController?.popViewController(animated: false)
    }
    
    
}
