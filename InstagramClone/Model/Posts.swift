//
//  Posts.swift
//  InstagramClone
//
//  Created by Mobile Apps Team on 12/7/20.
//  Copyright © 2020 anshu vij. All rights reserved.
//

import Firebase

struct Posts {
    var caption : String
    var likes : Int
    let imageUrl: String
    let ownerUid : String
    let timestamp : Timestamp
    let postId : String
    let ownerImageUrl : String
    let ownerUsername: String
    
    init(postId : String,dictonary : [String:Any]) {
        self.postId = postId
        self.caption = dictonary["caption"] as? String ?? ""
        self.likes = dictonary["likes"] as? Int ?? 0
        self.imageUrl = dictonary["imageUrl"] as? String ?? ""
        self.ownerUid = dictonary["ownerUid"] as? String ?? ""
        self.timestamp = dictonary["timestamp"] as? Timestamp ?? Timestamp(date: Date())
        self.ownerImageUrl = dictonary["ownerImageUrl"] as? String ?? ""
        self.ownerUsername = dictonary["ownerUsername"] as? String ?? ""
        
    }
    
    
    
}
