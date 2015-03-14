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
            self.card.cvc = card.cvc
            println(self.card)
        }
//        println(card.number)
    }
    
    @IBAction func onSave(sender: UIButton) {
        
        //Create a stripe customer
        println(self.card)
        STPAPIClient.sharedClient().createTokenWithCard(self.card, completion: { (token: STPToken?, error) -> Void in
            if error == nil {
                
                println("error is nil")
                PFUser.currentUser()["stripeCustomerId"] = token?.tokenId!
                PFUser.currentUser().save()
                
                let manager = AFHTTPRequestOperationManager()
                var parameters = ["description":"Customer","source":token?.tokenId!]
                manager.requestSerializer.setValue("sk_test_lnqw4PCAMpZFwjQqHEfJbu6I", forHTTPHeaderField: "user")
                manager.POST("https://api.stripe.com/v1/customers", parameters: [], success: { (operation: AFHTTPRequestOperation!,responseObject: AnyObject!) in
                    println("JSON: " + responseObject.description)
                    },
                    failure: { (operation: AFHTTPRequestOperation!,error: NSError!) in
                        println("Error: " + error.localizedDescription)
                })
                    
                UIAlertView(title: "Success", message: "Card added", delegate: nil, cancelButtonTitle: "Okay").show()
                let vc = AppHelper.storyboard.instantiateViewControllerWithIdentifier("AddressViewController") as UIViewController
                self.navigationController?.pushViewController(vc, animated: true)
            }
        })
//        STPAPIClient.sharedClient().createTokenWithCard(self.card, completion: { (token: STPToken!, error: NSError!) -> Void in
//            println(token)
//            
//        })
        
//        Stripe.
        
        
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
