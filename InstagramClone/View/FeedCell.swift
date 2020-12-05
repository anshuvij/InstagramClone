//
//  FeedCell.swift
//  InstagramClone
//
//  Created by Mobile Apps Team on 11/9/20.
//  Copyright © 2020 anshu vij. All rights reserved.
//

import UIKit

class FeedCell : UICollectionViewCell {
    
    //MARK - Properties
    
    
    private let profileImageView : UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.isUserInteractionEnabled = true
        iv.image = #imageLiteral(resourceName: "venom-7")
        return iv
    }()
    
    private lazy var usernameButton : UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("venom", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 13)
        button.addTarget(self, action: #selector(didTapUserName), for: .touchUpInside)
        return button
    }()
    
    private let postImageView : UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.isUserInteractionEnabled = true
        iv.image = #imageLiteral(resourceName: "venom-7")
        return iv
    }()
    
    private lazy var likeButton : UIButton = {
        let button = UIButton(type: .system)
        button.setImage(#imageLiteral(resourceName: "like_unselected"), for: .normal)
        button.tintColor = .black
        return button
    }()
    
    private lazy var commentButton : UIButton = {
        let button = UIButton(type: .system)
        button.setImage(#imageLiteral(resourceName: "comment"), for: .normal)
        button.tintColor = .black
        return button
    }()
    
    private lazy var shareBUtton : UIButton = {
        let button = UIButton(type: .system)
        button.setImage(#imageLiteral(resourceName: "send2"), for: .normal)
        button.tintColor = .black
        return button
    }()
    
    private let likesLabel : UILabel = {
       let label = UILabel()
        label.text = "1 Like"
        label.font = UIFont.boldSystemFont(ofSize: 14)
        return label
    }()
    
    private let captionLabel : UILabel = {
       let label = UILabel()
        label.text = "some text captions"
        label.font = UIFont.systemFont(ofSize: 14)
        return label
    }()
    
    private let postTimeLabel : UILabel = {
       let label = UILabel()
        label.text = "2 days ago"
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = .lightGray
        return label
    }()
    
   
    
    //MARK - Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame : frame)
        backgroundColor = .white
        addSubview(profileImageView)
        profileImageView.anchor(top: topAnchor, left: leftAnchor, paddingTop: 12, paddingLeft: 12)
        profileImageView.setDimensions(height: 40, width: 40)
        profileImageView.layer.cornerRadius = 40/2
        
        addSubview(usernameButton)
        usernameButton.centerY(inView: profileImageView, leftAnchor: profileImageView.rightAnchor, paddingLeft: 8)
        
        addSubview(postImageView)
        postImageView.anchor(top : profileImageView.bottomAnchor, left: leftAnchor, right: rightAnchor, paddingTop: 8)
        postImageView.heightAnchor.constraint(equalTo: widthAnchor, multiplier: 1).isActive = true
        
        configureActionButtons()
        
        addSubview(likesLabel)
        likesLabel.anchor(top:likeButton.bottomAnchor,left: leftAnchor,paddingTop: -4,paddingLeft: 8)
        
        addSubview(captionLabel)
        captionLabel.anchor(top:likesLabel.bottomAnchor,left: leftAnchor,paddingTop: 8,paddingLeft: 8)
        
         addSubview(postTimeLabel)
        postTimeLabel.anchor(top:captionLabel.bottomAnchor,left: leftAnchor,paddingTop: 8,paddingLeft: 8)
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    //MARK - Actions
    
    @objc func didTapUserName()
    {
        print("tap ussrname")
    }
    
    // MARK : - Helpers
    
    func configureActionButtons()
    {
        let stackView =  UIStackView(arrangedSubviews: [likeButton,commentButton,shareBUtton])
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        addSubview(stackView)
        stackView.anchor(top:postImageView.bottomAnchor,width: 120, height: 50)
    }
}