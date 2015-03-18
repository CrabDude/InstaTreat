//
//  StreamViewController.swift
//  InstaTreat
//
//  Created by Ashar Rizqi on 3/10/15.
//  Copyright (c) 2015 Adam Crabtree. All rights reserved.
//

import UIKit


class StreamViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var items = [Item]()
    var refreshControl:UIRefreshControl!
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        self.refreshControl = UIRefreshControl()
        self.refreshControl.addTarget(self, action: "refresh:", forControlEvents: UIControlEvents.ValueChanged)
        self.tableView.addSubview(refreshControl)
        
        var query = PFQuery(className: "Item")
        query.includeKey("baker")
        let pfItems = query.findObjects() as [PFObject]
        self.items = Item.itemsWithPFObjectArray(pfItems)
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
        cell.quantityLabel.text = String(item.quantity)
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
        
        if let image = item.baker.image {
            cell.bakerImageView?.image = image
            cell.bakerImageView?.layer.borderWidth = 3.0
            cell.bakerImageView?.layer.borderColor = UIColor.whiteColor().CGColor
            cell.bakerImageView?.layer.cornerRadius = cell.bakerImageView.frame.size.width / 2
            cell.bakerImageView?.clipsToBounds = true
            
        } else {
            item.baker.onImageLoad = {
                cell.bakerImageView?.image = item.baker.image
                cell.bakerImageView?.layer.borderWidth = 3.0
                cell.bakerImageView?.layer.borderColor = UIColor.whiteColor().CGColor
                cell.bakerImageView?.layer.cornerRadius = cell.bakerImageView.frame.size.width / 2
                cell.bakerImageView?.clipsToBounds = true
                return
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
        
        cell.badge1Image.hidden = true
        cell.badge2Image.hidden = true
        cell.badge3Image.hidden = true
        cell.badge4Image.hidden = true
        
        
        for tag in item.tags {
            switch (tag) {
            case "Nut Free":
                cell.badge1Image?.layer.borderWidth = 3.0
                cell.badge1Image?.layer.borderColor = UIColor.whiteColor().CGColor
                cell.badge1Image?.layer.cornerRadius = cell.bakerImageView.frame.size.width / 2
                cell.badge1Image?.clipsToBounds = true
                cell.badge1Image.hidden = false
            case "Gluten Free":
                cell.badge2Image?.layer.borderWidth = 3.0
                cell.badge2Image?.layer.borderColor = UIColor.whiteColor().CGColor
                cell.badge2Image?.layer.cornerRadius = cell.bakerImageView.frame.size.width / 2
                cell.badge2Image?.clipsToBounds = true
                cell.badge2Image.hidden = false
            case "Egg Free":
                cell.badge3Image?.layer.borderWidth = 3.0
                cell.badge3Image?.layer.borderColor = UIColor.whiteColor().CGColor
                cell.badge3Image?.layer.cornerRadius = cell.bakerImageView.frame.size.width / 2
                cell.badge3Image?.clipsToBounds = true
                cell.badge3Image.hidden = false
            default:
                break
            }
            
        }
        
        cell.buyButton.tag = indexPath.row
        cell.buyButton.addTarget(self, action: "buy:", forControlEvents: UIControlEvents.TouchUpInside)

        return cell
    }
    
//    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
//        if let dc = segue.destinationViewController as? DetailViewController {
//            if let indexPath = self.tableView.indexPathForSelectedRow() {
//                let item = self.items[indexPath.row]
//                dc.item = item
//            }
//        }
////        var idx = sender as UIButton
////        println(idx.tag)
//    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let vc = AppHelper.storyboard.instantiateViewControllerWithIdentifier("DetailViewController") as DetailViewController
        let item = self.items[indexPath.row]
        vc.item = item
//        var itemDetailnib = UINib(nibName: "ItemDetailTableViewCell", bundle: nil)
//        var bakerDetailnib = UINib(nibName: "BakerDetailTableViewCell", bundle: nil)
//        vc.tableView.registerNib(itemDetailnib, forCellReuseIdentifier: "itemDetailTableViewCell")
//        vc.tableView.registerNib(bakerDetailnib, forCellReuseIdentifier: "bakerDetailTableViewCell")

        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.items.count
    }
    
    @IBAction func onLogoutPressed(sender: UIButton) {
        UIStoryboard.logout()
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
        
        if PFUser.currentUser()["stripeCustomerId"] != nil {
            let vc = AppHelper.storyboard.instantiateViewControllerWithIdentifier("AddressViewController") as AddressViewController
            vc.item = selectedItem
            self.navigationController?.pushViewController(vc, animated: true)
        }
        else {
            let vc = AppHelper.storyboard.instantiateViewControllerWithIdentifier("SaveCardViewController") as SaveCardViewController
            vc.item = selectedItem
            self.navigationController?.pushViewController(vc, animated: true)
        }
        
//        let vc = AppHelper.storyboard.instantiateViewControllerWithIdentifier("SaveCardViewController") as SaveCardViewController
//        println("item in streamview")
//        println(selectedItem)
//        vc.item = selectedItem
//        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
    
}
