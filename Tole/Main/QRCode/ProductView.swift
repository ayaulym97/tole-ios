
import UIKit
import Cartography
class ProductView: UIView {
   
    lazy var productTitle: UILabel = {
        let label = UILabel(frame: .zero)
        label.font = UIFont.systemFont(ofSize: 18)
        label.textColor = #colorLiteral(red: 0.2901960784, green: 0.2901960784, blue: 0.2901960784, alpha: 1)
        return label
    }()
    
    lazy var price: UILabel = {
        let label = UILabel(frame: .zero)
        label.font = UIFont.systemFont(ofSize: 17)
        label.textColor = .lightGray
        return label
    }()
    
    lazy var pCount: UILabel = {
        let label = UILabel(frame: .zero)
        label.font = UIFont.systemFont(ofSize: 17)
        label.textColor = .lightGray
        label.textAlignment = .right
        return label
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        setupConstraints()
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView(){
        self.addSubViews(views: [productTitle,price,pCount])
    }
    
    func setupConstraints(){
        constrain(productTitle, price, pCount,self){ pt,pl,cl,cv in
            pt.width == cv.width
            pt.height == cv.height * 0.5
            pt.left == cv.left + 10
            pt.top == cv.top
            
            pl.width == cv.width * 0.45
            pl.left == cv.left + 10
            pl.top == pt.bottom + 5
            
            cl.width == pl.width
            cl.left == pl.right
            cl.top == pt.bottom + 5
            
        }
    }
}
