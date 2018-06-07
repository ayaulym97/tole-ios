//
//  GoodsViewController.swift
//  Tole
//
//  Created by Almas on 02.04.18.
//  Copyright © 2018 Beknar Danabek. All rights reserved.
//

import UIKit
import Cartography

class GoodsViewController: UIViewController {
    lazy var goods:[GoodModel] = []
    lazy var filteredGoods: [GoodModel] = []
    
    //MARK: - UIinit
    lazy var searchBar: UISearchBar = {
        let search = UISearchBar(frame: .zero)
        search.placeholder = Constant.goodsSearchBarPlaceHolder
        search.delegate = self
        search.backgroundColor = .white
        search.searchBarStyle = UISearchBarStyle.minimal
        
        return search
    }()
    
    lazy var tableView: UITableView = {
        let table = UITableView(frame: .zero)
        table.delegate = self
        table.dataSource = self
        table.register(UITableViewCell.self, forCellReuseIdentifier: Constant.goodsTableViewCellIdentifier)
        return table
    }()
    
    lazy var customView: UIView = {
        let view = UIView(frame: .zero)
        view.backgroundColor = .white
        view.layer.cornerRadius = 10
        view.layer.masksToBounds = true
        return view
    }()
    
    lazy var chooseButton: UIBarButtonItem = {
        let button = UIBarButtonItem()
        button.tintColor = UIColor.aqua
        button.title = Constant.goodsNavigationControllerRightButton
        return button
    }()
    
    lazy var deletButton: UIBarButtonItem = {
        let button = UIBarButtonItem()
        button.tintColor = UIColor.aqua
        button.title = Constant.goodsNavigationControllerLeftButton
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupConstraints()
        setupNavigationBar()
        
        goods.append(GoodModel(imageName: "keks", goodsName: "Bakery Frozen", price: "15$", weight: "20kg"))
        goods.append(GoodModel(imageName: "keks1", goodsName: "Many maker", price: "15$", weight: "20kg"))
        goods.append(GoodModel(imageName: "keks12", goodsName: "Heart Breaker", price: "15$", weight: "20kg"))
        filteredGoods = goods

    }
    

    

    // MARK: UISearchBar - filter data
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if let searchText = searchBar.text, !searchText.isEmpty {
            filteredGoods = goods.filter { team in
                return (team.goodsName?.lowercased().contains(searchText.lowercased()))!
            }
            
        } else {
            filteredGoods = goods
        }
        tableView.reloadData()
    }
    //MARK: - Initial Setup
    func setupViews(){
        self.customView.addSubview(tableView)
        self.customView.addSubview(searchBar)
        self.view.addSubview(customView)
        view.backgroundColor = UIColor.bgGray

    }
    // MARK: - Constraints
    func setupConstraints(){
        constrain(customView, tableView, searchBar ,view){ cv,tv,sb, vw in
            cv.top == vw.top + 75
            cv.left == vw.left + 10
            cv.right == vw.right - 10
            cv.bottom == vw.bottom
            
            sb.top == cv.top
            sb.left == cv.left
            sb.right == cv.right
            sb.height == 50
            tv.top == sb.bottom
            tv.left == cv.left
            tv.right == cv.right
            tv.bottom == cv.bottom
        }
    }
    // MARK: - NavigationBar setup
    func setupNavigationBar(){
        self.title =  Constant.goodsViewControllerName
        self.navigationController?.navigationBar.titleTextAttributes = [ NSAttributedStringKey.font: UIFont.systemFont(ofSize: 18, weight: UIFont.Weight.light)]
        navigationItem.rightBarButtonItems = [chooseButton]
        navigationItem.leftBarButtonItems = [deletButton]
        
    }
    
    @objc func choose(){
        
    }
    
}

// MARK: - extension UITableView
extension GoodsViewController: UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredGoods.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell  = GoodsTableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: Constant.goodsTableViewCellIdentifier)
        let selectedIndex = filteredGoods[indexPath.row]
        cell.goodsImage.image = UIImage(named: selectedIndex.imageName!)
        cell.goodsNameLabel.text = selectedIndex.goodsName
        cell.priceLabel.text = selectedIndex.price
        cell.weightLabel.text = selectedIndex.weight
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 98
    }
}

//MARK: - extension UISearchBar
extension GoodsViewController: UISearchBarDelegate{
    
}


