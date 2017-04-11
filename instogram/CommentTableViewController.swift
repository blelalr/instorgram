//
//  CommentTableViewController.swift
//  instogram
//
//  Created by Eros on 2017/4/4.
//  Copyright © 2017年 Eros. All rights reserved.
//

import UIKit

class CommentTableViewController: UITableViewController {
    var dataSource = CommentCellDataSource()
    var Comments = [Comment](){
        didSet{
            DispatchQueue.main.async {
               self.tableView.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        tableView.dataSource = dataSource
        tableView.delegate = self
    }
}
