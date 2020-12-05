//
//  User.swift
//  InstagramClone
//
//  Created by Mobile Apps Team on 11/10/20.
//  Copyright © 2020 anshu vij. All rights reserved.
//

import Foundation
import Firebase

struct User {
    let email : String
    let fullname : String
    let profileImageUrl : String
    let username : String
    let uid : String
    
    var isFollowed = false
    var stats : UserStats!
    
    var isCurrentUser : Bool { return Auth.auth().currentUser?.uid == uid}
    
    init(dictonary : [String:Any]) {
        self.email = dictonary["email"] as? String ?? ""
        self.fullname = dictonary["fullname"] as? String ?? ""
        self.profileImageUrl = dictonary["profileImageUrl"] as? String ?? ""
        self.username = dictonary["username"] as? String ?? ""
        self.uid = dictonary["uid"] as? String ?? ""
        self.stats = UserStats(following: 0, followers: 0)
    }
    

}

struct UserStats {
    let following : Int
    let followers : Int
    //let posts : Int
}
