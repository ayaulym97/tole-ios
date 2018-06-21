//
//  ViewController.swift
//  Tole-app
//
//  Created by Beknar Danabek on 21/02/2018.
//  Copyright © 2018 Beknar Danabek. All rights reserved.
//

import UIKit
import Cartography

class StorageProduct: UIViewController, UITextFieldDelegate{
    
    // MARK: -  Properties
    lazy var enabled = false
    
    lazy var dataHeader:[String] = ["Название","Поставщик","Закупочная цена","Розничная цена"]
    
    lazy var dataExample:[String] = ["Пепси","ТОО Хамле","550тг","600тг"]
    lazy var container:UIView = {
        let v = UIView()
        v.backgroundColor = .none
        v.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        v.layer.borderWidth = 1
        v.layer.cornerRadius = 3
        return v
    }()
    lazy var leftView:StorageButton = {
        let v = StorageButton()
        v.upLabel.text = "Количество"
        v.numLabel.text = "15"
        return v
    }()
    
    lazy var rightView:StorageButton = {
        let v = StorageButton()
        v.upLabel.text = "Уведомление об окончании продукта"
        v.numLabel.text = "5"

        return v
    }()
    lazy var saveButton:UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor.aqua
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
        self.view.addSubViews(views: [container,saveButton])
        self.container.addSubViews(views: [table,leftView,rightView])
        self.view.backgroundColor = UIColor.background
    }
    
    // MARK: - Setup Navigation Bar
    func setupNavigationBar() -> Void {
        print(self.view.frame.width)
        navigationItem.leftBarButtonItem = {
            let button = UIButton.init(type: .system)
            button.setTitle("Удалить", for: .normal)
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
        
        navigationItem.title = "Товары"
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor:UIColor.navTitle]
    }
    
    // MARK: - Constrains
    func setupConstrains() -> Void {
        constrain(container,table,saveButton,leftView,rightView,view){ container,table,button,left,right,vw in
            container.width == vw.width * 0.9
            container.height == vw.height * 0.4
            container.centerX == vw.centerX
            container.top == vw.top + 75
            
            table.width == container.width
            table.height == container.height * 0.8
            table.centerX == container.centerX
            table.top == container.top
            
            left.top == table.bottom
            left.left == container.left
            left.width == container.width * 0.5
            left.height == container.height * 0.15
            
            right.top == table.bottom
            right.left == left.right
            right.width == left.width
            right.height == left.height
            
            
            
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
extension StorageProduct: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataHeader.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = CustomCellForProfile.init(style: .subtitle, reuseIdentifier: "cell")
        
        cell.set(label: dataHeader[indexPath.row], text: dataExample[indexPath.row],enabledTextField: enabled)
        cell.textField.textColor = UIColor.red
        cell.label.font = UIFont.init(name: "Arial", size: 15)
        cell.textField.delegate = self
        cell.selectionStyle = .none
        cell.textField.endEditing(true)
        if indexPath.row == 4 {
            cell.textField.isSecureTextEntry = true
        }
        return cell
    }
}

