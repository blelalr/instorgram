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

    let email: String? = "aaa@gmail.com"
    let password: String? = "aaaaaa"
    let confirmPassword: String? = "aaaaaa"
    
    override func viewDidLoad() {
        print("使用者已經登入 : \(FIRAuth.auth()?.currentUser)")
        //Logout
//        try! FIRAuth.auth()?.signOut()
        
//        signIn()
        
//        signUp()
    }
    
    func signIn(){
        guard let email = email, let password = password else {
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
    
    func signUp() {
        guard let email = email, let password = password , let confirmPassword = confirmPassword else {
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

}
