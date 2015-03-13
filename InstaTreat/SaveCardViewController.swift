//
//  SaveCardViewController.swift
//  InstaTreat
//
//  Created by Ashar Rizqi on 3/12/15.
//  Copyright (c) 2015 Adam Crabtree. All rights reserved.
//

import UIKit

class SaveCardViewController: UIViewController, PTKViewDelegate {
    
    @IBOutlet weak var stripeView2: PTKView!
    var paymentView: PTKView?
    
//    var stripeView:PTKView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.stripeView2 = PTKView(frame: CGRectMake(15, 20, 290, 55))
        println(self.stripeView2)
        paymentView = PTKView(frame: CGRectMake(15, 20, 290, 55))
        paymentView?.center = view.center
        paymentView?.delegate = self
        view.addSubview(paymentView!)
//        self.stripeView2.delegate = self
//        self.view.addSubview(self.stripeView2)
//        saveButton.enabled = false
    }
    
    func paymentView(paymentView: PTKView!, withCard card: PTKCard!, isValid valid: Bool) {
//        println(card.number)
    }
    
    @IBAction func onSave(sender: UIButton) {
        
        let vc = AppHelper.storyboard.instantiateViewControllerWithIdentifier("AddressViewController") as UIViewController
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
}
