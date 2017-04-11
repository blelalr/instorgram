//
//  PhotoCellDataSource.swift
//  instogram
//
//  Created by Eros on 2017/4/4.
//  Copyright © 2017年 Eros. All rights reserved.
//
import UIKit

extension UIImageView {
    func downloadImageFrom(url: URL, contentMode: UIViewContentMode) {
        debugPrint(url)
        URLSession.shared.dataTask( with: url, completionHandler: {
            (data, response, error) -> Void in
            if let error = error{
            print("\(error)")
            }
            DispatchQueue.main.async {
                self.contentMode =  contentMode
                if let data = data { self.image = UIImage(data: data) }
            }
        }).resume()
    }
}

class PhotoCell: UITableViewCell{
    @IBOutlet weak var accountLabel: UILabel!
    @IBOutlet weak var postImage: UIImageView!
    @IBOutlet weak var messageLabel: UILabel!
}

class PhotoCellDataSource: NSObject, UITableViewDelegate, UITableViewDataSource {
    var Posts = [Post]()
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return Posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "photoCell") as! PhotoCell
        cell.accountLabel.text = Posts[indexPath.row].authorUID
        cell.messageLabel.text = Posts[indexPath.row].email
        cell.postImage.image = UIImage(named: "placeholder")
        cell.postImage.downloadImageFrom(url: Posts[indexPath.row].imageURL!, contentMode: UIViewContentMode.scaleAspectFill)
        
        return cell
    }
    
}

