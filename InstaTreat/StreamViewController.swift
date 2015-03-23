//
//  StreamViewController.swift
//  InstaTreat
//
//  Created by Ashar Rizqi on 3/10/15.
//  Copyright (c) 2015 Adam Crabtree. All rights reserved.
//

import UIKit
import QuartzCore

private var _formatter = NSDateFormatter()
private var _timezone = NSTimeZone(abbreviation: "PST")
var sItem: Item!

class StreamViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var items = [Item]()
    var refreshControl:UIRefreshControl!
    var formatter: NSDateFormatter {
        _formatter.dateFormat = "M/d/Y"
        _formatter.timeZone = _timezone
        return _formatter
    }

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        self.navigationItem.title = "San Francisco"
        self.refreshControl = UIRefreshControl()
        self.refreshControl.addTarget(self, action: "refresh:", forControlEvents: UIControlEvents.ValueChanged)
        self.tableView.addSubview(refreshControl)
        
        var query = PFQuery(className: "Item")
        query.includeKey("baker")
        query.orderByDescending("createdAt")
        let pfItems = query.findObjects() as [PFObject]
        self.items = Item.itemsWithPFObjectArray(pfItems)
        
        self.tableView.rowHeight = 340
        self.tableView.reloadData()
        
        println("item count: \(self.items.count)")
    }
    
    func refresh(sender:AnyObject){
        var query = PFQuery(className: "Item")
        query.includeKey("baker")
        let pfItems = query.findObjects() as [PFObject]
        self.items = Item.itemsWithPFObjectArray(pfItems)
        self.tableView.reloadData()
        self.refreshControl.endRefreshing()
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier("itemCell") as ItemCell
        
        let item = items[indexPath.row]
        cell.titleLabel.text = item.title
        cell.priceLabel.text = String(format: "$%.2f", item.price)
        let dateFormat = NSDateFormatter()
        dateFormat.dateFormat = "EEE, MMM d, h:mm a"
        cell.createdAtLabel.text = dateFormat.stringFromDate(item.createdAt)
        cell.quantityLabel.text = String(item.quantity) + " Remaining"
//        cell.distanceLabel.text = item.distance
        
        
//        cell.starRatingView.displayMode = UInt(EDStarRatingDisplayHalf)
//        cell.starRatingView.starImage = UIImage(named: "star")
//        cell.starRatingView.starHighlightedImage = UIImage(named: "star-highlighted")
//        cell.starRatingView.maxRating = 5
//        cell.starRatingView.horizontalMargin = 12
//        cell.starRatingView.editable = false
//        if item.ratingCount == 0 {
//            cell.starRatingView.hidden = true
//        } else {
//            cell.starRatingView.hidden = false
//            cell.starRatingView.rating = Float(item.ratingTotal) / Float(item.ratingCount)
//        }
        
        let setTextShadow = {(view: UIView) -> Void in
            let layer = view.layer
            layer.shadowOpacity = 1
            layer.shadowRadius = 2
            layer.shadowOffset = CGSizeMake(0, 0)
        }
        
        setTextShadow(cell.titleLabel)
        setTextShadow(cell.createdAtLabel)
        setTextShadow(cell.quantityLabel)
        setTextShadow(cell.priceLabel)

        
        let setBakerImageValues = {(image: UIImage?) -> Void in
            cell.bakerImageView?.image = image
            cell.bakerImageView?.layer.borderWidth = 2
            cell.bakerImageView?.layer.borderColor = UIColor.whiteColor().CGColor
            cell.bakerImageView?.layer.cornerRadius = cell.bakerImageView.frame.size.width / 2
            cell.bakerImageView?.clipsToBounds = true
        }

        if let image = item.baker.image {
            setBakerImageValues(image)
            
        } else {
            item.baker.onImageLoad = {
                setBakerImageValues(item.baker.image)
            }
        }
        
        if let images = item.images {
            if images.count > 0 {
                cell.itemImage?.image = images[0]
            }
        } else {
            item.onImageLoad = {
                if item.images?.count > 0 {
                    cell.itemImage?.image = item.images?[0]
                }
                return
            }
        }
        
        let setBadgeImageValues = {(imageView: UIImageView) -> Void in
            imageView.layer.cornerRadius = imageView.frame.size.width / 2
            imageView.clipsToBounds = true
            imageView.hidden = false
        }
        
        cell.badge1Image.hidden = true
        cell.badge2Image.hidden = true
        cell.badge3Image.hidden = true
        cell.badge4Image.hidden = true
        
        for tag in item.tags {
            switch (tag) {
            case "Nut Free":
                setBadgeImageValues(cell.badge1Image)
            case "Gluten Free":
                setBadgeImageValues(cell.badge2Image)
            case "Egg Free":
                setBadgeImageValues(cell.badge3Image)
            default:
                break
            }
        }
        
        let distanceBetweenDates = NSDate().timeIntervalSinceDate(item.createdAt)
        let hoursBetweenDates = Int(distanceBetweenDates / 3600)
        
        if hoursBetweenDates < 24 {
            cell.createdAtLabel.text = "\(hoursBetweenDates)h Ago"
        } else {
            cell.createdAtLabel.text = self.formatter.stringFromDate(item.createdAt)
        }
        
        cell.buyButton.tag = indexPath.row
        cell.buyButton.addTarget(self, action: "buy:", forControlEvents: UIControlEvents.TouchUpInside)

        return cell
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let dc = segue.destinationViewController as? ItemDetailViewController {
            println("Segue to ItemDetailViewController")
            if let indexPath = self.tableView.indexPathForSelectedRow() {
                let item = self.items[indexPath.row]
                dc.item = item
                println(indexPath.row, item)
            }
        }
//        var idx = sender as UIButton
//        println(idx.tag)
    }
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.items.count
    }
    
    @IBAction func onMenuTap(sender: UIButton) {
        UIStoryboard.toggleLeftPanel()
    }

    @IBAction func onMapButtonPressed(sender: UIButton) {
        let vc = AppHelper.storyboard.instantiateViewControllerWithIdentifier("MapViewController") as UIViewController
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
//    @IBAction func onBuy(sender: UIButton) {
//        println("on buy presed")
//        NSNotificationCenter.defaultCenter().postNotificationName("uniqueName", object: nil)
//        let vc = AppHelper.storyboard.instantiateViewControllerWithIdentifier("SaveCardViewController") as UIViewController
//        self.navigationController?.pushViewController(vc, animated: true)
//    }
    
    func buy(sender: UIButton){
        println("on buy presed")
        var selectedItem = self.items[sender.tag]
        sItem = self.items[sender.tag]
        if PFUser.currentUser()["stripeCustomerId"] != nil {
            let vc = AppHelper.storyboard.instantiateViewControllerWithIdentifier("AddressViewController") as AddressViewController
            vc.item = selectedItem
            
            let gpaViewController = GooglePlacesAutocomplete(
                apiKey: "AIzaSyAgbg4DuvV80k6fhUiKzCqddOu8sk29Ess",
                placeType: .Address
            )
            
            gpaViewController.placeDelegate = self // Conforms to GooglePlacesAutocompleteDelegate
            
            presentViewController(gpaViewController, animated: true, completion: nil)
            
        }
        else {
            let vc = AppHelper.storyboard.instantiateViewControllerWithIdentifier("SaveCardViewController") as SaveCardViewController
            vc.item = selectedItem
            self.navigationController?.pushViewController(vc, animated: true)
        }
        
    }
    
    
}

extension StreamViewController: GooglePlacesAutocompleteDelegate {
    func placeSelected(place: Place) {
        self.dismissViewControllerAnimated(true, completion: nil)
        var dropOffAddress = place.description
        self.getDeliveryQuoteAndPush(dropOffAddress)
    }
    
    func placeViewClosed() {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func getDeliveryQuoteAndPush(dropOffAddress: NSString!) {
        var pickupAddress = sItem.baker.address
        
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
            vc.item = sItem
            vc.address = ["address1":"blah", "address2":"blah", "city":"blah", "state": "blah"]
            vc.addressString = dropOffAddress
            vc.deliveryCharge = fee/100.0
            
            self.navigationController?.pushViewController(vc, animated: true)
            
            
            
            },
            failure: { (operation: AFHTTPRequestOperation!,error: NSError!) in
                println("Error: " + error.localizedDescription)
                
        })
        //        return deliveryQuote
        
        
    }
    
}
