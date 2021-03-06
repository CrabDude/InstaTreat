//
//  AddressViewController.swift
//  InstaTreat
//
//  Created by Ashar Rizqi on 3/12/15.
//  Copyright (c) 2015 Adam Crabtree. All rights reserved.
//

import UIKit

class AddressViewController: UIViewController {
    
    var item: Item!
//    var address: Dictionary<String, String>!
    
    @IBOutlet weak var address2TextField: UITextField!
    @IBOutlet weak var address1TextField: UITextField!
    @IBOutlet weak var cityTextField: UITextField!
    @IBOutlet weak var stateTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        println(self.item)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let dc = segue.destinationViewController as? ConfirmationViewController {
            var address = ["address1":"", "address2": "", "city":"", "state": ""]
            println(self.address1TextField.text)
            address["address1"] = self.address1TextField.text
            address["address2"] = self.address2TextField.text
            address["city"] = self.cityTextField.text
            address["state"] = self.stateTextField.text
                
            dc.item = self.item
            dc.address = address
        }
    }
}
