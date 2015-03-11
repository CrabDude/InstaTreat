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
                var isBaker = user["isBaker"] as Bool
                if isBaker == true {
                    println("baker")
                    let vc = AppHelper.storyboard.instantiateViewControllerWithIdentifier("BakerPostViewController") as UIViewController
                    let navController = UINavigationController(rootViewController: vc)
                    self.navigationController?.pushViewController(vc, animated: true)
                }
                else {
                    println("this is a user")
                    let vc = AppHelper.storyboard.instantiateViewControllerWithIdentifier("StreamViewController") as UIViewController
//                    self.presentViewController(vc, animated: true, completion: nil)
                    self.navigationController?.pushViewController(vc, animated: true)
                }
                
            }
            else {
                println(error)
                println("user login failed")
            }
        }
        
    }
    
}
