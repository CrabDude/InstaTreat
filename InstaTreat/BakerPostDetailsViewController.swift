//
//  BakerPostDetailsViewController.swift
//  InstaTreat
//
//  Created by Dhanu Agnihotri on 3/10/15.
//  Copyright (c) 2015 Adam Crabtree. All rights reserved.
//

import UIKit

class BakerPostDetailsViewController: UIViewController {

    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    @IBOutlet var PriceLabel: UITextField!
    @IBOutlet var quantityLabel: UITextField!
    @IBOutlet var descriptionTextView: UITextView!
    
    var item :Item!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        self.item.description = descriptionTextView.text
        if let number: NSString = self.PriceLabel.text {
            self.item.price = number.floatValue
        }
        if let number = self.quantityLabel.text?.toInt() {
            self.item.quantity = number
        }
        
        if let dc = segue.destinationViewController as? BakerPostFinalViewController {
            dc.item = self.item
        }
    }
    
}
