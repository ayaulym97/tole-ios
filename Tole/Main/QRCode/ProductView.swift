
import UIKit
import Cartography
class ProductView: UIView {
    var hide = true
    var cur = 0;
    lazy var mainView: UIView = {
        let v = UIView()
        v.layer.cornerRadius = 3
        v.layer.borderWidth = 2
        v.layer.borderColor = #colorLiteral(red: 0.9529411765, green: 0.9450980392, blue: 0.9450980392, alpha: 1)
        v.backgroundColor = UIColor.white
        return v
    }()
    lazy var upView: UIView = {
        let v = UIView()
        v.layer.cornerRadius = 3
        v.layer.borderWidth = 2
        v.layer.borderColor = #colorLiteral(red: 0.9529411765, green: 0.9450980392, blue: 0.9450980392, alpha: 1)
        v.backgroundColor = UIColor.white
        return v
    }()
    lazy var downView: UIView = {
        let v = UIView()
        v.layer.cornerRadius = 3
        v.layer.borderWidth = 2
        v.layer.borderColor = #colorLiteral(red: 0.9529411765, green: 0.9450980392, blue: 0.9450980392, alpha: 1)
        v.backgroundColor = UIColor.white
        return v
    }()
    lazy var productTitle: UILabel = {
        let label = UILabel(frame: .zero)
        label.font = UIFont.systemFont(ofSize: 18)
        label.textColor = #colorLiteral(red: 0.2901960784, green: 0.2901960784, blue: 0.2901960784, alpha: 1)
        label.text = ""
        return label
    }()
    
    lazy var price: UILabel = {
        let label = UILabel(frame: .zero)
        label.font = UIFont.systemFont(ofSize: 17)
        label.textColor = .lightGray
        label.text = ""
        return label
    }()
    
    lazy var pCount: UILabel = {
        let label = UILabel(frame: .zero)
        label.font = UIFont.systemFont(ofSize: 17)
        label.textColor = .lightGray
        label.text = ""
        label.textAlignment = .right
        return label
    }()
    lazy var plusBtn: UIButton = {
        let btn = UIButton()
        btn.setBackgroundImage(#imageLiteral(resourceName: "plus"), for: .normal)
        btn.imageEdgeInsets = UIEdgeInsetsMake(10, 10, 10, 10)
        btn.addTarget(self, action: #selector(add), for: .touchUpInside)
        return btn
    }()
    lazy var minusBtn: UIButton = {
        let btn = UIButton()
        btn.setBackgroundImage(#imageLiteral(resourceName: "minus"), for: .normal)
     
        btn.imageEdgeInsets = UIEdgeInsetsMake(10, 10, 10, 10)
        btn.addTarget(self, action: #selector(drop), for: .touchUpInside)
        return btn
    }()
    

    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.white
        setupView()
        setupConstraints()

    }

    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    @objc func add(){
        cur = Int(pCount.text!)!
        self.pCount.text = String(cur + 1);
       
        
    }
    @objc func drop(){
        cur = Int(pCount.text!)!
        self.pCount.text = String(cur - 1);
    }
 
    
    
    func setupView(){
        self.addSubViews(views: [mainView,upView,downView])
        self.mainView.addSubViews(views: [productTitle,price,pCount])
        self.upView.addSubview(plusBtn)
        self.downView.addSubview(minusBtn)
    }
    
    func setupConstraints(){
        constrain(mainView,upView,downView,productTitle, price, pCount,plusBtn,minusBtn,self){ main,up,down,pt,pl,cl,pB,mB,cv in
            main.width == cv.width * 0.78
            main.height == cv.height
            main.centerY == cv.centerY
            main.top == cv.top
            main.left == cv.left
            
            pt.width == main.width
            pt.height == main.height * 0.5
            pt.left == main.left + 10
            pt.top == main.top
            
            pl.width == main.width * 0.4
            pl.left == main.left + 10
            pl.top == pt.bottom + 5
            
            cl.width == pl.width
            cl.left == pl.right
            cl.top == pt.bottom + 5
            
            up.top == cv.top
            up.width == cv.width * 0.2
            up.height == cv.height * 0.5
            up.left == main.right + 3
            
            down.width == up.width
            down.height == up.height
            down.top == up.bottom
            down.left == main.right + 3
            
            pB.width == up.width
            pB.height == up.height
            pB.centerX == up.centerX
            pB.centerY == up.centerY
            pB.top == up.top
            
            
            mB.width == down.width
            mB.height == down.height
            mB.centerX == down.centerX
            mB.centerY == down.centerY
            mB.top == down.top
         
            
            
 
            
            
            
        }
    }
}
