//
//  SaveCardViewController.swift
//  InstaTreat
//
//  Created by Ashar Rizqi on 3/12/15.
//  Copyright (c) 2015 Adam Crabtree. All rights reserved.
//

import UIKit


class SaveCardViewController: UIViewController, PTKViewDelegate {
    
    var paymentView: PTKView?
    var card = STPCard()
    
    @IBOutlet weak var saveButton: UIButton!
//    var stripeView:PTKView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        paymentView = PTKView(frame: CGRectMake(15, 20, 290, 55))
        paymentView?.center = view.center
        paymentView?.delegate = self
        view.addSubview(paymentView!)
        self.saveButton.enabled = false
//        self.stripeView2.delegate = self
//        self.view.addSubview(self.stripeView2)
//        saveButton.enabled = false
    }
    
    func paymentView(paymentView: PTKView!, withCard card: PTKCard!, isValid valid: Bool) {
        self.saveButton.enabled = valid
        if valid {
            
                self.card.number = card.number
                self.card.expMonth = card.expMonth
                self.card.expYear = card.expYear
        }
//        println(card.number)
    }
    
    @IBAction func onSave(sender: UIButton) {
        
        //Create a stripe customer
        STPAPIClient.sharedClient().
        if STPCard.validateCardReturningError(self.card) == true {
            println("valid card")
        }
//        Stripe.
        let vc = AppHelper.storyboard.instantiateViewControllerWithIdentifier("AddressViewController") as UIViewController
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
//    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
//        let targetVC = AppHelper.storyboard.instantiateViewControllerWithIdentifier("ConfirmationViewController") as ConfirmationViewController
//        targetVC.delegate = self
//    }
//    
//    func chargeCard(controller: SaveCardViewController, card: STPCard) {
//        s
//    }
}
