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
    var addressString: String!
    var address: Dictionary<String, String>!
    var deliveryCharge: Float!
    var deliveryTime: String!
    var total: Float!
    
    @IBOutlet weak var deliveryLabel: UILabel!
    @IBOutlet weak var itemNameLabel: UILabel!
    @IBOutlet weak var itemCost: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var cityStateLabel: UILabel!
    
//    @IBOutlet weak var address1Label: UILabel!
//    @IBOutlet weak var address2Label: UILabel!
//    @IBOutlet weak var cityLabel: UILabel!
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
        self.navigationItem.title = "Order Confirmation"
        println(self.deliveryTime)
        println("confirmation view")
        var addrArray = self.addressString.componentsSeparatedByString(",")
        println(addrArray)
        self.cityStateLabel.text = "\(addrArray[1]), \(addrArray[2])"
        self.itemNameLabel.text = self.item.title
        self.addressLabel.text = addrArray[0]
        self.deliveryLabel.text = "$\(self.deliveryCharge)"
        self.itemCost.text =  String(format: "$%.2f", self.item.price)
        self.total = self.deliveryCharge + self.item.price
        self.totalLabel.text = String(format: "$%.2f", self.total)
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
        let address1 = address["address1"]!
        let address2 = address["address2"]!
        let city = address["city"]!
        let state = address["state"]!
        sale["address"] = self.addressString
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
        
        alert.addAction(UIAlertAction(title: "OK", style: .Default) {
            (action) in
            _ = self.navigationController?.popToRootViewControllerAnimated(true)
        })
        self.presentViewController(alert, animated: true, completion: nil)
        
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
