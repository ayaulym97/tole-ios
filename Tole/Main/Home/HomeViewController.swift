//
//  HomeViewController.swift
//  Tole
//
//  Created by Ayaulym Alzhan on 02.06.2018.
//  Copyright © 2018 Ayaulym Alzhan. All rights reserved.
//

import UIKit
import Charts
import Cartography

class HomeViewController: UIViewController {
    lazy var data : [Double] = [1,2,3,4]
    let hour = ["00-03","03-06","06-09","09-12","12-15","15-18","18-21","21-24"]
    let week = ["Mon","Tue","Wed","Thu","Fri","Sat","Sun"]
    let month = ["1","2","3","4"]
    let year = ["Jan" , "Feb", "Mar", "Apr", "May", "June", "July", "August", "Sept", "Oct", "Nov", "Dec"]
    let sales = [0,20,40,60,80,100,120]
    
    //MARK: UIinit
    var diagramView: LineChartView = {
        let v = LineChartView()
        v.backgroundColor = #colorLiteral(red: 0.9254901961, green: 0.9254901961, blue: 0.9254901961, alpha: 1)
        v.translatesAutoresizingMaskIntoConstraints = false
      
        return v
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setUpConstraints()
        
    }

    func setupViews(){
        self.navigationItem.hidesBackButton = true;
        self.view.addSubview(diagramView)
        
        
        view.backgroundColor = #colorLiteral(red: 0.9607843137, green: 0.9607843137, blue: 0.9607843137, alpha: 1)
        
    }
    
    func setUpConstraints(){
        constrain(view,diagramView) { (vw,dView) in
            dView.width == vw.width
            dView.height == vw.height*0.4
//            dView.top == dView.superview!.top + (self.navigationController?.navigationBar.frame.height)! + 20
      
            
            
        }
    }
    @objc private func goBtnAction() {
        
        
    }
    


}
