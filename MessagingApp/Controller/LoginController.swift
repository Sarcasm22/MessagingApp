//
//  LoginController.swift
//  MessagingApp
//
//  Created by AustinShootTheJ on 1/13/18.
//  Copyright © 2018 McCune Technologies. All rights reserved.
//

import UIKit
import Firebase

class LoginController: UIViewController {

    // creates center container where we will put the fields for name email and password.
    let inputsContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.white
        // prevents autolayout from messing up the constraints.
        view.translatesAutoresizingMaskIntoConstraints = false
        // next 2 lines round the corners of the center box.
        view.layer.cornerRadius = 5
        view.layer.masksToBounds = true
        return view
    }()
    
    lazy var loginRegisterButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = UIColor(r: 80, g:101, b:161)
        button.setTitle("Register", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitleColor(UIColor.white, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        
        button.addTarget(self, action: #selector(handleRegister), for: .touchUpInside)
        return button
    }()
    
    @objc func handleRegister() {
        
        guard let email = emailTexField.text, let password = passwordTexField.text, let name = nameTexField.text else{
            print ("Form is not valid")
            return
        }
        
        Auth.auth().createUser(withEmail: email, password: password, completion: {(user: User?, error) in
        
        if error != nil {
            print (error)
            return
            }
        
            
            guard let uid = user?.uid else {
                return
            }
        // successfully authenticated user.
        
        
        
        let ref = Database.database().reference(fromURL: "https://messagingapp-d0c32.firebaseio.com/")
        let userReference = ref.child("users").child(uid)
        let values = ["name": name, "email": email]
        userReference.updateChildValues(values, withCompletionBlock: { (err, ref) in
            
            if err != nil {
                print (err)
                return
            }
            print("Saved user successfully into Firebase db")
        })
        
    })
    }
    
    // creates the name place holder in our center box
    let nameTexField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Name"
        tf.translatesAutoresizingMaskIntoConstraints = false
        return tf
    }()
    
    let nameSeparatorView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(r:220, g: 220, b: 220)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
        
    }()
    
    let emailTexField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Email address"
        tf.translatesAutoresizingMaskIntoConstraints = false
        return tf
    }()
    
    let emailSeparatorView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(r:220, g: 220, b: 220)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
        
    }()
    let passwordTexField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Password"
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.isSecureTextEntry = true
        return tf
    }()
    
    let profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "got")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // set background color for the login controller. 
        view.backgroundColor = UIColor(r:61, g:91, b:151)
        
        // adds our input view continer as a subview of the ViewController.
        view.addSubview(inputsContainerView)
        //adds the loginRegisterButton
        view.addSubview(loginRegisterButton)
        // calls our function to set the constraints on our center continer.
        view.addSubview(profileImageView)
        setupInputsContainerView()
        setupLoginRegisterButton()
        setupProfileImageView()
    }
    
    func setupProfileImageView(){
        profileImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        profileImageView.bottomAnchor.constraint(equalTo: inputsContainerView.topAnchor, constant: -12).isActive = true
        profileImageView.widthAnchor.constraint(equalToConstant: 150).isActive = true
        profileImageView.heightAnchor.constraint(equalToConstant: 150).isActive = true
    }
    
    func setupInputsContainerView(){
        // need x, y, width, height constraints to place the subview.
        // sets x anchor for our subview equal to the center x anchor of the view.
        inputsContainerView.centerXAnchor .constraint(equalTo: view.centerXAnchor).isActive = true
        // sets y anchor for our subview equal to the center y anchor of the view.
        inputsContainerView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        // sets width with -24 pixels in respect to our view
        inputsContainerView.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -24).isActive = true
        //sets height of the subview to 150 pixels.
        inputsContainerView.heightAnchor.constraint(equalToConstant: 150).isActive = true
        
        //needs x,y,width,height  I STOPPED HERE
        inputsContainerView.addSubview(nameTexField)
        nameTexField.leftAnchor.constraint(equalTo: inputsContainerView.leftAnchor, constant: 12).isActive = true
        nameTexField.topAnchor.constraint(equalTo: inputsContainerView.topAnchor).isActive = true
        nameTexField.widthAnchor.constraint(equalTo: inputsContainerView.widthAnchor).isActive = true
        nameTexField.heightAnchor.constraint(equalTo: inputsContainerView.heightAnchor, multiplier: 1/3).isActive = true
        
        inputsContainerView.addSubview(nameSeparatorView)
        nameSeparatorView.leftAnchor.constraint(equalTo:inputsContainerView.leftAnchor).isActive = true
        nameSeparatorView.topAnchor.constraint(equalTo: nameTexField.bottomAnchor).isActive = true
        nameSeparatorView.widthAnchor.constraint(equalTo: inputsContainerView.widthAnchor).isActive = true
        nameSeparatorView.heightAnchor.constraint(equalToConstant: 1).isActive = true
        
        inputsContainerView.addSubview(emailTexField)
        inputsContainerView.addSubview(emailSeparatorView)
        inputsContainerView.addSubview(passwordTexField)
        
        emailTexField.leftAnchor.constraint(equalTo: inputsContainerView.leftAnchor, constant: 12).isActive = true
        emailTexField.topAnchor.constraint(equalTo: nameTexField.bottomAnchor).isActive = true
        emailTexField.widthAnchor.constraint(equalTo: inputsContainerView.widthAnchor).isActive = true
        emailTexField.heightAnchor.constraint(equalTo: inputsContainerView.heightAnchor, multiplier: 1/3).isActive = true
        
        emailSeparatorView.leftAnchor.constraint(equalTo:inputsContainerView.leftAnchor).isActive = true
        emailSeparatorView.topAnchor.constraint(equalTo: emailTexField.bottomAnchor).isActive = true
        emailSeparatorView.widthAnchor.constraint(equalTo: inputsContainerView.widthAnchor).isActive = true
        emailSeparatorView.heightAnchor.constraint(equalToConstant: 1).isActive = true
        
        passwordTexField.leftAnchor.constraint(equalTo: inputsContainerView.leftAnchor, constant: 12).isActive = true
        passwordTexField.topAnchor.constraint(equalTo: emailTexField.bottomAnchor).isActive = true
        passwordTexField.widthAnchor.constraint(equalTo: inputsContainerView.widthAnchor).isActive = true
        passwordTexField.heightAnchor.constraint(equalTo: inputsContainerView.heightAnchor, multiplier: 1/3).isActive = true
        
    }
    
    func setupLoginRegisterButton(){
        //need x, y, width, height constraints
        loginRegisterButton.centerXAnchor .constraint(equalTo: view.centerXAnchor).isActive = true
        loginRegisterButton.topAnchor.constraint(equalTo: inputsContainerView.bottomAnchor, constant: 12).isActive = true
        loginRegisterButton.widthAnchor.constraint(equalTo: inputsContainerView.widthAnchor).isActive = true
        loginRegisterButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        
        
    }
    // sets status bar to be white.
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    


        
    }

// creates a convenience extension that allows us to set UI color more easily. seen in view.backgroundColor above.
extension UIColor {
    
    convenience init(r: CGFloat, g:CGFloat, b: CGFloat){
        self.init(red: r/255, green: g/255, blue: b/255, alpha: 1)
}
}

