//
//  UserService.swift
//  InstagramClone
//
//  Created by Mobile Apps Team on 11/10/20.
//  Copyright © 2020 anshu vij. All rights reserved.
//

import Foundation
import Firebase

typealias FirestoreCompletion = (Error?) ->Void
struct UserService {
    
    static func fetchUser(completion : @escaping(User)->Void) {
        
        guard let uid = Auth.auth().currentUser?.uid else {return}
        COLLECTION_USERS.document(uid).getDocument { (snapshots, error) in
            
            print("DEBUG: Snapshot is \(snapshots?.data())")
            
            guard let dictionary = snapshots?.data() else {return}
            
            let user  = User(dictonary: dictionary)
            completion(user)
        }
    }
    
    static func fetchUsers(completion : @escaping([User]) ->Void)
    {
        COLLECTION_USERS.getDocuments { (snapshot, error) in
            guard let snapshot = snapshot else {return}
            
            let users = snapshot.documents.map({User(dictonary: $0.data())})
            completion(users)
        }
    }
    
    static func followUser(uid: String, completion : @escaping (FirestoreCompletion))
    {
        guard let currentUid = Auth.auth().currentUser?.uid else { return}
        COLLECTION_FOLLOWING.document(currentUid).collection("user-following").document(uid).setData([:]) { (error) in
            COLLECTION_FOLLOWERS.document(uid).collection("user-followers").document(currentUid).setData([:], completion: completion)
        }
    }
    
    static func unfollowUser(uid: String, completion : @escaping (FirestoreCompletion))
    {
        guard let currentUid = Auth.auth().currentUser?.uid else { return}
        COLLECTION_FOLLOWING.document(currentUid).collection("user-following").document(uid).delete { (error) in
            COLLECTION_FOLLOWERS.document(uid).collection("user-followers").document(currentUid).delete(completion: completion)
        }
        
    }
    
    static func checkIfUserIsFollowed(uid : String, completion : @escaping(Bool)->Void)
    {
        guard let currentUid = Auth.auth().currentUser?.uid else { return}
        COLLECTION_FOLLOWING.document(currentUid).collection("user-following").document(uid).getDocument { (snapshot, error) in
            guard let isFollowed = snapshot?.exists else { return}
            completion(isFollowed)
        }
    }
    
    static func fetchUserStats(uid : String, completion : @escaping(UserStats)->Void){
        
        COLLECTION_FOLLOWERS.document(uid).collection("user-followers").getDocuments { (snapshot, _) in
            let followers = snapshot?.documents.count ?? 0
            
            COLLECTION_FOLLOWERS.document(uid).collection("user-following").getDocuments { (snapshot, _) in
                let following = snapshot?.documents.count ?? 0
                
                completion(UserStats(following: following, followers: followers))
            }
        }
        
        
    }
}
