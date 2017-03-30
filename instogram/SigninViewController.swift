//
//  SigninViewController.swift
//  instogram
//
//  Created by Eros on 2017/3/27.
//  Copyright © 2017年 Eros. All rights reserved.
//

import UIKit
import Firebase

class SigninViewController: UIViewController {

    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    
    @IBAction func SignInBtnClick(_ sender: Any) {
        signIn()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
    }
    
    override func viewDidLoad() {
        print("使用者已經登入 : \(FIRAuth.auth()?.currentUser)")

    }
    
    func signIn(){
        guard let email = emailField.text, let password = passwordField.text else {
            print("Email 或密碼錯誤")
            return
        }
        
        FIRAuth.auth()?.signIn(withEmail: email, password: password, completion: { (user, error) in
            guard let user = user else {
                print("登入錯誤")
                print("ERROR:\(error)")
                return
            }
            
            print("使用者\(user.email)登入成功")
            
        })
    }
    
    
}
