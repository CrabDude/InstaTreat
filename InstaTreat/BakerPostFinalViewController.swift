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
    
    var item: Item!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func confirmPostPressed(sender: AnyObject) {
        
        if glutenFreeState.on {
            self.item.tags.append("Gluten Free")
        }
        if nutFreeState.on {
            self.item.tags.append("Nut Free")
        }
        if eggFreeState.on {
            self.item.tags.append("Egg Free")
        }
        
        //Create the AlertController
        let actionSheetController: UIAlertController = UIAlertController(title: "Confirm", message: "Please confirm, Item cannot be changed later", preferredStyle: .Alert)
        
        //Create and add the Cancel action
        let cancelAction: UIAlertAction = UIAlertAction(title: "Cancel", style: .Cancel) { action -> Void in
            //Do some stuff
        }
        actionSheetController.addAction(cancelAction)
        
        let nextAction: UIAlertAction = UIAlertAction(title: "Post", style: .Default) { action -> Void in
            //Do some other stuff
            println("Ready to post")
            
            //Post to parse 
            var item = PFObject(className:"Item")
            item["title"] = self.item.title
            item["price"] = self.item.price
            item["quantity"] = self.item.quantity
            item["description"] = self.item.description
            item["tags"] = self.item.tags
            
//            if let images = item.images
//            {
//                if images.count > 0 {
//                                    cell.itemImage?.image = images[0]
//                                }
//                    let imageData = UIImagePNGRepresentation(element)
//            }
//       
//            
            if let currentUser = PFUser.currentUser() {
                item["baker"] = currentUser
                
                item.saveInBackgroundWithBlock {
                    (success, error) in
                    if (success) {
                        let actionSheetController: UIAlertController = UIAlertController(title: "Post", message: "Item successfully posted", preferredStyle: .Alert)
                        
                        let okAction: UIAlertAction = UIAlertAction(title: "OK", style: .Default) { action -> Void in
                            
                            println("Post Successful")
                            self.view.window?.rootViewController?.dismissViewControllerAnimated(true, completion: nil)
//                            if let tabBarController = self.view.window?.rootViewController as? UITabBarController {
//                                tabBarController.selectedIndex = 2
//                            }
//                            if let tabBarController = self.parentViewController as? UITabBarController {
//                                tabBarController.selectedIndex = 2
//                            }

                        }
                        self.presentViewController(actionSheetController, animated: true, completion: nil)
                        actionSheetController.addAction(okAction)
                        
                    } else {
                        // There was a problem, check error.description
                    }
                }
            }
            //Present the Sales view controller
        }
        actionSheetController.addAction(nextAction)
        
        //Present the AlertController
        self.presentViewController(actionSheetController, animated: true, completion: nil)
    }
}
