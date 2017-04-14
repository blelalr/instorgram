//
//  Post.swift
//  instogram
//
//  Created by Eros on 2017/4/4.
//  Copyright © 2017年 Eros. All rights reserved.
//

import Foundation
import SwiftyJSON

class Post {
    var authorUID: String? = nil
    var email: String? = nil
    var imagePath: String? = nil
    var imageURL: String? = nil
    var postDate: Int = Int(round(Date().timeIntervalSince1970 * 1000))
    var postDateReverse: Int = -Int(round(Date().timeIntervalSince1970 * 1000))
    
    func toDictionary(from: Post) -> [String: Any]{
        
        let dic: [String: Any] = [
            "authorUID": from.authorUID!,
            "email": from.email!,
            "imagePath":from.imagePath!,
            "imageURL":from.imageURL!,
            "postDate":from.postDate,
            "postDateReverse":from.postDateReverse,
        ]

        return dic
    }
}
