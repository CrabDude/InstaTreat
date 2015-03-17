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
        sale["isDelivered"] = false
        sale.saveInBackgroundWithBlock {
            (success: Bool, error: NSError!) -> Void in
            if (success) {
                println("success")
                self.chargeCard(PFUser.currentUser()["stripeCustomerId"] as NSString, amount: self.item.price)
                // The object has been saved.
            } else {
                println(error)
                // There was a problem, check error.description
            }
        }
        
        var query = PFQuery(className:"Item")
        query.getObjectInBackgroundWithId(self.item.parseRef.objectId) {
            (item: PFObject!, error: NSError!) -> Void in
            if error != nil {
                println(error)
            } else {
                var quantity = item["quantity"] as NSInteger
                var soldQuantity = item["soldQuantity"] as NSInteger
                println("Item" + String(self.item.parseRef.objectId))
                println(" Total quantity" + String(quantity) + " Sold quantity" + String(soldQuantity))
                soldQuantity = soldQuantity+1 //update total soldQuantity
                item["soldQuantity"] = soldQuantity
                if quantity==soldQuantity
                {
                    item["onSale"]=false
                }
                
                item.saveInBackgroundWithBlock({ (success, error) -> Void in
                    
                })
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
    
    func chargeCard(id: NSString, amount: Float) {
        let manager = AFHTTPRequestOperationManager()
        var p: AnyObject!
        p = ["customer_id": id, "amount":amount] as NSDictionary
        manager.POST("http://leapdoc.me:644/instatreat/api/v1/stripe/charge/create", parameters: p, success: { (operation: AFHTTPRequestOperation!,responseObject: AnyObject!) in
            var stripeResponse = responseObject as NSDictionary
            println(stripeResponse)
            
            },
            failure: { (operation: AFHTTPRequestOperation!,error: NSError!) in
                println("Error: " + error.localizedDescription)
                
        })
        
        
    }
    
    
    
}
