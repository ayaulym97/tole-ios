//
//  ViewController.swift
//  SampleBarCode
//
//  Created by Ayaulym Alzhan on 6/06/18.
//  Copyright © 2018 Ayaulym Alzhan. All rights reserved.
//

import UIKit
import AVFoundation
import Cartography

class ScannerViewController: UIViewController,AVCaptureMetadataOutputObjectsDelegate {
    
    var videoCaptureDevice: AVCaptureDevice = AVCaptureDevice.default(for: AVMediaType.video)!
    var device = AVCaptureDevice.default(for: AVMediaType.video)
    var output = AVCaptureMetadataOutput()
    var previewLayer: AVCaptureVideoPreviewLayer?
    
    var captureSession = AVCaptureSession()
    var code: String?
    
    lazy var scannedCode:UILabel = {
        let l = UILabel()
        l.translatesAutoresizingMaskIntoConstraints = false
        l.textColor = UIColor.white
        l.font = UIFont.systemFont(ofSize: 17.7 / 736 * UIScreen.main.bounds.height)
        l.textAlignment = .center
        l.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        l.text = "Scanning...."
        return l
    }()
    var searchView:UIView = {
        let v = UIView()
        v.backgroundColor = UIColor.white
        return v
    }()
    var QRView:UIView = {
        let v = UIView()
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupCamera()
        self.setUpView()
        self.setUpConstraints()

    }
    
    private func setupCamera() {
        
        let input = try? AVCaptureDeviceInput(device: videoCaptureDevice)
        
        if self.captureSession.canAddInput(input!) {
            self.captureSession.addInput(input!)
        }
        
        self.previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        
        if let videoPreviewLayer = self.previewLayer {
            videoPreviewLayer.videoGravity = AVLayerVideoGravity.resizeAspectFill
            videoPreviewLayer.frame = self.view.bounds
            QRView.layer.addSublayer(videoPreviewLayer)
        }
        
        let metadataOutput = AVCaptureMetadataOutput()
        if self.captureSession.canAddOutput(metadataOutput) {
            self.captureSession.addOutput(metadataOutput)
            
            metadataOutput.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
            metadataOutput.metadataObjectTypes = [AVMetadataObject.ObjectType.upce, AVMetadataObject.ObjectType.code39, AVMetadataObject.ObjectType.code39Mod43, AVMetadataObject.ObjectType.ean13, AVMetadataObject.ObjectType.ean8, AVMetadataObject.ObjectType.code93, AVMetadataObject.ObjectType.code128, AVMetadataObject.ObjectType.pdf417, AVMetadataObject.ObjectType.qr, AVMetadataObject.ObjectType.aztec]
            
        } else {
            print("Could not add metadata output")
        }
    }
    private func setUpView(){
        self.navigationItem.hidesBackButton = true;
        self.view.addSubview(searchView)
        self.view.addSubview(QRView)
        QRView.addSubview(scannedCode)
    }

    func  setUpConstraints(){
        constrain(view,scannedCode,searchView,QRView) { (vw,sc,search,qr) in
            sc.bottom == vw.bottom - 60
            sc.leading == vw.leading + 20
            sc.trailing == vw.trailing - 20
            sc.height == 50
            
            search.top == vw.top + 30
            search.width == vw.width
            search.height == vw.height * 0.3
            
            qr.width == vw.width
            qr.height == vw.height * 0.7
            qr.top == search.bottom
            
        }
    
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if (captureSession.isRunning == false) {
            captureSession.startRunning();
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        if (captureSession.isRunning == true) {
            captureSession.stopRunning();
        }
    }
    
    func metadataOutput(_ captureOutput: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
        // This is the delegate'smethod that is called when a code is readed
        
        print(metadataObjects)
        for metadata in metadataObjects {
            let readableObject = metadata as! AVMetadataMachineReadableCodeObject
            let code = readableObject.stringValue
            scannedCode.text = code
            
        }
    }
}




