//
//  AddAndSaleProductViewController.swift
//  Tole-app
//
//  Created by MacBook on 08.03.2018.
//  Copyright © 2018 Beknar Danabek. All rights reserved.
//

import UIKit
import Cartography
import AVFoundation

class AddAndSaleProductViewController: UIViewController,AVCaptureMetadataOutputObjectsDelegate {
    
     // MARK: - Properties
    
    var captureSession: AVCaptureSession!
    var previewLayer: AVCaptureVideoPreviewLayer!
    
    lazy var globalView:UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    lazy var AddAndSaleProduct:UIView = {
        let view = UIView()
        view.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var AddProduct:UIButton = {
        let button = UIButton()
        button.setTitle(Constant.addProduct, for: .normal)
        button.titleLabel?.font = UIFont(name: "Helvetica", size: self.view.frame.height/38)
        button.backgroundColor = .white
        button.addTarget(self, action: #selector(AddProductClicked), for: .touchUpInside)
        button.setTitleColor(#colorLiteral(red: 0.2901960784, green: 0.2901960784, blue: 0.2901960784, alpha: 1), for: .normal) 
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    lazy var SaleProduct:UIButton = {
        let button = UIButton()
        button.setTitle(Constant.saleProduct, for: .normal)
        button.titleLabel?.font = UIFont(name: "Helvetica", size: self.view.frame.height/38)
        button.addTarget(self, action: #selector(SaleProductClicked), for: .touchUpInside)
        button.setTitleColor(#colorLiteral(red: 0.2901960784, green: 0.2901960784, blue: 0.2901960784, alpha: 1), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    lazy var TopViewBottom:UIView = {
        let view = UIView()
        view.backgroundColor = #colorLiteral(red: 0.8907147646, green: 0.884118855, blue: 0.895762682, alpha: 1)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var TopViewBottom1:UIView = {
        let view = UIView()
        view.backgroundColor = #colorLiteral(red: 0.8907147646, green: 0.884118855, blue: 0.895762682, alpha: 1)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var bottomView:UIView = {
        let view = UIView()
        view.backgroundColor = #colorLiteral(red: 0.2901960784, green: 0.2901960784, blue: 0.2901960784, alpha: 1)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var bottomView1:UIView = {
        let view = UIView()
        view.backgroundColor = #colorLiteral(red: 0.2901960784, green: 0.2901960784, blue: 0.2901960784, alpha: 1)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var AddButton:UIButton = {
        let botton = UIButton()
        botton.setTitle(Constant.add, for: .normal)
        botton.backgroundColor = #colorLiteral(red: 0.3058823529, green: 0.7294117647, blue: 0.7803921569, alpha: 1)
        botton.setTitleColor(#colorLiteral(red: 0.9607843137, green: 0.9607843137, blue: 0.9647058824, alpha: 1), for: .normal)
        botton.layer.cornerRadius = 5
        botton.translatesAutoresizingMaskIntoConstraints = false
        return botton
    }()
    
    lazy var EndButton:UIButton = {
        let botton = UIButton()
        botton.setTitle(Constant.finish, for: .normal)
        botton.backgroundColor = #colorLiteral(red: 0.3058823529, green: 0.7294117647, blue: 0.7803921569, alpha: 1)
        botton.setTitleColor(#colorLiteral(red: 0.9607843137, green: 0.9607843137, blue: 0.9647058824, alpha: 1), for: .normal)
        botton.layer.cornerRadius = 5
        botton.translatesAutoresizingMaskIntoConstraints = false
        return botton
    }()
    
    lazy var ScannerQr:UIImageView = {
        let image = UIImageView()
        image.image = #imageLiteral(resourceName: "qrcode")
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()

    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        captureSessionSetUp()
        previewLayerSetUps()
        setUpViews()
        setUpViewsConstrains()
        AddProductClicked()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if (captureSession?.isRunning == false) {
            captureSession.startRunning()
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        if (captureSession?.isRunning == true) {
            captureSession.stopRunning()
        }
    }
    
    // MARK: - PreviewLayer
    
    func previewLayerSetUps(){
        previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        previewLayer.frame.size.height = view.frame.height - (self.navigationController?.navigationBar.frame.height)!
        previewLayer.frame.size.width = view.frame.width
        previewLayer.videoGravity = .resizeAspectFill
        captureSession.startRunning()
    }
    
    // MARK: - CaptureSession
    
    func captureSessionSetUp(){
        captureSession = AVCaptureSession()
        guard let videoCaptureDevice = AVCaptureDevice.default(for: .video) else { return }
        let videoInput: AVCaptureDeviceInput
        
        do {
            videoInput = try AVCaptureDeviceInput(device: videoCaptureDevice)
        } catch {
            return
        }
        
        if (captureSession.canAddInput(videoInput)) {
            captureSession.addInput(videoInput)
        } else {
            captureSessionFailed()
            return
        }
        
        let metadataOutput = AVCaptureMetadataOutput()
        
        if (captureSession.canAddOutput(metadataOutput)) {
            captureSession.addOutput(metadataOutput)
            metadataOutput.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
            metadataOutput.metadataObjectTypes = [.qr]
        } else {
            captureSessionFailed()
            return
        }
    }
    
    func captureSessionFailed() {
        let ac = UIAlertController(title: Constant.scanningNotSupported, message: Constant.deviseNotSupported, preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: Constant.okText, style: .default))
        present(ac, animated: true)
        captureSession = nil
    }

    func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
        captureSession.stopRunning()
        if let metadataObject = metadataObjects.first {
            guard let readableObject = metadataObject as? AVMetadataMachineReadableCodeObject else { return }
            guard let stringValue = readableObject.stringValue else { return }
            AudioServicesPlaySystemSound(SystemSoundID(kSystemSoundID_Vibrate))
            found(code: stringValue)
        }
        dismiss(animated: true)
    }

    func found(code: String) {
        print(code)
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .portrait
    }
    
    // MARK: - Inital Setup
    
    func setUpViews(){
        self.globalView.layer.addSublayer(previewLayer)
        self.view.addSubview(globalView)
        self.globalView.addViews([AddButton,EndButton,AddAndSaleProduct,ScannerQr,TopViewBottom,TopViewBottom1])
        self.AddAndSaleProduct.addViews([AddProduct,SaleProduct])
        self.AddProduct.addViews([bottomView,bottomView1])
    }

    // MARK: - Constraints
    
    func setUpViewsConstrains(){
       
        constrain(AddAndSaleProduct,AddProduct,SaleProduct,bottomView,ScannerQr,AddButton,EndButton,globalView){AddAndSaleProduct,AddProduct,SaleProduct,bottomView,ScannerQr,AddButton,EndButton,globalView in
            
            globalView.height == globalView.superview!.height - (self.navigationController?.navigationBar.frame.height)!
            globalView.width == globalView.superview!.width
            globalView.top == globalView.superview!.top + (self.navigationController?.navigationBar.frame.height)! + 20
            
            AddAndSaleProduct.height == AddAndSaleProduct.superview!.height/14
            AddAndSaleProduct.width == AddAndSaleProduct.superview!.width
            AddAndSaleProduct.top == AddAndSaleProduct.superview!.top
            
            AddProduct.leading == AddProduct.superview!.leading
            AddProduct.top == AddAndSaleProduct.top
            AddProduct.width == AddProduct.superview!.width/2
            AddProduct.height == AddProduct.superview!.height
            
            SaleProduct.trailing == SaleProduct.superview!.trailing
            SaleProduct.top == AddAndSaleProduct.top
            SaleProduct.width == SaleProduct.superview!.width/2
            SaleProduct.height == SaleProduct.superview!.height
            
            ScannerQr.centerX == ScannerQr.superview!.centerX
            ScannerQr.centerY == ScannerQr.superview!.centerY
            ScannerQr.height == ScannerQr.superview!.height/3.5
            ScannerQr.width == ScannerQr.superview!.width*0.9
            
            AddButton.height == AddAndSaleProduct.superview!.height/12
            AddButton.width == AddButton.superview!.width - 50
            AddButton.centerX == ScannerQr.superview!.centerX
            AddButton.bottom == AddButton.superview!.bottom - (self.navigationController?.navigationBar.frame.height)! - 20
            
//            AddButton.bottom == AddButton.superview!.bottom - (self.tabBarController?.tabBar.frame.height)!
            
            EndButton.height == AddAndSaleProduct.superview!.height/12
            EndButton.width == AddButton.superview!.width - 50
            EndButton.centerX == ScannerQr.superview!.centerX
            EndButton.bottom == AddButton.superview!.bottom - (self.navigationController?.navigationBar.frame.height)! - 20
            
//            AddButton.bottom == AddButton.superview!.bottom - (self.tabBarController?.tabBar.frame.height)!
        }
        
        constrain(bottomView1,SaleProduct,TopViewBottom1){bottomView1,SaleProduct,TopViewBottom1 in
            bottomView1.top == SaleProduct.bottom
            bottomView1.height == 3
            bottomView1.width == SaleProduct.width
            bottomView1.trailing == SaleProduct.trailing
            
            TopViewBottom1.height == 1
            TopViewBottom1.width == SaleProduct.width
            TopViewBottom1.top == SaleProduct.top
            TopViewBottom1.trailing == SaleProduct.trailing
        }
        
        constrain(bottomView,AddProduct,TopViewBottom){bottomView,AddProduct,TopViewBottom in
            bottomView.top == AddProduct.bottom
            bottomView.height == 3
            bottomView.width == AddProduct.width
            
            TopViewBottom.height == 1
            TopViewBottom.width == AddProduct.width
            TopViewBottom.top == AddProduct.top
        }
        
    }
    
    // MARK: - Add and Sale click

    @objc func AddProductClicked(){
        SaleProduct.backgroundColor = .clear
        AddProduct.backgroundColor = #colorLiteral(red: 0.9195513129, green: 0.9140850306, blue: 0.923753202, alpha: 1)
        bottomView.isHidden = false
        TopViewBottom.isHidden = false

        bottomView1.isHidden = true
        TopViewBottom1.isHidden = true
        EndButton.isHidden = true
        AddButton.isHidden = false
    }
    
    @objc func SaleProductClicked(){
        AddProduct.backgroundColor = .clear
        SaleProduct.backgroundColor = #colorLiteral(red: 0.9195513129, green: 0.9140850306, blue: 0.923753202, alpha: 1)
        bottomView1.isHidden = false
        TopViewBottom1.isHidden = false

        bottomView.isHidden = true
        TopViewBottom.isHidden = true
        AddButton.isHidden = true
        EndButton.isHidden = false
    }
}

extension UIView {
    func addViews(_ array:[UIView]){
        for i in array{
            self.addSubview(i)
        }
    }
}
