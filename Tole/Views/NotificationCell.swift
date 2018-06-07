//
//  NotificationCell.swift
//  Tole
//
//  Created by Nurbek Ismagulov on 11.03.18.
//  Copyright © 2018 Beknar Danabek. All rights reserved.
//

import Foundation
import Cartography

class NotificationCell: UITableViewCell{
    
    lazy var cellView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.red
        view.layer.cornerRadius = 2 / 736 * UIScreen.main.bounds.height
        view.clipsToBounds = true
        return view
    }()
    lazy var leftLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.notificationLeftLabel
        label.font = UIFont.systemFont(ofSize: 17.7 / 736 * UIScreen.main.bounds.height)
        label.textAlignment = .center
        return label
    }()
    
    lazy var rightLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.notificationRightLabel
        label.font = UIFont.systemFont(ofSize: 14 / 736 * UIScreen.main.bounds.height)
        label.textAlignment = .center
        return label
    }()
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
    }
    
    func setup() {
        addSubview(cellView)
        addSubview(leftLabel)
        addSubview(rightLabel)
        constrain(cellView, self) { cellView, view in
            cellView.left == view.left
            cellView.top == view.top
            cellView.bottom == view.bottom
            cellView.width == 3 / 414 * UIScreen.main.bounds.width
        }
        constrain(leftLabel, cellView, self) { leftLabel, cellView, view in
            leftLabel.left == cellView.right + (11 / 414 * UIScreen.main.bounds.width)
            leftLabel.centerY == view.centerY
            //            leftLabel.height == 50 / 736 * UIScreen.main.bounds.height
            //            leftLabel.width == 150 / 414 * UIScreen.main.bounds.width
            
        }
        constrain(rightLabel, self) { rightLabel, view in
            rightLabel.right == view.right - (20 / 414 * UIScreen.main.bounds.width)
            rightLabel.centerY == view.centerY
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError(Constant.cellInitError)
    }
}
