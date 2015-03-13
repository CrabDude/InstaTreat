//
//  ConfirmationViewController.swift
//  InstaTreat
//
//  Created by Ashar Rizqi on 3/12/15.
//  Copyright (c) 2015 Adam Crabtree. All rights reserved.
//

import UIKit

class ConfirmationViewController: UIViewController, UIAlertViewDelegate, StreamViewControllerDelegate {
    
    
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
        
    }
    
    func blah(notification: NSNotification){
        println("blah")
    }

    @IBAction func onBuy(sender: UIButton) {
        
        let okAction = UIAlertAction(title: "OK", style: .Default) { (action) in
            self.dismiss()
        }
        alert.addAction(okAction)
//        self.presentViewController(alert, animated: true) { () -> Void in
//            self.dismiss()
//        }
        self.presentViewController(alert, animated: true, completion: nil)
        
    }
    
    func dismiss(){
        var vc = AppHelper.storyboard.instantiateViewControllerWithIdentifier("StreamNavigationController") as UINavigationController
        self.navigationController?.presentViewController(vc, animated: true, completion: nil)
    }
    
    func updateView(controller: StreamViewController, item: NSObject) {
        println(item)
    }
}