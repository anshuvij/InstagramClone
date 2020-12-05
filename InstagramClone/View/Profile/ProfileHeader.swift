//
//  ProfileHeader.swift
//  InstagramClone
//
//  Created by Mobile Apps Team on 11/10/20.
//  Copyright © 2020 anshu vij. All rights reserved.
//

import UIKit
import SDWebImage

protocol ProfileHeaderDelegate : class{
    func header( _ profileHeader : ProfileHeader, didTapActionButtonFor user : User)
//    func header( _ profileHeader : ProfileHeader, wantsToUnFollow uid : String)
//    func headerWantsToShowEditProfile( _ profileHeader : ProfileHeader)
}
class ProfileHeader : UICollectionReusableView {
    
    //MARK: - Properties
    
    var viewModel : ProfileHeaderViewModel? {
        didSet {
            configure()
        }
    }
    weak var delegate : ProfileHeaderDelegate?
    
    private let prodfileImageView : UIImageView = {
       let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.backgroundColor = .lightGray
        return iv
    }()
    
    private let nameLabel : UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 14)
        return label
    }()
    
    private lazy var editProfile : UIButton = {
       
        let button = UIButton(type: .system)
        button.setTitle("Loading", for: .normal)
        button.layer.cornerRadius = 3.0
        button.layer.borderColor = UIColor.lightGray.cgColor
        button.layer.borderWidth = 0.5
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        button.setTitleColor(.black, for: .normal)
        button.addTarget(self, action: #selector(handleEditProfileFollowTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var postLabel : UILabel = {
       let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .center
        return  label
    }()
    
    private lazy var followersLabel : UILabel = {
       let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .center
        return  label
    }()
    
    private lazy var followingLabel : UILabel = {
       let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .center
        return  label
    }()
    
    
       let gridbutton : UIButton = {
        let button = UIButton(type: .system)
        button.setImage(#imageLiteral(resourceName: "grid"), for: .normal)
        return button
        
    }()
    
    let listbutton : UIButton = {
        let button = UIButton(type: .system)
        button.setImage(#imageLiteral(resourceName: "list"), for: .normal)
        button.tintColor =  UIColor(white: 0, alpha: 0.2)
        return button
        
    }()
    
    let bookmarkbutton : UIButton = {
        let button = UIButton(type: .system)
        button.setImage(#imageLiteral(resourceName: "ribbon"), for: .normal)
        button.tintColor =  UIColor(white: 0, alpha: 0.2)
        return button
        
    }()
    
    
    
    //MARK: - LifeCycles
    
    override init (frame : CGRect) {
        super.init(frame : frame)
        
        backgroundColor = .white
        
        addSubview(prodfileImageView)
        prodfileImageView.anchor(top : topAnchor, left: leftAnchor, paddingTop:  16, paddingLeft: 12)
        prodfileImageView.setDimensions(height: 80, width: 80)
        prodfileImageView.layer.cornerRadius = 80 / 2
        
        addSubview(nameLabel)
        nameLabel.anchor(top:prodfileImageView.bottomAnchor,left: leftAnchor, paddingTop: 12, paddingLeft: 12)
        
        addSubview(editProfile)
        editProfile.anchor(top:nameLabel.bottomAnchor, left: leftAnchor, right:  rightAnchor, paddingTop:  16, paddingLeft: 24, paddingRight: 24)
        
        let stack = UIStackView(arrangedSubviews: [postLabel,followersLabel,followingLabel])
        stack.distribution = .fillEqually
        addSubview(stack)
        stack.centerY(inView: prodfileImageView)
        stack.anchor(left:prodfileImageView.rightAnchor, right: rightAnchor, paddingLeft: 12, paddingRight: 12, height: 50)
        
        let topDivider = UIView()
        topDivider.backgroundColor = .lightGray
        
        let bottomDivider = UIView()
        bottomDivider.backgroundColor = .lightGray
        
        
        let buttonStack =  UIStackView(arrangedSubviews: [gridbutton,listbutton,bookmarkbutton])
        buttonStack.distribution = .fillEqually
        addSubview(buttonStack)
        addSubview(topDivider)
        addSubview(bottomDivider)
        
        buttonStack.anchor(left: leftAnchor, bottom: bottomAnchor, right:  rightAnchor, height: 50)
        
        topDivider.anchor(top:buttonStack.topAnchor,left: leftAnchor,right: rightAnchor,height: 0.5)
        
        bottomDivider.anchor(top:buttonStack.bottomAnchor,left: leftAnchor,right: rightAnchor,height: 0.5)
        
        
        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Actions
    
    @objc func handleEditProfileFollowTapped()
    {
        guard let viewModel = viewModel  else { return}
        delegate?.header(self, didTapActionButtonFor: viewModel.user)
        
    }
    
     // MARK: - Helpers
    
    func configure()
    {
        guard let viewModel = viewModel else{ return}
        nameLabel.text = viewModel.fullname
        prodfileImageView.sd_setImage(with: viewModel.profileImageUrl)
        
        editProfile.setTitle(viewModel.followButtonText, for: .normal)
        editProfile.backgroundColor = viewModel.followButtonBackgroundColor
        editProfile.setTitleColor(viewModel.followButtonTextColor, for: .normal)
        postLabel.attributedText = viewModel.numberOfPosts
        followersLabel.attributedText = viewModel.numberOfFollowers
        followingLabel.attributedText = viewModel.numberOfFollowing
        
    }
}
