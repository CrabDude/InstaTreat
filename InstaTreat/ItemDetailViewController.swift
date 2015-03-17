//
//  ItemDetailViewController.swift
//  InstaTreat
//
//  Created by Ashar Rizqi on 3/10/15.
//  Copyright (c) 2015 Adam Crabtree. All rights reserved.
//

import UIKit

class ItemDetailViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var distanceLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
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
        
    @IBOutlet weak var tableView: UITableView!
    
    var item: Item?
    
    override func viewDidLoad() {
        if let item = self.item {
            self.titleLabel.text = item.title
            self.priceLabel.text = String(format: "%.2f", item.price)
            let dateFormat = NSDateFormatter()
            dateFormat.dateFormat = "EEE, MMM d, h:mm a"
            self.createdAtLabel.text = dateFormat.stringFromDate(item.createdAt)
            self.quantityLabel.text = String(item.quantity)
            self.descriptionTextView.text = item.description
            //        cell.distanceLabel.text = item.distance
            
            
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
        }
        
    }
    @IBAction func onBuy(sender: AnyObject) {
        println("on buy presed")
        if PFUser.currentUser()["stripeCustomerId"] != nil {
            let vc = AppHelper.storyboard.instantiateViewControllerWithIdentifier("AddressViewController") as AddressViewController
            vc.item = self.item
            self.navigationController?.pushViewController(vc, animated: true)
        }
        else {
            let vc = AppHelper.storyboard.instantiateViewControllerWithIdentifier("SaveCardViewController") as SaveCardViewController
            vc.item = self.item
            self.navigationController?.pushViewController(vc, animated: true)
        }
        
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = ItemDetailCell()
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        //
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
}
