//
//  MainTabController.swift
//  InstagramClone
//
//  Created by Mobile Apps Team on 11/9/20.
//  Copyright © 2020 anshu vij. All rights reserved.
//

import UIKit
import Firebase
import YPImagePicker
class MainTabController : UITabBarController
{
    
    
    //MARK: - LifeCycle
    
    private var user : User? {
        didSet {
            guard let user = user else {
                return
            }
            configureViewController(withUser: user)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        checkIfUserIsLoggedIn()
        fetchUsers()
        self.delegate = self
      
    }
    
    //MARK : - API

    func checkIfUserIsLoggedIn()
    {
        if Auth.auth().currentUser == nil
        {
            DispatchQueue.main.async {
                let controller = LoginController()
                controller.delegate = self
                let nav = UINavigationController(rootViewController: controller)
                nav.modalPresentationStyle = .fullScreen
                self.present(nav, animated: true, completion: nil)
            }
        }
    }
    
    func fetchUsers()
       {
           UserService.fetchUser { (user) in
               self.user = user
               self.navigationItem.title = user.username
           }
       }
    
    
    //MARK: - Helpers
    
    func configureViewController(withUser user : User)
    {
        view.backgroundColor = .white
        
        let layout = UICollectionViewFlowLayout()
        let feed = templateNavigationController(unselectedImage: #imageLiteral(resourceName: "home_unselected"), selectedImage: #imageLiteral(resourceName: "home_selected"), rootViewController: FeedController(collectionViewLayout: layout))
        
        let search = templateNavigationController(unselectedImage: #imageLiteral(resourceName: "search_unselected"), selectedImage: #imageLiteral(resourceName: "search_selected"), rootViewController: SearchController())
        
        let imageSelector = templateNavigationController(unselectedImage: #imageLiteral(resourceName: "plus_unselected"), selectedImage: #imageLiteral(resourceName: "plus_unselected"), rootViewController: ImageSelectorController())
        
        let notifications = templateNavigationController(unselectedImage: #imageLiteral(resourceName: "like_unselected"), selectedImage: #imageLiteral(resourceName: "like_selected"), rootViewController: NotificationController())
        
        let profileController = ProfileController(user: user)
        let profile = templateNavigationController(unselectedImage: #imageLiteral(resourceName: "profile_unselected"), selectedImage: #imageLiteral(resourceName: "profile_selected"), rootViewController: profileController)
        
        viewControllers = [feed,search,imageSelector,notifications,profile]
        
        tabBar.tintColor = .black
    }
    
    func templateNavigationController(unselectedImage : UIImage, selectedImage : UIImage, rootViewController : UIViewController) -> UINavigationController {
        
        let nav = UINavigationController(rootViewController: rootViewController)
        nav.tabBarItem.image = unselectedImage
        nav.tabBarItem.selectedImage = selectedImage
        nav.navigationBar.tintColor = .black
        
        return nav
        
    }
    
    func didfinishPickingMedia(_ picker : YPImagePicker)
    {
        picker.didFinishPicking { (items, _) in
            picker.dismiss(animated: false) {
                guard let selectedImage = items.singlePhoto?.image else { return}
                
                let controller = UploadPostController()
                controller.selectedImage = selectedImage
                controller.delegate = self
                controller.currentUser = self.user
                let nav = UINavigationController(rootViewController: controller)
                nav.modalPresentationStyle = .fullScreen
                
                self.present(nav, animated: false, completion: nil)
                
            }
        }
    }
}

extension MainTabController : AuthenticationDelegate
{
    func authenticationDidComplete() {
        print("DEBUG: Auth did complete fetch user here")
        fetchUsers()
        self.dismiss(animated: true, completion: nil)
    }
}

extension MainTabController: UITabBarControllerDelegate {
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        let index = viewControllers?.firstIndex(of: viewController)
       
        if index == 2 {
            var config = YPImagePickerConfiguration()
            config.library.mediaType = .photo
            config.shouldSaveNewPicturesToAlbum = false
            config.startOnScreen = .library
            config.screens = [.library]
            config.hidesStatusBar = false
            config.hidesBottomBar = false
            config.library.maxNumberOfItems = 1
            
            let picker = YPImagePicker(configuration: config)
            picker.modalPresentationStyle = .fullScreen
            self.present(picker, animated: true, completion: nil)
            didfinishPickingMedia(picker)
        }
        return true
    }
    
}

// MARK: - UploadPostControllerDelegate

extension MainTabController : UploadPostControllerDelegate {
    func controllerDidFinishUploadingPost(_ controller: UploadPostController) {
        selectedIndex = 0
        controller.dismiss(animated: true, completion: nil)
    }
    
    
}
