//
//  AuthService.swift
//  InstagramClone
//
//  Created by Mobile Apps Team on 11/10/20.
//  Copyright © 2020 anshu vij. All rights reserved.
//

import UIKit
import Firebase

struct AuthCredentials {
    let email : String
    let password : String
    let fullname : String
    let username : String
    let profileImage : UIImage
}

struct AuthService {
    
    static func logUserIn(withEmail email : String, password : String, completion : AuthDataResultCallback?)
    {
        Auth.auth().signIn(withEmail: email, password: password, completion: completion)
    }
    static func registerUser(withCredentials : AuthCredentials, completion : @escaping(Error?)->Void) {
        ImageUploader.uploadImage(image: withCredentials.profileImage) { (imageUrl) in
            Auth.auth().createUser(withEmail: withCredentials.email, password: withCredentials.password) { (results, error) in
                
                if let error = error {
                    print("DEBUG:Failed to register user \(error.localizedDescription)")
                    return
                }
                guard let uid = results?.user.uid else { return}
                
                let data : [String : Any] = ["email":withCredentials.email, "fullname" : withCredentials.fullname,"profileImageUrl" : imageUrl, "uid" : uid, "username":withCredentials.username]
                
                COLLECTION_USERS.document(uid).setData(data, completion: completion)
                
                
            }
        }
        
    }
}
