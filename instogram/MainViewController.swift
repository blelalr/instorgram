//
//  MainViewController.swift
//  instogram
//
//  Created by Eros on 2017/3/27.
//  Copyright © 2017年 Eros. All rights reserved.
//

import UIKit
import Firebase

class MainViewController: UIViewController {
    @IBAction func SignOutTap(_ sender: Any) {
        try! FIRAuth.auth()?.signOut()
    }
    
   
}
