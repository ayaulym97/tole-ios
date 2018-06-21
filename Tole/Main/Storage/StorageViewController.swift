import UIKit
import Cartography


class StorageViewController: UIViewController
{
    var isHidden: Bool = false
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
    lazy var sampleBtn: UIButton = {
        let btn = UIButton()
        let yourAttributes : [NSAttributedStringKey: Any] = [
            NSAttributedStringKey.font : UIFont.systemFont(ofSize: 17),
            NSAttributedStringKey.foregroundColor : UIColor.white,
            ]
        let attributeString = NSMutableAttributedString(string: "Завершить",
                                                        attributes: yourAttributes)
        btn.setAttributedTitle(attributeString, for: .normal)
        btn.layer.cornerRadius = 3
        btn.backgroundColor = UIColor.aqua
        btn.addTarget(self, action: #selector(hide), for: .touchUpInside)
        
        return btn
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
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
//        tableView.setEditing(isHidden, animated: false)
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
        tableView.allowsMultipleSelectionDuringEditing = true
        view.backgroundColor = UIColor.bgGray
        self.customView.addSubview(tableView)
        self.view.addSubViews(views: [searchBar,customView,sampleBtn])
        goods.append(ProductModel(productTitle: "Pepsi", price: "15$", count: "20"))
        goods.append(ProductModel(productTitle: "Cola", price: "15$", count: "20"))
        goods.append(ProductModel(productTitle: "Rolton", price: "15$", count: "20"))
        filteredGoods = goods
//        UIApplication.shared.keyWindow?.addSubview(modalView)
//        modalView.addSubViews(views: [firstModalView,secondModalView])
        
        
    }
    // MARK: - Constraints
    func setupConstraints(){
        constrain(tableView,customView,searchBar,sampleBtn,view){tv,cv,sb,sample,vw in
            
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
            
            sample.width == cv.width
            sample.height == 44
            sample.top == cv.top
            sample.centerX == vw.centerX
            
        
            
        }
    }
    // MARK: - Setup Navigation Bar
    func setupNavigationBar() -> Void {
        navigationItem.leftBarButtonItem?.title = "Назад"
        navigationItem.title = "Список товаров"
        navigationItem.leftBarButtonItem?.title = "Выбрать"
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor:UIColor.navTitle]
    }
    @objc func hide() {
        if (isHidden) {
            isHidden = false
            tableView.setEditing(false, animated: false)
        } else {
            isHidden = true
            tableView.setEditing(true, animated: false)
        }
        print(isHidden)
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
        cell.selectedBackgroundView = UIView(frame: cell.frame)

        cell.productCard.productTitle.text = selectedIndex.productTitle
        cell.productCard.price.text = selectedIndex.price
        cell.productCard.pCount.text = selectedIndex.count
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = StorageProduct()
        navigationController?.pushViewController(vc, animated: true)
        print("row: \(indexPath.row)")
    }
    
    
}




