//
//  EmployeeTableViewModel.swift
//  Tole
//
//  Created by Nursultan on 05.04.2018.
//  Copyright © 2018 Beknar Danabek. All rights reserved.
//

import Foundation
import UIKit
struct EmployeeTableViewModel{
    
    func makeAlertView(mobileNumber: String, alertTextView: UITextView, alertViewBackground: UIView, alertView: UIView ){
        if mobileNumber != ""{
            alertTextView.text = Constant.alertTextViewBegin + "\(mobileNumber)" + Constant.alertTextViewEnd
            alertViewBackground.isHidden = false
            UIView.animate(withDuration: 0.5, animations: {
                alertView.alpha = 1
            })
            
        }

    }
    
    func removeAlertView(alertViewBackground: UIView, alertView: UIView){
        alertViewBackground.isHidden = true
        UIView.animate(withDuration: 0.5, animations: {
            alertView.alpha = 0
        })

    }
    
}
