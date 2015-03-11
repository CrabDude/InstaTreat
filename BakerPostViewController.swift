//
//  BakerPostViewController.swift
//  InstaTreat
//
//  Created by Dhanu Agnihotri on 3/9/15.
//  Copyright (c) 2015 Adam Crabtree. All rights reserved.
//

import UIKit

class BakerPostViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        println("baker post view loaded")
        
        var item = PFObject(className:"Items")
        item["Title"] = "cookies"
        item["Price"] = 2
        item.saveInBackgroundWithBlock {
            (success: Bool, error: NSError!) -> Void in
            if (success) {
                println("item saved")
                // The object has been saved.
            } else {
                // There was a problem, check error.description
            }
        }

        // Do any additional setup after loading the view.
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

}
