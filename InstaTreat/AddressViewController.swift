//
//  AddressViewController.swift
//  InstaTreat
//
//  Created by Ashar Rizqi on 3/12/15.
//  Copyright (c) 2015 Adam Crabtree. All rights reserved.
//

import UIKit

class AddressViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func onNext(sender: UIButton) {
        
        let vc = AppHelper.storyboard.instantiateViewControllerWithIdentifier("ConfirmationViewController") as UIViewController
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
}
