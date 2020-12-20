//
//  PostService.swift
//  InstagramClone
//
//  Created by Mobile Apps Team on 12/5/20.
//  Copyright © 2020 anshu vij. All rights reserved.
//

import UIKit
import Firebase

struct PostService {
    
    static func uploadPost(caption : String, image : UIImage, user : User , completion : @escaping(FirestoreCompletion)) {
        
        guard let uid = Auth.auth().currentUser?.uid else { return }
        
        ImageUploader.uploadImage(image: image) { (imageUrl) in
            let data = ["caption" : caption, "timestamp" : Timestamp(date : Date()), "likes" : 0, "imageUrl": imageUrl, "ownerUid" : uid, "ownerImageUrl" : user.profileImageUrl, "ownerUsername":user.username] as [String: Any]
            
            COLLECTION_POSTS.addDocument(data: data, completion: completion)
            
        }
        
        
    }
    
    static func fetchPosts(completion : @escaping ([Posts]) -> Void)
    {
        COLLECTION_POSTS.getDocuments { (snapshot, error) in
            guard let documents = snapshot?.documents else  { return}
            let posts = documents.map({ Posts(postId: $0.documentID, dictonary: $0.data()) })
            completion(posts)
            
        }
    }
}
