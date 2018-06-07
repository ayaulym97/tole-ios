//
//  EmployeeRegisterViewController.swift
//  Tole
//
//  Created by Nursultan on 02.04.2018.
//  Copyright © 2018 Beknar Danabek. All rights reserved.
//

import UIKit
import Cartography
class EmployeeRegisterViewController: UIViewController {
    
    
    //    MARK: Models
    lazy var employeeModel = EmployeeTableViewModel()
   
    
    
    //    MARK: Views
    lazy var myTableView: UITableView = {
        let m = UITableView()
        m.delegate = self
        m.dataSource = self
        m.backgroundColor = .windowBackgroundColor
        m.register(EmployeeTableViewCell.self, forCellReuseIdentifier: Constant.cellName)
        return m
    }()
    
    lazy var addEmployeeLabel: UILabel = {
        let a = UILabel()
        a.font = UIFont(name: Fonts.helvetica, size: 13)
        a.textColor = .gray
        a.text = Constant.addEmployeeLabelText
//        a.backgroundColor = .green
        return a
    }()
    
    lazy var addEmployeeButton: UIButton = {
        let a = UIButton(type: .system)
        a.setTitle(Constant.addEmployeeButtonText, for: .normal)
        a.setTitleColor(.aqua, for: .normal)
        a.backgroundColor = .buttonBackgroundColor
        a.layer.cornerRadius = 5
        a.titleLabel?.font = .boldSystemFont(ofSize: 18)
        return a
    }()
    
    //    MARK: Alert's Views
    lazy var alertViewBackground: UIView = {
        let a = UIView()
        a.backgroundColor = .darkWithOpaque
        a.alpha = 0.5
        a.isHidden = true
        return a
    }()
    
    lazy var alertView: UIView = {
        let a = UIView()
        a.backgroundColor = .white
        a.alpha = 1
        a.layer.cornerRadius = 5
        a.alpha = 0
        return a
    }()
    
    lazy var alertIconImageView: UIImageView = {
        let a = UIImageView(image: UIImage(named:"round-done-button"))
        return a
    }()
    
    lazy var alertTextView: UITextView = {
        let a = UITextView()
        a.isEditable = false
        a.font = UIFont(name: Fonts.helvetica, size: 19)
        a.textColor = UIColor.darkGray
        a.text = Constant.alertTextViewBegin + Constant.alertTextViewEnd
        return a
    }()
    
    lazy var alertButton: UIButton = {
        let a = UIButton(type: .system)
        a.backgroundColor = .aqua
        a.setTitle(Constant.okText, for: .normal)
        a.setTitleColor(.white, for: .normal)
        a.layer.cornerRadius = 5
        a.addTarget(self, action: #selector(alertButtonPressed), for: .touchUpInside)
        return a
    }()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupAllViews()
        
        
        
    }
    //    MARK: Button Methods
    @objc func senderButtonPressed(sender: UIButton){
        let indexPath = IndexPath(row: sender.tag, section: 0)
        let cell = myTableView.cellForRow(at: indexPath) as! EmployeeTableViewCell
        employeeModel.makeAlertView(mobileNumber: cell.telephoneNumberTextField.text!, alertTextView: alertTextView, alertViewBackground: alertViewBackground, alertView: alertView)
        
    }
    
    @objc func alertButtonPressed(sender: UIButton){
        employeeModel.removeAlertView(alertViewBackground: alertViewBackground, alertView: alertView)
    }
    
    //    MARK: Constraints
    func setupAllViews(){
        
        self.title = Constant.employeeTitle
        self.navigationController?.navigationBar.barTintColor = .white
        
        view.addSubview(addEmployeeLabel)
        constrain(addEmployeeLabel,view){a,v in
            a.left == v.left + 20
            a.width == v.width * 0.4
            a.height == v.height * 0.05
            a.bottom == v.bottom - 5
        }
        
        view.addSubview(addEmployeeButton)
        constrain(addEmployeeButton,view,addEmployeeLabel){ab, v, al in
            ab.left == al.right + 20
            ab.right == v.right - 20
            ab.height == v.height * 0.05
            ab.bottom == al.bottom
        }
        
        view.addSubview(myTableView)
        constrain(myTableView,view,addEmployeeButton){m,v,ab in
            m.left == v.left + 20
            m.right == v.right - 20
            m.top == v.top  + (self.navigationController?.navigationBar.frame.height)! + 25
            m.bottom == ab.top - 5
        }
        
        view.addSubview(alertViewBackground)
        constrain(alertViewBackground,view){a, v in
            a.center == v.center
            a.width == v.width
            a.height == v.height
        }
        
        view.addSubview(alertView)
        constrain(alertView, view){a, v in
            a.center == v.center
            a.width == v.width * 0.9
            a.height == v.height * 0.3
        }
        
        alertView.addSubview(alertIconImageView)
        constrain(alertIconImageView, alertView){ai,av in
            ai.centerX == av.centerX
            ai.width == av.width * 0.1
            ai.height == av.height * 0.15
            ai.top == av.top + 15
        }
        alertView.addSubview(alertTextView)
        constrain(alertTextView,alertIconImageView,alertView){al, ai, av in
            al.left == av.left + 10
            al.right == av.right - 10
            al.top == ai.bottom + 5
            al.height == av.height * 0.45
        }
        alertView.addSubview(alertButton)
        constrain(alertButton, alertTextView, alertView){ab,al,av in
            ab.centerX == av.centerX
            ab.width == av.width * 0.9
            ab.height == av.height * 0.2
            ab.top == al.bottom + 5
        }
    }
    
}
//  MARK: TableViewExtension
extension EmployeeRegisterViewController: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = myTableView.dequeueReusableCell(withIdentifier: Constant.cellName, for: indexPath) as! EmployeeTableViewCell
        cell.selectionStyle = .none
        cell.senderButton.tag = indexPath.row
        cell.senderButton.addTarget(self, action: #selector(senderButtonPressed), for: .touchUpInside)
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return self.view.frame.height * 0.42
    }
    
}
