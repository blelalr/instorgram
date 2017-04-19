//
//  Comment.swift
//  instogram
//
//  Created by Eros on 2017/4/4.
//  Copyright © 2017年 Eros. All rights reserved.
//

import Foundation

class Comment {
    var authorUID: String?
    var email: String?
    var message: String?
    
    init() {
        authorUID = nil
        email = nil
        message = nil
    }
    
    func toDictionary(from: Comment) -> [String: Any]{
        
        let dic: [String: Any] = [
            "authorUID": from.authorUID!,
            "email": from.email!,
            "message":from.message!,
            ]
        
        return dic
    }

}
