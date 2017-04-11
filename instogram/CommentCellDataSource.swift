//
//  CommentCellDataSource.swift
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

class CommentCellDataSource: NSObject, UITableViewDelegate, UITableViewDataSource {
    var Comments = [Comment]()
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Comments.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cemmentCell") as! CommentCell
        
        return cell
    }
    
}
