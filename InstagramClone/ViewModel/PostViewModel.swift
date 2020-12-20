//
//  PostViewModel.swift
//  InstagramClone
//
//  Created by Mobile Apps Team on 12/7/20.
//  Copyright © 2020 anshu vij. All rights reserved.
//

import Foundation


struct PostViewModel {
    
    private let post : Posts
    
    var imageUrl : URL? {
        return URL(string: post.imageUrl)
    }
    
    var caption : String {
        return post.caption
    }
    
    var likes : Int {
        return post.likes
    }
    
    var likesLabelText : String {
        
        if post.likes != 1 {
            return "\(post.likes) likes"
        }
        else
        {
            return "\(post.likes) like"
        }
    }
    
    var userProfileImageUrl : URL? {
        return URL(string: post.ownerImageUrl)
    }
    
    var userProfileName : String {
        return post.ownerUsername
    }
    
    
    init(post : Posts) {
        self.post = post
    }
    
    
}
