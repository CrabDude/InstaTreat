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
    var item:Item!
    var address: Dictionary<String, String>!
    let deliveryCharge = Float(5)
    var total: Float!
    @IBOutlet weak var itemNameLabel: UILabel!
    @IBOutlet weak var itemCost: UILabel!
    @IBOutlet weak var address1Label: UILabel!
    @IBOutlet weak var address2Label: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var stateLabel: UILabel!
    @IBOutlet weak var totalLabel: UILabel!
    
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
        self.itemNameLabel.text = self.item.title
        self.address1Label.text = address["address1"]
        self.address2Label.text = address["address2"]
        self.cityLabel.text = address["city"]
        self.stateLabel.text = address["state"]
        self.totalLabel.text = ""
        println(self.card)
        println(self.item)
        println(self.address)
        self.total = self.deliveryCharge + self.item.price
        self.totalLabel.text = "$\(self.total)"
        println(self.total)
        
    }
    
    func blah(notification: NSNotification){
        println("blah")
    }

    @IBAction func onBuy(sender: UIButton) {
        
        var sale = PFObject(className:"Sale")
        sale["buyer"] = PFUser.currentUser()
        sale["item"] = self.item.parseRef
        sale["quantity"] = self.item.quantity
        sale["baker"] = self.item.bakerRef
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
