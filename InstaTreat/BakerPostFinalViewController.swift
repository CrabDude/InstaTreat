//
//  BakerPostFinalViewController.swift
//  InstaTreat
//
//  Created by Dhanu Agnihotri on 3/10/15.
//  Copyright (c) 2015 Adam Crabtree. All rights reserved.
//

import UIKit

class BakerPostFinalViewController: UIViewController {

    @IBOutlet var glutenFreeState: UISwitch!
    @IBOutlet var nutFreeState: UISwitch!
    
    @IBOutlet var eggFreeState: UISwitch!
    
    var postItem :Item!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func confirmPostPressed(sender: AnyObject) {
        if glutenFreeState.on{
            self.postItem.tags.append("Gluten Free")
        }
        if nutFreeState.on{
            self.postItem.tags.append("Nut Free")
        }
        if eggFreeState.on{
            self.postItem.tags.append("Egg Free")
        }
        
        //Create the AlertController
        let actionSheetController: UIAlertController = UIAlertController(title: "Confirm", message: "Please confirm, Item cannot be changed later", preferredStyle: .Alert)
        
        //Create and add the Cancel action
        let cancelAction: UIAlertAction = UIAlertAction(title: "Cancel", style: .Cancel) { action -> Void in
            //Do some stuff
        }
        actionSheetController.addAction(cancelAction)
        //Create and an option action
        let nextAction: UIAlertAction = UIAlertAction(title: "Post", style: .Default) { action -> Void in
            //Do some other stuff
            println("Ready to post")
            
            //Post to parse 
            var item = PFObject(className:"Items")
            item["Title"] = self.postItem.title
            item["Price"] = self.postItem.price
            item["Quantity"] = self.postItem.quantity
            item["Description"] = self.postItem.description
            item["Categories"] = self.postItem.tags
            
            var currentUser = PFUser.currentUser()
            item["BakerID"] = currentUser.objectId

            item.saveInBackgroundWithBlock {
                (success: Bool, error: NSError!) -> Void in
                if (success) {
                    println("item saved")
                    // The object has been saved.
                } else {
                    // There was a problem, check error.description
                }
            }
            //Present the Sales view controller
        }
        actionSheetController.addAction(nextAction)
        
        //Present the AlertController
        self.presentViewController(actionSheetController, animated: true, completion: nil)
    }
}
