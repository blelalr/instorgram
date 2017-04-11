//
//  Post.swift
//  instogram
//
//  Created by Eros on 2017/4/4.
//  Copyright © 2017年 Eros. All rights reserved.
//

import Foundation
import SwiftyJSON
//temp
let ArticlesURL = URL(string: "https://hpd-iosdev.firebaseio.com/news/latest.json")!
//temp

class Post {
    var authorUID: String?
    var email: String?
    var imagePath: String?
    var imageURL: URL?
    var postDate: Date

    init(rawData: JSON){
        authorUID = rawData["category"].string
        email = rawData["heading"].string
        imagePath = "IMAGEPATH"
        let urlString = rawData["imageUrl"].string!
        imageURL = URL(string: urlString)!
        let publishedDateMS = rawData["publishedDate"].double!
        postDate = Date(timeIntervalSince1970: publishedDateMS / 1000)
    }
    
    //temp
    class func downloadLatestArticles(completionHandler: @escaping ([Post]?, Error?) -> Void) {
        let session = URLSession.shared
        
        let task = session.dataTask(with: ArticlesURL) { data, response, error in
            if let error = error {
                print("下載新聞錯誤: \(error)")
                completionHandler(nil, error)
                return
            }
            
            if let jsonArray = JSON(data: data!).array {
                //                var articles = [Article]()
                //                for jsonObj in jsonArray {
                //                    let article = Article(rawData: jsonObj)
                //                    articles.append(article)
                //                }
                
                let articles = jsonArray.map { Post(rawData: $0) }
                
                completionHandler(articles, nil)
                //                self.articles = articles
                //                self.dataResource.articles = articles
                print("新聞下載完成！！")
            }
        }
        task.resume()
    }

}
