//
//  NotificationViewController.swift
//  Tole
//
//  Created by Nurbek Ismagulov on 10.03.18.
//  Copyright © 2018 Beknar Danabek. All rights reserved.
//

import UIKit
import Cartography

class NotificationViewController: UIViewController {
    
    var tableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupTableView()
        setupConstraints()
    }
    
    func setupView(){
        view.backgroundColor = UIColor.notificationViewBackground
    }
    func setupTableView(){
        //tableView = UITableView(frame: self.view.bounds, style: UITableViewStyle.plain)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(NotificationCell.self, forCellReuseIdentifier: "Cell")
        view.addSubview(tableView)
        
    }
    func setupConstraints(){
        
        constrain(tableView, view){ tv, v in
            tv.top == v.top + 8 / 736 * UIScreen.main.bounds.height
            tv.left == v.left + 11 / 414 *  UIScreen.main.bounds.width
            tv.right == v.right - 11 / 414 * UIScreen.main.bounds.width
            tv.bottom == v.bottom
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
}

extension NotificationViewController: UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return NotificationModel.arr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! NotificationCell
        
        cell.leftLabel.text = NotificationModel.arr[indexPath.row].getLeftLabel()
        cell.rightLabel.text = NotificationModel.arr[indexPath.row].getRightLabel()
        
        cell.separatorInset.left = 0 //3 / 414 * UIScreen.main.bounds.width
        cell.separatorInset.right = 0
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 73 / 736 * UIScreen.main.bounds.height
    }
}
