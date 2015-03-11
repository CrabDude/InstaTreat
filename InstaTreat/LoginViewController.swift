//
//  LoginViewController.swift
//  InstaTreat
//
//  Created by Ashar Rizqi on 3/10/15.
//  Copyright (c) 2015 Adam Crabtree. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    
    
    @IBOutlet weak var loginButton: UIButton!
    
    @IBOutlet weak var usernameTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    override func viewDidLoad() {
        
        print("printing user")
        println(AppHelper.defaults.stringForKey("currentUser"))
        
    }

    @IBAction func onLoginPressed(sender: UIButton) {
        PFUser.logInWithUsernameInBackground(self.usernameTextField.text, password: self.passwordTextField.text) { (user:PFUser!, error:NSError!) -> Void in
            if user != nil {
                AppHelper.defaults.setObject(user, forKey: "currentUser")
                println("user login was successful")
                println(user["isBaker"])
            }
            else {
                println(error)
                println("user login failed")
            }
        }
        
    }
    
}
