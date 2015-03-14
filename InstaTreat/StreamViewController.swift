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
        cell.priceLabel.text = String(format: "%.2f", item.price)
        let dateFormat = NSDateFormatter()
        dateFormat.dateFormat = "EEE, MMM d, h:mm a"
        cell.createdAtLabel.text = dateFormat.stringFromDate(item.createdAt)
        cell.quantityLabel.text = String(item.quantity)
//        cell.distanceLabel.text = item.distance
        
        
        cell.starRatingView.displayMode = UInt(EDStarRatingDisplayHalf)
        cell.starRatingView.starImage = UIImage(named: "star")
        cell.starRatingView.starHighlightedImage = UIImage(named: "star-highlighted")
        cell.starRatingView.maxRating = 5
        cell.starRatingView.horizontalMargin = 12
        cell.starRatingView.editable = false
        if item.ratingCount == 0 {
            cell.starRatingView.hidden = true
        } else {
            cell.starRatingView.hidden = false
            cell.starRatingView.rating = Float(item.ratingTotal) / Float(item.ratingCount)
        }
        
        if let image = item.baker.image {
            cell.bakerImageView?.image = image
        } else {
            item.baker.onImageLoad = {
                cell.bakerImageView?.image = item.baker.image
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
                cell.badge1Image.hidden = false
            case "Gluten Free":
                cell.badge2Image.hidden = false
            case "Egg Free":
                cell.badge3Image.hidden = false
            default:
                break
            }
            
        }


        return cell
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let dc = segue.destinationViewController as? ItemDetailViewController {
            if let indexPath = self.tableView.indexPathForSelectedRow() {
                let item = self.items[indexPath.row]
                dc.item = item
            }
        }
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.items.count
    }
    
    @IBAction func onLogoutPressed(sender: UIButton) {
        PFUser.logOut()
        let vc = AppHelper.storyboard.instantiateViewControllerWithIdentifier("LoginViewController") as UIViewController
        self.navigationController?.pushViewController(vc, animated: true)
        
    }

    @IBAction func onMapButtonPressed(sender: UIButton) {
        let vc = AppHelper.storyboard.instantiateViewControllerWithIdentifier("MapViewController") as UIViewController
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
    @IBAction func onBuy(sender: UIButton) {
        println("on buy presed")
        NSNotificationCenter.defaultCenter().postNotificationName("uniqueName", object: nil)
        let vc = AppHelper.storyboard.instantiateViewControllerWithIdentifier("SaveCardViewController") as UIViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func buy(sender: UIButton){
        println("on buy presed")
        let vc = AppHelper.storyboard.instantiateViewControllerWithIdentifier("SaveCardViewController") as UIViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
    
}
