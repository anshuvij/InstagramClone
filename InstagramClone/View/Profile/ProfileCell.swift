//
//  ProfileCell.swift
//  InstagramClone
//
//  Created by Mobile Apps Team on 11/10/20.
//  Copyright © 2020 anshu vij. All rights reserved.
//

import UIKit


class ProfileCell : UICollectionViewCell {
    
    //MARK : - Properties
    
    private let postImageView : UIImageView = {
       let iv = UIImageView()
        iv.image = #imageLiteral(resourceName: "venom-7")
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        return iv
    }()
    
    
    //MARK : - LifeCycles
    
    override init (frame : CGRect) {
        super.init(frame : frame)
        backgroundColor = .lightGray
        
        addSubview(postImageView)
        postImageView.fillSuperview()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
