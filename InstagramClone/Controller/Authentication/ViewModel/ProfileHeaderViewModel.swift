//
//  ProfileHeaderViewModel.swift
//  InstagramClone
//
//  Created by Mobile Apps Team on 11/10/20.
//  Copyright © 2020 anshu vij. All rights reserved.
//

import Foundation
import UIKit

struct ProfileHeaderViewModel {
    
    let user : User
    
    init(user : User) {
        self.user = user
    }
    
    var fullname : String {
        return user.fullname
    }
    var profileImageUrl : URL? {
        return URL(string:  user.profileImageUrl)
           
    }
    
    var followButtonText : String {
        
        if user.isCurrentUser {
            return "Edit Profile"
        }
        return user.isFollowed ? "Following" : "Follow"
    }
    
    var followButtonBackgroundColor : UIColor {
        return user.isCurrentUser ? .white : .systemBlue
    }
    
    var followButtonTextColor : UIColor {
        return user.isCurrentUser ? .black : .white
    }
    var numberOfFollowers : NSAttributedString {
        return attributedStatText(value: user.stats.followers, label: "followers")
    }
    
    var numberOfFollowing : NSAttributedString {
         return attributedStatText(value: user.stats.following, label: "following")
    }
    
    var numberOfPosts : NSAttributedString {
         return attributedStatText(value: 5, label: "posts")
    }
    
    func attributedStatText(value : Int, label : String)->NSAttributedString {
        let attributedText = NSMutableAttributedString(string: "\(value)\n", attributes: [.font : UIFont.boldSystemFont(ofSize: 14)])
        
        attributedText.append(NSAttributedString(string: label, attributes: [.font : UIFont.systemFont(ofSize: 14), .foregroundColor : UIColor.lightGray]))
        
        return attributedText
    }
}
