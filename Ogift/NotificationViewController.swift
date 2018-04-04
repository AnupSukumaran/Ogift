//
//  NotificationViewController.swift
//  Ogift
//
//  Created by Sukumar Anup Sukumaran on 14/02/18.
//  Copyright © 2018 AssaRadviewTech. All rights reserved.
//

import UIKit

class NotificationViewController: UIViewController {
    
    override var preferredStatusBarStyle : UIStatusBarStyle {
        return .lightContent
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
          UIApplication.shared.statusBarView?.backgroundColor = #colorLiteral(red: 1, green: 0.1490196078, blue: 0, alpha: 1)

       
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
       
    }
    

    

}
