//
//  GoodsViewController.swift
//  Tole
//
//  Created by Almas on 02.04.18.
//  Copyright © 2018 Beknar Danabek. All rights reserved.
//

import UIKit

class ScannedTableViewController: UIViewController {
    lazy var goods:[ProductModel] = []
    lazy var filteredGoods: [ProductModel] = []
    var delegate:filteredProducts?
    let backButton = UIBarButtonItem(title: "Home/Return or nohing", style: .bordered, target: nil, action: nil)
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
    lazy var endBtn: UIButton = {
        let btn = UIButton()
        let yourAttributes : [NSAttributedStringKey: Any] = [
            NSAttributedStringKey.font : UIFont.systemFont(ofSize: 17),
            NSAttributedStringKey.foregroundColor : UIColor.white,
            ]
        let attributeString = NSMutableAttributedString(string: "Высчитать",
                                                        attributes: yourAttributes)
        btn.setAttributedTitle(attributeString, for: .normal)
        btn.layer.cornerRadius = 3
        btn.backgroundColor = UIColor.aqua
       // btn.addTarget(self, action: #selector(goBtnAction), for: .touchUpInside)
        return btn
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupConstraints()
        setupNavigationBar()
        
        goods.append(ProductModel(image: "keks", productTitle: "Bakery Frozen", price: "15$", count: "20kg"))
        goods.append(ProductModel(image: "keks1", productTitle: "Many maker", price: "15$", count: "20kg"))
        goods.append(ProductModel(image: "keks12", productTitle: "Heart Breaker", price: "15$", count: "20kg"))
        filteredGoods = goods
        
    }
    
    
    // MARK: UISearchBar - filter data
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if let searchText = searchBar.text, !searchText.isEmpty {
            filteredGoods = goods.filter { team in
                return (team.productTitle?.lowercased().contains(searchText.lowercased()))!
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
        self.view.addSubViews(views: [customView,endBtn])
        
        view.backgroundColor = UIColor.bgGray
        
    }
    // MARK: - Constraints
    func setupConstraints(){
        constrain(customView, tableView, searchBar ,endBtn,view){ cv,tv,sb,endBtn, vw in
            cv.top == vw.top + 75
            cv.left == vw.left + 10
            cv.right == vw.right - 10
            cv.height == vw.height * 0.7
            
            endBtn.width == cv.width
            endBtn.height == 44
            endBtn.centerX == vw.centerX
            endBtn.top == cv.bottom + 10
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
    // MARK: - Setup Navigation Bar
    func setupNavigationBar() -> Void {
        print(self.view.frame.width)
        navigationItem.leftBarButtonItem?.title = "Назад"
        
        navigationItem.title = "Итог"
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor:UIColor.navTitle]
    }
    
    @objc func choose(_ sender : Any){
        tableView.isEditing = !tableView.isEditing
        switch tableView.isEditing {
        case true:
            navigationItem.rightBarButtonItem?.tintColor = UIColor.bgGray
        case false:
            navigationItem.rightBarButtonItem?.tintColor = UIColor.navItem
        }
        
    }
    @objc func goBtnAction(){
        let vc = ScannerVC()
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
}

// MARK: - extension UITableView
extension ScannedTableViewController: UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredGoods.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell  = ScannedTableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: Constant.goodsTableViewCellIdentifier)
        let selectedIndex = filteredGoods[indexPath.row]
        cell.productImage.image = UIImage(named: selectedIndex.image!)
        cell.productCard.productTitle.text = selectedIndex.productTitle
        cell.productCard.price.text = selectedIndex.price
        cell.productCard.pCount.text = selectedIndex.count
        return cell

    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 98
    }
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let delete = deleteAction(at: indexPath)
        return UISwipeActionsConfiguration(actions: [delete])
    }
    func deleteAction(at indexPath : IndexPath) -> UIContextualAction{
        let deleteAction = UIContextualAction(style: .destructive, title: "",handler: { (ac:UIContextualAction, view:UIView, success:(Bool) -> Void) in
            self.filteredGoods.remove(at: indexPath.row)
            self.tableView.deleteRows(at: [indexPath], with: .automatic)
            success(true)
        })
        deleteAction.backgroundColor =  .red
        deleteAction.image = #imageLiteral(resourceName: "del")
        return deleteAction
    }

}

//MARK: - extension UISearchBar
extension ScannedTableViewController: UISearchBarDelegate{
    
}


