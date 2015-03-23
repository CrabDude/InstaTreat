//
//  ItemDetailViewController.swift
//  InstaTreat
//
//  Created by Ashar Rizqi on 3/10/15.
//  Copyright (c) 2015 Adam Crabtree. All rights reserved.
//

import UIKit

private var _formatter = NSDateFormatter()
private var _timezone = NSTimeZone(abbreviation: "PST")

class ItemDetailViewController: UIViewController {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var bakerNameLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var createdAtLabel: UILabel!
    @IBOutlet weak var quantityLabel: UILabel!
    @IBOutlet weak var bakerImageView: UIImageView!
    @IBOutlet weak var starRatingView: EDStarRating!
    @IBOutlet weak var itemImage: UIImageView!
    @IBOutlet weak var badge1Image: UIImageView!
    @IBOutlet weak var badge2Image: UIImageView!
    @IBOutlet weak var badge3Image: UIImageView!
    @IBOutlet weak var badge4Image: UIImageView!
    @IBOutlet weak var descriptionTextView: UITextView!
    
    var item: Item?
    
    override func viewDidLoad() {
        if let item = self.item {
            self.titleLabel.text = item.title
            self.priceLabel.text = "$" + String(format: "%.2f", item.price)
            let dateFormat = NSDateFormatter()
            dateFormat.dateFormat = "EEE, MMM d, h:mm a"
            self.createdAtLabel.text = dateFormat.stringFromDate(item.createdAt)
            self.quantityLabel.text = String(item.quantity) + " Remaining"
            self.descriptionTextView.text = item.description
            
            self.starRatingView.displayMode = UInt(EDStarRatingDisplayHalf)
            self.starRatingView.starImage = UIImage(named: "star")
            self.starRatingView.starHighlightedImage = UIImage(named: "star-highlighted")
            self.starRatingView.maxRating = 5
            self.starRatingView.horizontalMargin = 12
            self.starRatingView.editable = false
            if item.ratingCount == 0 {
                self.starRatingView.hidden = true
            } else {
                self.starRatingView.hidden = false
                self.starRatingView.rating = Float(item.ratingTotal) / Float(item.ratingCount)
            }

            self.bakerImageView?.image = item.baker.image
            self.bakerImageView?.layer.borderWidth = 2
            self.bakerImageView?.layer.borderColor = UIColor.whiteColor().CGColor
            self.bakerImageView?.layer.cornerRadius = self.bakerImageView.frame.size.width / 2
            self.bakerImageView?.clipsToBounds = true
            
            if item.images?.count > 0 {
                self.itemImage?.image = item.images?[0]
            }
            
            self.badge1Image.hidden = true
            self.badge2Image.hidden = true
            self.badge3Image.hidden = true
            self.badge4Image.hidden = true
            
            for tag in item.tags {
                switch (tag) {
                case "Nut Free":
                    self.badge1Image.hidden = false
                case "Gluten Free":
                    self.badge2Image.hidden = false
                case "Egg Free":
                    self.badge3Image.hidden = false
                default:
                    break
                }
                
            }
            
            let distanceBetweenDates = NSDate().timeIntervalSinceDate(item.createdAt)
            let hoursBetweenDates = Int(distanceBetweenDates / 3600)
            
            _formatter.dateFormat = "M/d/Y"
            _formatter.timeZone = _timezone

            if hoursBetweenDates < 24 {
                self.createdAtLabel.text = "Baked \(hoursBetweenDates)h Ago"
            } else {
                self.createdAtLabel.text = "Baked on " + _formatter.stringFromDate(item.createdAt)
            }
        }
        
    }
    
    @IBAction func onBuy(sender: AnyObject) {
        println("on buy presed")
        if PFUser.currentUser()["stripeCustomerId"] != nil {
            let vc = AppHelper.storyboard.instantiateViewControllerWithIdentifier("AddressViewController") as AddressViewController
            vc.item = self.item
            
            let gpaViewController = GooglePlacesAutocomplete(
                apiKey: "AIzaSyAgbg4DuvV80k6fhUiKzCqddOu8sk29Ess",
                placeType: .Address
            )
            
            gpaViewController.placeDelegate = self // Conforms to GooglePlacesAutocompleteDelegate
            
            presentViewController(gpaViewController, animated: true, completion: nil)
            
        }
        else {
            let vc = AppHelper.storyboard.instantiateViewControllerWithIdentifier("SaveCardViewController") as SaveCardViewController
            vc.item = self.item
            self.navigationController?.pushViewController(vc, animated: true)
        }
        
    }
    
    
}

extension ItemDetailViewController: GooglePlacesAutocompleteDelegate {
    func placeSelected(place: Place) {
        self.dismissViewControllerAnimated(true, completion: nil)
        var dropOffAddress = place.description
        self.getDeliveryQuoteAndPush(dropOffAddress)
    }
    
    func placeViewClosed() {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func getDeliveryQuoteAndPush(dropOffAddress: NSString!) {
        
        var pickupAddress = self.item?.baker.address
        
        let manager = AFHTTPRequestOperationManager()
        var p: NSDictionary!
        var deliveryQuote: NSDictionary!
        var testApiKey = "6fa2afca-e07b-48f1-b7f9-1bc063e198e9"
        
        manager.requestSerializer = AFHTTPRequestSerializer()
        manager.requestSerializer.setAuthorizationHeaderFieldWithUsername(testApiKey, password: "")
        p = ["pickup_address": pickupAddress!, "dropoff_address": dropOffAddress] as NSDictionary
        
        manager.POST("https://api.postmates.com/v1/customers/cus_KF37niwIy5dqak/delivery_quotes", parameters: p, success: { (operation: AFHTTPRequestOperation!,responseObject: AnyObject!) in
            var postMatesResponse = responseObject as NSDictionary
            
            var fee = postMatesResponse["fee"] as Float
            
            let vc = AppHelper.storyboard.instantiateViewControllerWithIdentifier("ConfirmationViewController") as ConfirmationViewController
            vc.item = self.item
            vc.address = ["address1":"blah", "address2":"blah", "city":"blah", "state": "blah"]
            vc.addressString = dropOffAddress
            vc.deliveryCharge = fee/100.0
            var deliveryTime = postMatesResponse["dropoff_eta"]! as NSString
            let dateFormatter = NSDateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd hh:mm:ss.SSSSxxx"
            let date = dateFormatter.dateFromString(deliveryTime)
            println(date)
//            vc.deliveryTime = postMatesResponse["dropoff_eta"] as NSDate
            
            self.navigationController?.pushViewController(vc, animated: true)

            
            
            },
            failure: { (operation: AFHTTPRequestOperation!,error: NSError!) in
                println("Error: " + error.localizedDescription)
                
        })
//        return deliveryQuote
        
        
    }

}

