//
//  RegistrationController.swift
//  InstagramClone
//
//  Created by Mobile Apps Team on 11/9/20.
//  Copyright © 2020 anshu vij. All rights reserved.
//

import UIKit

class RegistrationController: UIViewController{
    
    //MARK: - Properties
    
    private var viewModel = RegistraionViewModel()
    private var profileImage : UIImage?
    
    weak var delegate : AuthenticationDelegate?
    private let plusPhotoButton : UIButton = {
        let button = UIButton(type: .system)
        button.setImage(#imageLiteral(resourceName: "plus_photo"), for: .normal)
        button.tintColor = .white
        button.addTarget(self, action: #selector(handleProfilePhoto), for: .touchUpInside)
        return button
    }()
    
    private let emailTextField:UITextField = {
       let tf = CustomTextField(placeHolder: "Email")
        tf.keyboardType = .emailAddress
        
        return tf
    }()
    
    private let passwordTextField:UITextField = {
          let tf = CustomTextField(placeHolder: "Password")
        tf.isSecureTextEntry = true
           return tf
        
       }()
    
    private let fullnameTextField:UITextField = CustomTextField(placeHolder: "Fullname")
    
    private let usernameTextField:UITextField = CustomTextField(placeHolder: "Username")
    
    private let SignUpButton : UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("SignUp", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = #colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1).withAlphaComponent(0.5)
        button.layer.cornerRadius = 5
        button.setHeight(50.0)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        button.addTarget(self, action: #selector(handleSignUp), for: .touchUpInside)
        button.isEnabled = false
        return button
    }()
    
    private let alredyHaveAccountButton : UIButton = {
           let button = UIButton(type: .system)
           button.attributedTitle(firstPart: "Already have an account?", secondPart: "Login")
           button.addTarget(self, action: #selector(handleShowLogin), for: .touchUpInside)
           return button
       }()
    
    
     //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        configureNotificationObservers()
    }
    
    //MARK: Actions
    
    
    @objc func handleShowLogin()
    {
        navigationController?.popViewController(animated: true)
    }
    
    @objc func textDidChange(sender: UITextField)
    {
        if sender == emailTextField {
            viewModel.email = sender.text
        }
        else if sender == passwordTextField{
            viewModel.password = sender.text
        }
        else if sender == usernameTextField{
            viewModel.username = sender.text
        }
        else{
            viewModel.fullname = sender.text
            
        }
       updateForm()
    }
    
    @objc func handleProfilePhoto()
    {
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.allowsEditing = true
       present(picker, animated: true, completion: nil)
    }
    
    @objc func handleSignUp()
    {
        guard let email = emailTextField.text else {return}
        guard let password = passwordTextField.text else {return}
        guard let fullname = fullnameTextField.text else {return}
        guard let username = usernameTextField.text?.lowercased() else {return}
        guard let profileImage = self.profileImage else {return}
        
        let credentials = AuthCredentials(email: email, password: password, fullname: fullname, username: username, profileImage: profileImage)
        AuthService.registerUser(withCredentials: credentials) { (error) in
            if let error = error {
                print("DEBUG: failed to register user")
                return
            }
            print("DEBUG: Successfully registered usser on Firebase")
            self.delegate?.authenticationDidComplete()
        }
    }
    //MARK: - Helpers
    
    func configureUI()
    {
        configureGradientLayer()
        view.addSubview(plusPhotoButton)
        plusPhotoButton.centerX(inView: view)
        plusPhotoButton.setDimensions(height: 140, width: 140)
        plusPhotoButton.anchor(top:view.safeAreaLayoutGuide.topAnchor,paddingTop: 32)
        
        let stack = UIStackView(arrangedSubviews: [emailTextField,passwordTextField,fullnameTextField,usernameTextField,SignUpButton])
        stack.axis = .vertical
        stack.spacing = 20
        view.addSubview(stack)
        stack.anchor(top:plusPhotoButton.bottomAnchor,left: view.leftAnchor, right: view.rightAnchor,paddingTop: 32,paddingLeft: 32,paddingRight: 32)
        
        view.addSubview(alredyHaveAccountButton)
        alredyHaveAccountButton.centerX(inView: view)
        alredyHaveAccountButton.anchor(bottom:view.safeAreaLayoutGuide.bottomAnchor)
        
    }
    
    func configureNotificationObservers()
    {
        emailTextField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
        passwordTextField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
        fullnameTextField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
        usernameTextField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
    }
}

//MARK: - FormViewModel
extension RegistrationController : FormViewModel {
    func updateForm() {
        SignUpButton.backgroundColor = viewModel.buttonBackgroundColor
        SignUpButton.setTitleColor(viewModel.buttonTitleColor, for: .normal)
        SignUpButton.isEnabled = viewModel.formIsValid
    }
}
//MARK: - UIImagePickerControllerDelegate

extension RegistrationController : UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        guard let selectedImage = info[.editedImage] as? UIImage else {return}
        
        profileImage = selectedImage
        plusPhotoButton.layer.cornerRadius = plusPhotoButton.frame.width/2
        plusPhotoButton.layer.masksToBounds = true
        plusPhotoButton.layer.borderColor = UIColor.white.cgColor
        plusPhotoButton.layer.borderWidth = 2
        plusPhotoButton.setImage(selectedImage.withRenderingMode(.alwaysOriginal), for: .normal)
        
        self.dismiss(animated: true, completion: nil)
        
        
    }
}
