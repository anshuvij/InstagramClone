//
//  UserCellViewModel.swift
//  InstagramClone
//
//  Created by Mobile Apps Team on 11/10/20.
//  Copyright © 2020 anshu vij. All rights reserved.
//

import Foundation


struct UserCellViewModel {
    
    private let user : User
    
    var profileImageUrl : URL? {
        return URL(string: user.profileImageUrl)
    }
    var username : String {
        return user.username
    }
    var fullname : String {
        return user.fullname
    }
    
    init(user : User)
    {
        self.user = user
    }
}
