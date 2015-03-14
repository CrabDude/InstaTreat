//
//  ConfirmationViewController.swift
//  InstaTreat
//
//  Created by Ashar Rizqi on 3/12/15.
//  Copyright (c) 2015 Adam Crabtree. All rights reserved.
//

import UIKit


class ConfirmationViewController: UIViewController, UIAlertViewDelegate {
    
    
    var card:STPCard!
    
    var alert = UIAlertController(title: "Thank You!", message: "Your order is on its way", preferredStyle: UIAlertControllerStyle.Alert)
    
    override func viewWillAppear(animated: Bool) {
        NSNotificationCenter.defaultCenter().addObserver(
            self,
            selector: "blah:",
            name: "uniqueName",
            object: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        println("confirmation view")
        println(self.card)
        
    }
    
    func blah(notification: NSNotification){
        println("blah")
    }

    @IBAction func onBuy(sender: UIButton) {
        
        var sale = PFObject(className:"Sale")
        sale["buyer"] = "abc"
        sale["item"] = "blah"
        sale["quantity"] = 5
        sale["baker"] = "me"
        sale.saveInBackgroundWithBlock {
            (success: Bool, error: NSError!) -> Void in
            if (success) {
                println("success")
                // The object has been saved.
            } else {
                println(error)
                // There was a problem, check error.description
            }
        }
        
        let okAction = UIAlertAction(title: "OK", style: .Default) { (action) in
            
            self.dismiss()
        }
        alert.addAction(okAction)
        self.presentViewController(alert, animated: true, completion: nil)
        
    }
    
    func dismiss(){
        
        var vc = AppHelper.storyboard.instantiateViewControllerWithIdentifier("StreamNavigationController") as UINavigationController
        self.navigationController?.presentViewController(vc, animated: true, completion: nil)
    }
    
    
    
}
