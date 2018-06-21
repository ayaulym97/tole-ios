//
//  File.swift
//  Tole
//
//  Created by Nazhmeddin Babakhanov on 6/6/18.
//  Copyright © 2018 Beknar Danabek. All rights reserved.
//

import UIKit
import Cartography

class HomeCell: UITableViewCell {
    
    // MARK: - Properties
    lazy var leftDescription: UILabel = {
        let textView = UILabel()
        textView.font = UIFont(name: "Helvetica", size: 14)
        textView.textColor = #colorLiteral(red: 0.4756349325, green: 0.4756467342, blue: 0.4756404161, alpha: 1)
        textView.textAlignment = .left
        return textView
    }()
    
    lazy var rightDescription:UILabel = {
        let textView = UILabel()
        textView.font = UIFont(name: "Helvetica", size: 14)
        textView.textColor = UIColor.aqua
        textView.textAlignment = .right
        return textView
    }()
    
    lazy var ViewLine: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.gray.withAlphaComponent(0.5)
        return view
    }()
    
    lazy var View:UIView  = {
        let  v = UIView()
        v.backgroundColor = .white
        return v
    }()
    
    
    // MARK: - Lifecycle
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
        addCustomConstraints()
        self.isUserInteractionEnabled = false
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        View.addSubViews(views: [ leftDescription,rightDescription])
        self.addSubViews(views: [View,ViewLine])
        
    }
    
    // MARK: - Constraints
    private func addCustomConstraints() {
        constrain(leftDescription,rightDescription,ViewLine,View){ leftDescription,rightDescription,ViewLine,View in
            View.width == View.superview!.width/1.2
            View.height == View.superview!.width/9
            View.centerX == View.superview!.centerX
            leftDescription.width == leftDescription.superview!.width/2
            rightDescription.width == rightDescription.superview!.width/2
            
            leftDescription.centerY == leftDescription.superview!.centerY
            rightDescription.centerY == rightDescription.superview!.centerY
            leftDescription.left == leftDescription.superview!.left
            distribute(horizontally: leftDescription,rightDescription)
            ViewLine.width == ViewLine.superview!.width
            ViewLine.height == 0.1
            ViewLine.right == ViewLine.superview!.right
            distribute(by: 5, vertically: View,ViewLine)
            
        }
        
    }
    
    
}
