import UIKit
import AVFoundation
import Cartography


protocol someDelegate {
    func valueLable(update : Any)
}
class ScannerVC: UIViewController, AVCaptureMetadataOutputObjectsDelegate {
    var delegate : someDelegate?
    lazy var products:[String:[String]] = ["4870002235078" : ["ALBENI","15$","1"],"4870112001365" : ["COCOCOLA","10$","2"]]
    var filteredProducts: [ProductModel] = []
    var isScanned: Bool = true
    var barcode = ""
    
    var captureDevice:AVCaptureDevice?
    var videoPreviewLayer:AVCaptureVideoPreviewLayer?
    var captureSession:AVCaptureSession?
  
    //MARK:UIinit
    lazy var codeFrame:UIView = {
        let codeFrame = UIView()
        codeFrame.layer.borderColor = UIColor.green.cgColor
        codeFrame.layer.borderWidth = 2
        codeFrame.frame = CGRect.zero
        codeFrame.translatesAutoresizingMaskIntoConstraints = false
        return codeFrame
    }()
    lazy var upFrame:UIView = {
        let upFrame = UIView()
        upFrame.backgroundColor = UIColor.white
        upFrame.translatesAutoresizingMaskIntoConstraints = false
        return upFrame
    }()
    
    lazy var downFrame:UIView = {
        let downFrame = UIView()
        downFrame.translatesAutoresizingMaskIntoConstraints = false
        return downFrame
    }()
    
    lazy var searchBar: UISearchBar = {
        let search = UISearchBar(frame: .zero)
        search.placeholder = Constant.goodsSearchBarPlaceHolder
        search.delegate = self
        search.backgroundColor = .white
        search.searchBarStyle = UISearchBarStyle.minimal
        
        return search
    }()
    lazy var productCard: ProductView = {
        let product = ProductView()
        product.layer.borderColor = #colorLiteral(red: 0.9254901961, green: 0.9254901961, blue: 0.9294117647, alpha: 1)
        product.layer.borderWidth = 1.0
        product.layer.cornerRadius = 3
        product.layer.shadowColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        product.layer.shadowOpacity = 0.6
        product.layer.masksToBounds = true
        product.backgroundColor = .white
        product.translatesAutoresizingMaskIntoConstraints = false
        return product
    }()
    lazy var scanImage:UIImageView = {
        let image = UIImageView(image: UIImage(named:"scan"))
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    lazy var endBtn: UIButton = {
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
        btn.addTarget(self, action: #selector(goBtnAction), for: .touchUpInside)
        
        return btn
    }()
   
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        productCard.isHidden = isScanned
        scanner()
        setUpView()
        setUpConstraints()
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        videoPreviewLayer!.frame = downFrame.bounds
        let swipeDown = UISwipeGestureRecognizer(target: self, action:#selector(ScannerVC.swipeDown))
        swipeDown.direction = UISwipeGestureRecognizerDirection.right
        self.view.addGestureRecognizer(swipeDown)
    }
    // MARK: - Inital Setup
    func setUpView(){
        self.view.addSubViews(views: [upFrame,downFrame])
        upFrame.addSubViews(views: [searchBar])
        downFrame.addSubViews(views: [codeFrame,scanImage,endBtn,productCard])
    }
    //MARK: constraints
    func setUpConstraints(){
        
        constrain(view,upFrame,downFrame,searchBar,codeFrame,productCard,scanImage,endBtn) { (vw,up,down,searchB,codeF,card,scan,end) in
            
            up.top == vw.top + 60
            up.width == vw.width
            up.height == vw.height * 0.1
        
            down.width == up.width
            down.height == vw.height * 0.7
            down.centerX == vw.centerX
            down.top == up.bottom

            searchB.width == up.width * 0.9
            searchB.top == up.top + 5
            searchB.centerX == up.centerX
            searchB.height == up.height
            
            card.width == down.width * 0.9
            card.height == down.height * 0.2
            card.top == down.top + 5
            card.centerX == down.centerX
            
            codeF.centerY == down.centerY
            codeF.centerX == down.centerX
            codeF.width == down.width * 0.5
            
            scan.centerX == down.centerX
            scan.centerY == down.centerY
            scan.width == down.width * 0.8
            scan.height == down.height * 0.5
            
            end.width == down.width * 0.9
            end.height == 44
            end.centerX == down.centerX
            end.top == scan.bottom + 10
            
        
        }
        
    }
    @objc func swipeDown(){
        productCard.isHidden = true
        captureSession?.startRunning()
    }
    @objc func goBtnAction(){
       // delegate?.valueLable(update: filteredProducts)
        
        let vc = ScannedTableViewController()
        vc.filteredGoods = filteredProducts
        self.navigationController?.pushViewController(vc, animated: true)
        
       
   
    }
    
    func scanner() {
        captureDevice = AVCaptureDevice.default(for: .video)
        if let captureDevice = captureDevice {
            
            do {
                let input = try AVCaptureDeviceInput(device: captureDevice)
                
                captureSession = AVCaptureSession()
                guard let captureSession = captureSession else { return }
                captureSession.addInput(input)
                
                let captureMetadataOutput = AVCaptureMetadataOutput()
                captureSession.addOutput(captureMetadataOutput)
                
                captureMetadataOutput.setMetadataObjectsDelegate(self, queue: .main)
                captureMetadataOutput.metadataObjectTypes = [.code128, .qr, .ean13,  .ean8, .code39] //AVMetadataObject.ObjectType
                
                captureSession.startRunning()
                
                videoPreviewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
                videoPreviewLayer?.videoGravity = .resizeAspectFill
                
                downFrame.layer.addSublayer(videoPreviewLayer!)
                
            } catch {
                print("Error Device Input")
            }
            
        }
    }
    
    
    
    func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
        if metadataObjects.count == 0 {
            //print("No Input Detected")
            codeFrame.frame = CGRect.zero
            return
        }
        
        let metadataObject = metadataObjects[0] as! AVMetadataMachineReadableCodeObject
        
        guard let stringCodeValue = metadataObject.stringValue else { return }
        
        downFrame.addSubview(codeFrame)
        
        guard let barcodeObject = videoPreviewLayer?.transformedMetadataObject(for: metadataObject) else { return }
        codeFrame.frame = barcodeObject.bounds
        
        
        // Stop capturing and hence stop executing metadataOutput function over and over again
        
        captureSession?.stopRunning()
        
        // Call the function which performs navigation and pass the code string value we just detected
        displayDetailsViewController(scannedCode: stringCodeValue)
        
    }
    
    func displayDetailsViewController(scannedCode: String) {
        print("BARCODE: "+scannedCode)
        isScanned = true
        productCard.isHidden = isScanned
        barcode = scannedCode
        if  products.keys.contains(barcode){
            print("THIS IS KEY" )
            productCard.productTitle.text = products[barcode]![0]
            productCard.price.text = products[barcode]![1]
            productCard.pCount.text = products[barcode]![2]
            productCard.isHidden = false
            
        }
        else{
            print("ERROR" )
        }

        filteredProducts.append(ProductModel(productTitle: products[barcode]![0], price: products[barcode]![1], count: products[barcode]![2]))
       
        print(filteredProducts)
     
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if (captureSession?.isRunning == false) {
            captureSession?.startRunning()
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        if (captureSession?.isRunning == true) {
            captureSession?.stopRunning()
        }
    }
    
}


//MARK: - extension UISearchBar
extension ScannerVC: UISearchBarDelegate{
    
}




