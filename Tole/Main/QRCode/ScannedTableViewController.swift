import UIKit
import Cartography


protocol takeDelegate{
    func take(update : Any)
}
class ScannedTableViewController: UIViewController,someDelegate
{
    func valueLable(update:Any) {
        goods = update as! [ProductModel]
}
    
    lazy var goods:[ProductModel] = []
    lazy var filteredGoods: [ProductModel] = []
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
    //modal
    lazy var modalView: UIView = {
        let view = UIView(frame: .zero)
        view.backgroundColor =  UIColor.black.withAlphaComponent(0.8)
        view.frame = UIScreen.main.bounds
        return view
    }()
    lazy var firstModalView: FirstModal = {
        let product = FirstModal()
        product.layer.borderColor = #colorLiteral(red: 0.9254901961, green: 0.9254901961, blue: 0.9294117647, alpha: 1)
        product.layer.borderWidth = 1.0
        product.layer.cornerRadius = 3
        product.layer.masksToBounds = true
        product.translatesAutoresizingMaskIntoConstraints = false
        product.okBtn.addTarget(self, action: #selector(firstModalAction), for: .touchUpInside)
        return product
    }()
    lazy var secondModalView: SecondModal = {
        let product = SecondModal()
        product.layer.borderColor = #colorLiteral(red: 0.9254901961, green: 0.9254901961, blue: 0.9294117647, alpha: 1)
        product.layer.borderWidth = 1.0
        product.layer.cornerRadius = 3
        product.layer.masksToBounds = true
        product.translatesAutoresizingMaskIntoConstraints = false
        product.okBtn.addTarget(self, action: #selector(secondModalAction), for: .touchUpInside)
        return product
    }()

    
    lazy var endBtn: UIButton = {
        let btn = UIButton()
        let yourAttributes : [NSAttributedStringKey: Any] = [
            NSAttributedStringKey.font : UIFont.systemFont(ofSize: 17),
            NSAttributedStringKey.foregroundColor : UIColor.white,
            ]
        let attributeString = NSMutableAttributedString(string: "Произвести списание",
                                                        attributes: yourAttributes)
        btn.setAttributedTitle(attributeString, for: .normal)
        btn.layer.cornerRadius = 3
        btn.backgroundColor = UIColor.aqua
        btn.addTarget(self, action: #selector(showModal), for: .touchUpInside)
        return btn
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
        self.modalView.isHidden = true
        self.firstModalView.isHidden = true
        self.secondModalView.isHidden = true
        tableView.separatorStyle = .none
        view.backgroundColor = UIColor.bgGray
        self.customView.addSubview(tableView)
        self.view.addSubViews(views: [searchBar,customView,endBtn])
        UIApplication.shared.keyWindow?.addSubview(modalView)
        modalView.addSubViews(views: [firstModalView,secondModalView])
        
        
    }
    // MARK: - Constraints
    func setupConstraints(){
        constrain(tableView,customView,searchBar,endBtn,modalView,firstModalView,secondModalView,view){tv,cv,sb,endBtn,modal,fModal,sModal,vw in

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
            
            endBtn.width == cv.width
            endBtn.height == 44
            endBtn.centerX == vw.centerX
            endBtn.top == cv.bottom + 5

            
            
            
            fModal.width == modal.width * 0.9
            fModal.height == modal.height * 0.4
            fModal.centerX == modal.centerX
            fModal.centerY == modal.centerY
            
            sModal.width == modal.width * 0.9
            sModal.height == modal.height * 0.3
            sModal.centerX == modal.centerX
            sModal.centerY == modal.centerY
   
        }
    }
    // MARK: - Setup Navigation Bar
    func setupNavigationBar() -> Void {
        navigationItem.leftBarButtonItem?.title = "Назад"
        navigationItem.title = "Итог"
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor:UIColor.navTitle]
    }
    @objc func showModal(){
        self.modalView.isHidden = false
        self.firstModalView.isHidden = false
        firstModalView.popUp(view: firstModalView)
    }
    @objc func firstModalAction(){
        
        self.secondModalView.isHidden = false
        secondModalView.popUp(view: secondModalView)
        self.firstModalView.isHidden = true
    }
    @objc func secondModalAction(){
        self.modalView.isHidden = true
        self.firstModalView.isHidden = true
        self.secondModalView.isHidden = true
        let vc = ProductTableViewController()
        vc.list = filteredGoods
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
        cell.layer.cornerRadius = 3
        cell.layer.borderColor = #colorLiteral(red: 0.9529411765, green: 0.9450980392, blue: 0.9450980392, alpha: 1)
        cell.layer.borderWidth = 1
        cell.backgroundColor = .none
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
extension UIView {
    func popUp(view : UIView){
        view.transform = CGAffineTransform(scaleX: 0.8, y: 1.2)
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0, options: [],  animations: {
            view.transform = .identity
        })
    }
    
}


