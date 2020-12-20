//
//  FeedController.swift
//  InstagramClone
//
//  Created by Mobile Apps Team on 11/9/20.
//  Copyright © 2020 anshu vij. All rights reserved.
//

import UIKit
import Firebase

private let reuseIdentifer = "Cell"
class FeedController : UICollectionViewController{
    
    //MARK : - LifeCycle
    
    private var posts = [Posts]()
    override func viewDidLoad() {
        super.viewDidLoad()
       configureUI()
        fetchPosts()
    }
    
    // MARK : Actions
    
    @objc func handleLogout()
    {
        do {
            try
                Auth.auth().signOut()
            let controller = LoginController()
            controller.delegate = self.tabBarController as? MainTabController
            let nav = UINavigationController(rootViewController: controller)
            nav.modalPresentationStyle = .fullScreen
            self.present(nav, animated: true, completion: nil)
        }catch {
            print("DEBUG : Failed to sign out")
        }
    }
    
    //MARK: - APIs
    
    func fetchPosts()
    {
        PostService.fetchPosts{ posts in
            self.posts = posts
            self.collectionView.reloadData()
        }
    }
    
    // MARK: - Helpers
    
    func configureUI()
    {
         collectionView.backgroundColor = .white
        collectionView.register(FeedCell.self, forCellWithReuseIdentifier: reuseIdentifer)
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Logout", style: .plain, target: self, action: #selector(handleLogout))
        navigationItem.title = "Feed"
    }
}

//MARK: - UICollectionviewDataSource
extension FeedController {
 
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return posts.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifer, for: indexPath) as! FeedCell
        cell.viewModel = PostViewModel(post: posts[indexPath.row])
        
        return cell
    }
    
    
}
//MARK: - UICollectionViewDelegateFlowLayout

extension FeedController : UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = view.frame.width
        var height = width + 8 + 40 + 8
        height +=  50
        height += 60
        return CGSize(width: width, height: height)
        
    }
    
}
