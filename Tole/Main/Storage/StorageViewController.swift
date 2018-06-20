import UIKit
import Cartography


class StorageViewController: UIViewController
{
    
    lazy var goods:[ProductModel] = []
    lazy var filteredGoods: [ProductModel] = []
    lazy var searchBar: UISearchBar = {
        let search = UISearchBar(frame: .zero)
        search.placeholder = Constant.goodsSearchBarPlaceHolder
        search.delegate = self as? UISearchBarDelegate
        search.backgroundColor = .white
        search.searchBarStyle = UISearchBarStyle.minimal
        return search
    }()
    
    lazy var tableView: UITableView = {
        let table = UITableView(frame: .zero)
        table.delegate = self
        table.dataSource = self
        table.backgroundColor = .none
        table.register(UITableViewCell.self, forCellReuseIdentifier: Constant.goodsTableViewCellIdentifier)
        return table
    }()
    
    lazy var customView: UIView = {
        let view = UIView(frame: .zero)
        view.backgroundColor =  .none
        view.layer.cornerRadius = 10
        view.layer.masksToBounds = true
        return view
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupConstraints()
        setupNavigationBar()
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

        tableView.separatorStyle = .none
        view.backgroundColor = UIColor.bgGray
        self.customView.addSubview(tableView)
        self.view.addSubViews(views: [searchBar,customView])
        goods.append(ProductModel(productTitle: "Pepsi", price: "15$", count: "20"))
        goods.append(ProductModel(productTitle: "Cola", price: "15$", count: "20"))
        goods.append(ProductModel(productTitle: "Rolton", price: "15$", count: "20"))
        filteredGoods = goods
//        UIApplication.shared.keyWindow?.addSubview(modalView)
//        modalView.addSubViews(views: [firstModalView,secondModalView])
        
        
    }
    // MARK: - Constraints
    func setupConstraints(){
        constrain(tableView,customView,searchBar,view){tv,cv,sb,vw in
            
            sb.top == vw.top + 75
            sb.width == vw.width * 0.9
            sb.centerX == vw.centerX
            sb.height == 50
            
            cv.top == sb.bottom + 5
            cv.width == sb.width
            cv.centerX == vw.centerX
            cv.height == vw.height * 0.55
            
            tv.top == cv.top
            tv.centerX == cv.centerX
            tv.width == sb.width
            tv.height == cv.height
            
        
            
        }
    }
    // MARK: - Setup Navigation Bar
    func setupNavigationBar() -> Void {
        navigationItem.leftBarButtonItem?.title = "Назад"
        navigationItem.title = "Итог"
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor:UIColor.navTitle]
    }
   
}

// MARK: - extension UITableView
extension StorageViewController: UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredGoods.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell  = StorageTableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: "storageCell")
        let selectedIndex = filteredGoods[indexPath.row]
        cell.layer.cornerRadius = 3
        cell.layer.borderColor = #colorLiteral(red: 0.9529411765, green: 0.9450980392, blue: 0.9450980392, alpha: 1)
        cell.layer.borderWidth = 1
        cell.backgroundColor = .none
        cell.productTitle.text = selectedIndex.productTitle
        cell.price.text = selectedIndex.price
        cell.pCount.text = selectedIndex.count
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




