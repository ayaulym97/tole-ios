import UIKit
import Cartography

class ProductTableViewController: UIViewController,takeDelegate {
    lazy var list:[ProductModel] = []
    var sum : Int = 0
    var num : Int = 0
    func take(update:Any) {
        list = update as! [ProductModel]
    }
    func substract() {
        if  sum == Int(cashModalView.sumField.text!) as! Int{
            let sub = sum - num
            if(num == (Int(cashModalView.sumValue.text!))!  ){
                 cashModalView.surrenderLabel.text = "Сдача" + "\(sub)"
            }
        }
    }
    
    //MARK: - UIinit
    lazy var tableView: UITableView = {
        let table = UITableView(frame: .zero)
        table.delegate = self
        table.dataSource = self
        table.register(UITableViewCell.self, forCellReuseIdentifier: "productCell")
        return table
    }()
    
    lazy var customView: UIView = {
        let view = UIView(frame: .zero)
        view.backgroundColor =  UIColor.yellow
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
    lazy var cashModalView: CashModal = {
        let product = CashModal()
        product.layer.borderColor = #colorLiteral(red: 0.9254901961, green: 0.9254901961, blue: 0.9294117647, alpha: 1)
        product.layer.borderWidth = 1.0
        product.layer.cornerRadius = 3
        product.layer.masksToBounds = true
        product.translatesAutoresizingMaskIntoConstraints = false
       
        return product
    }()
    lazy var printModalView: SecondModal = {
        let product = SecondModal()
        product.layer.borderColor = #colorLiteral(red: 0.9254901961, green: 0.9254901961, blue: 0.9294117647, alpha: 1)
        product.layer.borderWidth = 1.0
        product.layer.cornerRadius = 3
        product.layer.masksToBounds = true
        product.translatesAutoresizingMaskIntoConstraints = false
        product.commentLabel.text = "Распечатано"
        let yourAttributes : [NSAttributedStringKey: Any] = [
            NSAttributedStringKey.font : UIFont.systemFont(ofSize: 18),
            NSAttributedStringKey.foregroundColor : UIColor.white
        ]
        let attributeString = NSMutableAttributedString(string: "Вернуться назад",
                                                        attributes: yourAttributes)
        product.okBtn.setAttributedTitle(attributeString, for: .normal)
        product.okBtn.addTarget(self, action: #selector(printModalAction), for: .touchUpInside)
        return product
    }()
    

    
    lazy var cashBtn: UIButton = {
        let btn = UIButton()
        let yourAttributes : [NSAttributedStringKey: Any] = [
            NSAttributedStringKey.font : UIFont.systemFont(ofSize: 17),
            NSAttributedStringKey.foregroundColor : UIColor.white,
            ]
        let attributeString = NSMutableAttributedString(string: "Наличными",
                                                        attributes: yourAttributes)
        btn.setAttributedTitle(attributeString, for: .normal)
        btn.layer.cornerRadius = 3
        btn.backgroundColor = UIColor.aqua
        btn.addTarget(self, action: #selector(showModal), for: .touchUpInside)
        return btn
    }()
    lazy var creditBtn: UIButton = {
        let btn = UIButton()
        let yourAttributes : [NSAttributedStringKey: Any] = [
            NSAttributedStringKey.font : UIFont.systemFont(ofSize: 17),
            NSAttributedStringKey.foregroundColor : UIColor.white,
            ]
        let attributeString = NSMutableAttributedString(string: "В долг",
                                                        attributes: yourAttributes)
        btn.setAttributedTitle(attributeString, for: .normal)
        btn.layer.cornerRadius = 3
        btn.backgroundColor = UIColor.aqua
       // btn.addTarget(self, action: #selector(), for: .touchUpInside)
        return btn
    }()
    lazy var printOutBtn: UIButton = {
        let btn = UIButton()
        let yourAttributes : [NSAttributedStringKey: Any] = [
            NSAttributedStringKey.font : UIFont.systemFont(ofSize: 17),
            NSAttributedStringKey.foregroundColor : UIColor.white,
            ]
        let attributeString = NSMutableAttributedString(string: "Распечать",
                                                        attributes: yourAttributes)
        btn.setAttributedTitle(attributeString, for: .normal)
        btn.layer.cornerRadius = 3
        btn.backgroundColor = UIColor.aqua
        btn.addTarget(self, action: #selector(printModal), for: .touchUpInside)
        return btn
    }()
    override func viewDidAppear(_ animated: Bool) {
        substract()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupConstraints()
        setupNavigationBar()
    }

    //MARK: - Initial Setup
    func setupViews(){
        self.modalView.isHidden = true
        self.cashModalView.isHidden = true
        self.printModalView.isHidden = true
        self.printOutBtn.isHidden = true
//        printModalView.commentLabel.text = "Распечатано"
        
        cashModalView.okBtn.addTarget(self, action: #selector(ready), for: .touchUpInside)
        cashModalView.cancel.addTarget(self, action: #selector(hideModal), for: .touchUpInside)
        UIApplication.shared.keyWindow?.addSubview(modalView)
        modalView.addSubViews(views: [cashModalView,printModalView])
        self.customView.addSubview(tableView)
        self.view.addSubViews(views: [customView,cashBtn,creditBtn,printOutBtn])
        print(self.view.frame.width)
        view.backgroundColor = UIColor.bgGray
        
    }
    // MARK: - Constraints
    func setupConstraints(){
        constrain(customView,cashModalView,modalView,tableView,cashBtn,creditBtn,printOutBtn,printModalView,view){ cv,cashModal,modal,tv,cash,credit,print,printModal,vw in
            
            
            cv.top == vw.top + 75
            cv.width == vw.width * 0.9
            cv.centerX == vw.centerX
            cv.height == vw.height * 0.65
            
            tv.top == cv.top
            tv.width == cv.width
            tv.height == cv.height
            tv.centerX == cv.centerX
            tv.centerY == cv.centerY
            
            cash.width == cv.width * 0.5
            cash.height == 44
            cash.left == cv.left
            cash.top == cv.bottom + 10
            
            credit.width == cash.width
            credit.height == 44
            credit.left == cash.right + 5
            credit.top == cv.bottom + 10
            
            print.top == cv.bottom + 10
            print.width == vw.width * 0.9
            print.centerX == vw.centerX
            print.height == 44
            
            cashModal.width == modal.width * 0.9
            cashModal.height == modal.height * 0.35
            cashModal.centerX == modal.centerX
            cashModal.centerY == modal.centerY
            
            printModal.width == modal.width * 0.9
            printModal.height == modal.height * 0.3
            printModal.centerX == modal.centerX
            printModal.centerY == modal.centerY

            
        }
    }
    @objc func showModal(){
        self.modalView.isHidden = false
        self.cashModalView.isHidden = false
        cashModalView.popUp(view: cashModalView)
    }
    @objc func hideModal(){
        self.modalView.isHidden = true
        self.cashModalView.isHidden = true
    }
    @objc func ready(){
        self.modalView.isHidden = true
        self.cashModalView.isHidden = true
        self.cashBtn.isHidden = true
        self.creditBtn.isHidden = true
        self.printOutBtn.isHidden = false
    }
    @objc func printModal(){
        self.modalView.isHidden = false
        self.printModalView.isHidden = false
    }
    @objc func printModalAction(){
        self.modalView.isHidden = true
        self.cashModalView.isHidden = true
        self.printModalView.isHidden = true
        let vc = ScannerVC()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    // MARK: - Setup Navigation Bar
    func setupNavigationBar() -> Void {
        //        print(self.view.frame.width)
        navigationItem.leftBarButtonItem?.title = "Назад"
        
        navigationItem.title = "Итог"
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor:UIColor.navTitle]
    }
}

// MARK: - extension UITableView
extension ProductTableViewController: UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell  = ProductTableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: Constant.goodsTableViewCellIdentifier)
        let selectedIndex = list[indexPath.row]
        cell.productTitle.text = selectedIndex.productTitle
        cell.sum.text = selectedIndex.price
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40
    }

    
}



