//
//  SignUpViewController.swift
//  instogram
//
//  Created by eros.chen on 2017/3/30.
//  Copyright © 2017年 Eros. All rights reserved.
//

import UIKit
import Firebase

class SignUpViewController: UIViewController {
    
    @IBOutlet weak var emailField: UITextField!
    
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var repeatPasswordField: UITextField!
    @IBAction func signUp(_ sender: Any) {
        signUp()
    }
    override func viewDidLoad() {
    
    }
    
    func signUp() {
        guard let email = emailField.text, let password = passwordField.text , let confirmPassword = repeatPasswordField.text else {
            print("資料錯誤")
            return
        }
        
        if password != confirmPassword {
            print("重複密碼錯誤")
            return
        }
        
        FIRAuth.auth()?.createUser(withEmail: email, password: password, completion: { (user, error) in
            guard let user = user else {
                print("註冊錯誤")
                print("ERROR:\(error)")
                return
            }
            
            print("使用者\(user.email)註冊成功")
            
        })
        
    }

    @IBAction func backToSignInTap(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
   
}
