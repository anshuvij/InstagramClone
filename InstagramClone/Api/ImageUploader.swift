//
//  ImageUploader.swift
//  InstagramClone
//
//  Created by Mobile Apps Team on 11/10/20.
//  Copyright © 2020 anshu vij. All rights reserved.
//

import FirebaseStorage

struct ImageUploader {
    
    static func uploadImage(image:UIImage, completion : @escaping(String)->Void)
    {
        guard let imageData = image.jpegData(compressionQuality:0.75) else {return}
        let filename = NSUUID().uuidString
        let ref = Storage.storage().reference(withPath: "/profile_images/\(filename)")
        ref.putData(imageData, metadata: nil) { (metadata, error) in
            if let error = error {
                print("DEBUG: Failed to upload \(error.localizedDescription)")
            }
            
            ref.downloadURL { (url, error) in
                guard let imageUrl = url?.absoluteString else {return}
                completion(imageUrl)
            }
        }
    }
}
