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
import BetterSegmentedControl

class HomeViewController: UIViewController {
    
    // MARK: - preperty
    var array:[String] = ["Продажи","Продано","Прибыль","Товары в обороте"]
    var array1:[String] = ["45 895 тг","45","5 454 тг","2655 тг"]
    
    let months = ["Jan", "Feb", "Mar", "Apr", "May", "Jun"]
    let unitsSold = [50.0, 25.0, 50.0, 75.0, 100.0, 75.0]
    
    
    lazy var diagramView: LineChartView = {
        let v = LineChartView()
        //  v.data = ChartData.init(dataSet: IChartDataSet.)
        return v
    }()
    
    lazy var table:UITableView = {
        let table = UITableView()
        table.isScrollEnabled = false
        table.delegate = self
        table.dataSource = self
        table.separatorStyle = .none
        table.register(HomeCell.self, forCellReuseIdentifier: "myCell")
        table.translatesAutoresizingMaskIntoConstraints = false
        return table
    }()
    
    lazy var sigmentConstroller:BetterSegmentedControl = {
        let control1 = BetterSegmentedControl(
            frame: CGRect(x: 35.0, y: 40.0, width: 200.0, height: 30.0),
            titles: ["День", "Неделя", "Месяц","Год"],
            index: 0,
            options:[.backgroundColor(.white),
                     .titleColor(.lightGray),
                     .indicatorViewBackgroundColor(#colorLiteral(red: 0.3568627451, green: 0.7490196078, blue: 0.8, alpha: 1)),
                     .selectedTitleColor(.white),
                     .cornerRadius(20),
                     .titleFont(UIFont(name: "HelveticaNeue-Medium", size: 13.0)!),
                     .selectedTitleFont(UIFont(name: "HelveticaNeue-Medium", size: 13.0)!),
                     .bouncesOnChange(false)])
        return control1
    }()
    
    // MARK: - lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.hidesBackButton = true;
        setupViews()
        
        let populationData :[Int : Double] = [
            2000 : 2345,
            2005 : 25000 ,
            2014 : 343456.0
        ]
        
        let ySeries = populationData.map { x, y in
            return ChartDataEntry(x: Double(x), y: y)
        }
        
        let data = LineChartData()
        let dataset = LineChartDataSet(values: ySeries, label: "All")
        dataset.colors = [NSUIColor.red]
        data.addDataSet(dataset)
        
        let gradientColors = [UIColor.aqua.cgColor,
                              UIColor.aqua.withAlphaComponent(0.3).cgColor]
        let gradient = CGGradient(colorsSpace: nil, colors: gradientColors as CFArray, locations: nil)!
        
        dataset.fillAlpha = 1
        dataset.fill = Fill(linearGradient: gradient, angle: 90) //.linearGradient(gradient, angle: 90)
        dataset.drawFilledEnabled = true
        
        
        self.diagramView.data = data
        self.diagramView.chartDescription?.text = "LineChartView"
        setupNavigations()
    }
    
    // MARK: - functions
    func setupViews(){
        self.view.addSubViews(views: [sigmentConstroller,table,diagramView])
        self.view.backgroundColor = UIColor.background
        constrain(sigmentConstroller,table,diagramView){sigmentConstroller,table,diagramView in
            
            diagramView.top == diagramView.superview!.top
            diagramView.width == diagramView.superview!.width
            diagramView.height == diagramView.superview!.height/2.3
            
            sigmentConstroller.width == sigmentConstroller.superview!.width
            sigmentConstroller.height == sigmentConstroller.superview!.width/8
            sigmentConstroller.center == sigmentConstroller.superview!.center
            
            table.centerX == table.superview!.centerX
            table.top == sigmentConstroller.bottom + 50
            table.width == table.superview!.width/1.3
            table.height == table.superview!.height/4
        }
    }
    
    func setupNavigations(){
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.black]
        self.title = "Показатели"
    }
    
}

// MARK: - UITableViewDelegate, UITableViewDataSource
extension HomeViewController:UITableViewDelegate,UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return array.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "myCell", for: indexPath) as! HomeCell
        cell.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        cell.leftDescription.text = array[indexPath.row]
        cell.rightDescription.text = array1[indexPath.row]
        return cell
    }
    
    
    
    
}
