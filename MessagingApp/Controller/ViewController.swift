//
//  ViewController.swift
//  MessagingApp
//
//  Created by AustinShootTheJ on 1/13/18.
//  Copyright © 2018 McCune Technologies. All rights reserved.
//

import UIKit
import Firebase

class ViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        

        
        // creates a bar button in the top left of the screen with a title of Logout. The selector method handles what happens when this button is pressed.
        navigationItem.leftBarButtonItem = UIBarButtonItem(title:"Logout", style: .plain, target: self, action: #selector(handleLogout))
        
        // user is not logged in.
        if Auth.auth().currentUser?.uid == nil {
            
            // does not load until app is loaded up.
            perform(#selector(handleLogout), with: nil, afterDelay: 0)
            
            handleLogout()
        }
        
    }

    // function that handles logout button being pressed.
   @objc func handleLogout(){
    
    do {
        try Auth.auth().signOut()
        
    } catch let logoutError {
        print(logoutError)
    }
    
    
    // transitions to login view controller when logout is pressed. 
    let loginController = LoginController()
    present(loginController, animated: true, completion: nil)
        
    }


}

