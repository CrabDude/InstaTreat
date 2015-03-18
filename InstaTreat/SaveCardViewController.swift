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
    var item: Item!
    
    @IBOutlet weak var saveButton: UIButton!
//    var stripeView:PTKView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        paymentView = PTKView(frame: CGRectMake(15, 20, 290, 55))
        paymentView?.center.y = 100.0
        paymentView?.delegate = self
        view.addSubview(paymentView!)
        self.saveButton.enabled = false
        println("item in save card")
        println(self.item)
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
    
        STPAPIClient.sharedClient().createTokenWithCard(self.card) {
            (token: STPToken!, error) in
            if error != nil {
                println(error)
                return
            }
            
            
            var token =  token.tokenId as NSString
            var p: AnyObject!
            p = ["token": "\(token)", "description":PFUser.currentUser().username] as NSDictionary
            let manager = AFHTTPRequestOperationManager()
            manager.requestSerializer.setValue("sk_test_lnqw4PCAMpZFwjQqHEfJbu6I", forHTTPHeaderField: "user")
            manager.POST("http://leapdoc.me:644/instatreat/api/v1/stripe/customers/create", parameters: p, success: { (operation: AFHTTPRequestOperation!,responseObject: AnyObject!) in
                var stripeResponse = responseObject as NSDictionary
                var customerId = stripeResponse["id"]!
                var amount = self.item.price
                
                PFUser.currentUser()["stripeCustomerId"] = customerId
                PFUser.currentUser().save()
                UIAlertView(title: "Success", message: "Card added", delegate: nil, cancelButtonTitle: "Okay").show()
                let vc = AppHelper.storyboard.instantiateViewControllerWithIdentifier("AddressViewController") as AddressViewController
                vc.item = self.item
                self.navigationController?.pushViewController(vc, animated: true)
                },
                failure: { (operation: AFHTTPRequestOperation!,error: NSError!) in
                    println("Error: " + error.localizedDescription)
                    UIAlertView(title: "Oops", message: "There was an error with your card", delegate: nil, cancelButtonTitle: "Okay").show()
            })
                
            
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let targetVC = AppHelper.storyboard.instantiateViewControllerWithIdentifier("AddressViewController") as AddressViewController
//        targetVC.
    }
    
    
}
