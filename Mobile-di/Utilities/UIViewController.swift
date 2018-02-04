//
//  UIViewController.swift
//  Mobile-di
//
//  Created by Raghavendra Shedole on 04/02/18.
//  Copyright © 2018 Raghavendra Shedole. All rights reserved.
//

import Foundation
import UIKit


class AlertViewController: NSObject {
    static let share = AlertViewController()
    func showAlertView(title:String,message:String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
        
        if let nav = UIApplication.shared.keyWindow?.rootViewController as? UINavigationController {
            nav.visibleViewController?.present(alert, animated: true, completion: nil)
        }
    }
}
