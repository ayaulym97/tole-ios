//
//  ViewController.swift
//  Tole-app
//
//  Created by Beknar Danabek on 21/02/2018.
//  Copyright © 2018 Beknar Danabek. All rights reserved.
//

import UIKit
import Cartography

class MyProfileViewController: UIViewController, UITextFieldDelegate{
    
     // MARK: -  Properties
    lazy var enabled = false
    
    lazy var dataHeader:[String] = ["Ф.И.О","Предприятие","Эл.почта","Номер телефона","Пароль"]
    
    lazy var dataExample:[String] = ["Вася Пупкин","Coffee Lover","aababc@gmail.com","87771777767","....."]
    
    lazy var saveButton:UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor.edit
        button.layer.cornerRadius = 5
        button.setTitle("Сохранить", for: .normal)
        button.addTarget(self, action: #selector(saveHandle), for: UIControlEvents.touchUpInside)
        button.isEnabled = false
        button.isHidden = true
        return button
    }()
    
    lazy var table:UITableView = {
        let table = UITableView(frame: CGRect.init(), style: UITableViewStyle.plain)
        table.delegate = self as UITableViewDelegate
        table.dataSource = self as UITableViewDataSource
        table.showsVerticalScrollIndicator = false
        table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        table.rowHeight = self.view.bounds.height * 0.07
        table.showsVerticalScrollIndicator = false
        table.separatorStyle = .none
        table.isScrollEnabled = false
        return table
    }()
    
    lazy var imageView:UIImageView = {
        let image = UIImageView.init(image: UIImage.init(named: "Mask"))
        image.backgroundColor = UIColor.gray
        return image
    }()
    
     // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupConstrains()
        setupNavigationBar()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self, selector: #selector(keyboardWillShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        notificationCenter.addObserver(self, selector: #selector(keyboardWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        let notificationCenter = NotificationCenter.default
        notificationCenter.removeObserver(self, name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        notificationCenter.removeObserver(self, name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
     // MARK: - Setup View
    func setupView() -> Void {
        self.view.addSubview(table)
        self.view.addSubview(saveButton)
        self.view.addSubview(imageView)
        self.view.backgroundColor = UIColor.background
    }
    
     // MARK: - Setup Navigation Bar
    func setupNavigationBar() -> Void {
        print(self.view.frame.width)
        navigationItem.leftBarButtonItem = {
            let button = UIButton.init(type: .system)
            button.setTitle("Назад", for: .normal)
            button.setTitleColor(UIColor.navItem, for: .normal)
            return UIBarButtonItem.init(customView: button)
        }()
        
        navigationItem.rightBarButtonItem = {
            let button = UIButton.init(type: .system)
            button.setTitle("Изменить", for: .normal)
            button.addTarget(self, action: #selector(edit), for: UIControlEvents.allEvents)
            button.setTitleColor(UIColor.navItem, for: .normal)
            return UIBarButtonItem.init(customView: button)
        }()
        
        navigationItem.title = "Мой профиль"
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor:UIColor.navTitle]
    }

     // MARK: - Constrains
    func setupConstrains() -> Void {
        constrain(table,saveButton,imageView){ table,button,image in
            
            table.width == (table.superview?.width)! * 0.9
            table.height == (table.superview?.height)! * 0.35
            table.centerX == (table.superview?.centerX)!
            table.centerY == (table.superview?.centerY)! + self.view.frame.width/4.5
            
            image.width == (image.superview?.width)!
            image.top == (image.superview?.top)! + (navigationController?.navigationBar.frame.maxY)!
            image.bottom == table.top - self.view.frame.width * 0.07
            image.centerX == table.centerX
            
            button.width == table.width
            button.centerX == (button.superview?.centerX)!
            button.height == 0.07 * self.view.bounds.height
            button.top == (table.bottom) + self.view.frame.width * 0.05
            
        }
    }
    
     // MARK: -  Edit Action
    @objc func edit(_ sender:UIButton){
        enabled = true
        table.reloadData()
        saveButton.isHidden = false
        saveButton.isEnabled = true
        sender.setTitleColor(UIColor.edit, for: .normal)
    }
    
     // MARK: - Back Action
    @objc func back(_ sender:UIBarButtonItem!){
        navigationController?.popViewController(animated: true)
    }
    
     // MARK: - Save Action
    @objc func saveHandle() -> Void {
        enabled = false
        for i in 0...4 {
            let cell = table.visibleCells[i] as! CustomCellForProfile
            dataExample[i] = cell.textField.text!
        }
        saveButton.isHidden = true
        saveButton.isEnabled = false
        (navigationItem.rightBarButtonItem?.customView as! UIButton).setTitleColor(UIColor.navItem , for: .normal)
        table.reloadData()
    }
    
    
     // MARK: - Keyboard Action
    @objc func keyboardWillShow(notification: NSNotification) {
        let userInfo = notification.userInfo!
        let keyboardHeight = (userInfo[UIKeyboardFrameEndUserInfoKey] as! NSValue).cgRectValue.height
        self.view.frame.origin.y = -keyboardHeight + 30
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        self.view.frame.origin.y = 0
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        view.frame.origin.y = 0
        textField.resignFirstResponder()
        return true
    }
}
extension MyProfileViewController: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataHeader.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = CustomCellForProfile.init(style: .default, reuseIdentifier: "cell")
        cell.set(label: dataHeader[indexPath.row], text: dataExample[indexPath.row],enabledTextField: enabled)
        cell.textField.delegate = self
        cell.selectionStyle = .none
        cell.textField.endEditing(true)
        if indexPath.row == 4 {
            cell.textField.isSecureTextEntry = true
        }
        return cell
    }
}
