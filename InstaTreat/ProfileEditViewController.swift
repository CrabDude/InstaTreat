//
//  ProfileEditViewController.swift
//  InstaTreat
//
//  Created by Adam Crabtree on 3/22/15.
//  Copyright (c) 2015 Adam Crabtree. All rights reserved.
//

import UIKit

class ProfileEditViewController: UIViewController {
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var phoneNumberTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var verifyPasswordTextField: UITextField!
    @IBOutlet weak var address1TextField: UITextField!
    @IBOutlet weak var address2TextField: UITextField!
    @IBOutlet weak var cityTextField: UITextField!
    @IBOutlet weak var stateTextField: UITextField!
    @IBOutlet weak var isBakerSwitch: UISwitch!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let user = User.currentUser
        self.firstNameTextField.text = user.firstName
        self.lastNameTextField.text = user.lastName
        self.emailTextField.text = user.email
        self.phoneNumberTextField.text = String(user.phoneNumber)
        
        var address = split(user.address) {$0 == ","}
        var index = address.count
        let state = address[--index]
        let city = address[--index]
        let address2 = index > 1 ? address[1] : ""
        let address1 = address[0]
        
        self.address1TextField.text = address1
        self.address2TextField.text = address2
        self.cityTextField.text = city
        self.stateTextField.text = state
        self.isBakerSwitch.on = user.isBaker
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    @IBAction func onSaveTap(sender: AnyObject) {
        println("onSaveTap")
        self.navigationController?.popToRootViewControllerAnimated(true)
    }
}
