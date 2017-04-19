//
//  CommentTableViewController.swift
//  instogram
//
//  Created by Eros on 2017/4/4.
//  Copyright © 2017年 Eros. All rights reserved.
//

import UIKit

class CommentCell: UITableViewCell{
    
    @IBOutlet weak var accountLabel: UILabel!
    @IBOutlet weak var commentLabel: UILabel!
}

class CommentViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate{
    @IBOutlet weak var commentView: UIView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var commentViewBottom: NSLayoutConstraint!
    
    var Comments = [Comment](){
        didSet{
            DispatchQueue.main.async {
               self.tableView.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(CommentViewController.keyboardWillHide(notification:)))
        view.addGestureRecognizer(tap)
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        NotificationCenter.default.addObserver(self, selector: #selector(CommentViewController.keyboardWillShow(notification:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
    }
    
    // MARK: - Keyboard
    func keyboardWillShow(notification:NSNotification) {
        DispatchQueue.main.async(execute: {
            let info:NSDictionary = notification.userInfo! as NSDictionary
            let kbSize = (info.object(forKey: UIKeyboardFrameBeginUserInfoKey) as AnyObject).cgRectValue.size
            self.commentViewBottom.constant = kbSize.height + 5
            
        })
    }
    
    func keyboardWillHide(notification: NSNotification) {
        DispatchQueue.main.async(execute: {
            self.view.endEditing(true)
            self.commentViewBottom.constant = 50
        })
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        DispatchQueue.main.async(execute: {
            self.view.endEditing(true)
            self.commentViewBottom.constant = 50
        })
        return true
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Comments.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cemmentCell") as! CommentCell
        
        return cell
    }

    
}
