//
//  BakerRepostItemViewController.swift
//  InstaTreat
//
//  Created by Dhanu Agnihotri on 3/17/15.
//  Copyright (c) 2015 Adam Crabtree. All rights reserved.
//

import UIKit

class BakerRepostItemViewController: UIViewController {

    @IBOutlet var mainImageView: UIImageView!
    @IBOutlet var priceText: UITextField!
    @IBOutlet var quantityText: UITextField!

    var item: Item!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let images = self.item.images {
            if images.count > 0 {
                self.mainImageView?.image = images[0]
            }
        }
        self.priceText.text = NSString(format: "%.2f",self.item.price)
        self.quantityText.text = String(self.item.quantity)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func onPostButtonClicked(sender: AnyObject){
        if let number: NSString = self.priceText.text {
            self.item.price = number.floatValue
        }
        if let number = self.quantityText.text?.toInt() {
            self.item.quantity = number
        }
        self.postToBackend()
    }
    
    func postToBackend()
    {
        //Post to parse
        var item = PFObject(className:"Item")
        item["title"] = self.item.title
        item["price"] = self.item.price
        item["quantity"] = self.item.quantity
        item["description"] = self.item.description
        item["tags"] = self.item.tags
        item["onSale"] = true;
        item["soldQuantity"]=self.item.soldQuantity
        item["deliveryTime"]=self.item.deliveryTime
        
        if let images = self.item.images {
            if images.count > 0 {
                let data = UIImagePNGRepresentation(images[0])
                let file = PFFile(name:"image.png", data:data)
                file.saveInBackgroundWithBlock({ (success, error) -> Void in
                    
                })
                item["image"] = file
            }
        }
        
        if let currentUser = PFUser.currentUser() {
            item["baker"] = currentUser
            //item["images"] = self.item.images
            
            item.saveInBackgroundWithBlock {
                (success, error) in
                if (success) {
                    let actionSheetController: UIAlertController = UIAlertController(title: "Post", message: "Item successfully posted", preferredStyle: .Alert)
                    
                    let okAction: UIAlertAction = UIAlertAction(title: "OK", style: .Default) { action -> Void in
                        
                        self.view.window?.rootViewController?.dismissViewControllerAnimated(true, completion: nil)
                        
                        if let tbc = UIStoryboard.centerViewController as? UITabBarController {
                            tbc.selectedIndex = 1
                        }
                        //Present the Sales view controller
                    }
                    self.presentViewController(actionSheetController, animated: true, completion: nil)
                    actionSheetController.addAction(okAction)
                    
                } else {
                    // There was a problem, check error.description
                }
            }
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    @IBAction func cancelPressed(sender: UIBarButtonItem) {
        //self.dismissViewControllerAnimated(true, completion: nil)
        self.view.window?.rootViewController?.dismissViewControllerAnimated(true, completion: nil)
    }
}
