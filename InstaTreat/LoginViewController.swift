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
        self.navigationItem.title = "Login"
        print("printing user")
        println(AppHelper.defaults.stringForKey("currentUser"))
        
    }

    @IBAction func onLoginPressed(sender: UIButton) {
        PFUser.logInWithUsernameInBackground(self.usernameTextField.text, password: self.passwordTextField.text) {
            (user, error) in
            println(user)
            if error == nil {
                let appDelegate = UIApplication.sharedApplication().delegate
                // There's really no reason a second ! should be necessary, this is clearly an xcode bug
                let window = (appDelegate?.window!)!
                
                UIView.transitionWithView(window, duration: 0.5, options: UIViewAnimationOptions.TransitionCurlUp, animations: {
                    window.rootViewController = ContainerViewController()
                }, completion: nil)
            } else {
                println(error)
                println("user login failed")
            }
        }
        
    }
    
}
