//
//  UploadPostController.swift
//  InstagramClone
//
//  Created by Mobile Apps Team on 11/18/20.
//  Copyright © 2020 anshu vij. All rights reserved.
//

import UIKit

class UploadPostController : UIViewController {
    
    //MARK: - Properties
    
    private let photoImageView : UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.image = #imageLiteral(resourceName: "venom-7")
        iv.clipsToBounds = true
        
        return iv
    }()
    
    private lazy var captionTextView : InputTextView = {
        
        let tv = InputTextView()
        tv.placeholderText = "Enter caption.."
        tv.font = UIFont.systemFont(ofSize: 16)
        tv.delegate = self
        return tv
    }()
    
    private let characterCountLabel :UILabel = {
        let label = UILabel()
        label.textColor = .lightGray
        label.font = UIFont.systemFont(ofSize: 14.0)
        label.text = "0/100"
        return label
    }()
    
    //MARK: - Lifecycles
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    
    //MARK: - Actions
    
    @objc func didTapCancel() {
        
    }
    @objc func didTapShare() {
        
    }
    
    //MARK: - Helpers
    
    func checkMaxLength(_ textview:UITextView) {
        
        if (textview.text.count) > 100 {
            textview.deleteBackward()
        }
        
    }
    
    func configureUI()
    {
        view.backgroundColor = .white
       
        navigationItem.title = "Upload Post"
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(didTapCancel))
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Share", style: .done, target: self, action: #selector(didTapShare))
        
        view.addSubview(photoImageView)
        photoImageView.setDimensions(height: 180, width: 180)
        photoImageView.anchor(top:view.safeAreaLayoutGuide.topAnchor,paddingTop: 8)
        photoImageView.centerX(inView: view)
        photoImageView.layer.cornerRadius = 10.0
        
        view.addSubview(captionTextView)
        captionTextView.anchor(top:photoImageView.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor,paddingTop: 16,paddingLeft: 12,paddingRight: 12,height: 64)
        
        view.addSubview(characterCountLabel)
        characterCountLabel.anchor(bottom:captionTextView.bottomAnchor, right: view.rightAnchor,paddingBottom: -8, paddingRight: 12)

    }
    
   
}

//MARK: - UITextViewDelegate

extension UploadPostController : UITextViewDelegate {
    
    func textViewDidChange(_ textView: UITextView) {
        checkMaxLength(textView)
        let count = textView.text.count
        characterCountLabel.text = "\(count)/100"
    }
}