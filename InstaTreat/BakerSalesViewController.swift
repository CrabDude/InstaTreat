//
//  BakerSalesViewController.swift
//  InstaTreat
//
//  Created by Dhanu Agnihotri on 3/13/15.
//  Copyright (c) 2015 Adam Crabtree. All rights reserved.
//

import UIKit

class BakerSalesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var items = [Item]()
    
    @IBOutlet var salesTableView: UITableView!
    var refreshControl:UIRefreshControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.salesTableView.delegate = self
        self.salesTableView.dataSource = self
        
        self.refreshControl = UIRefreshControl()
        self.refreshControl.addTarget(self, action: "refresh:", forControlEvents: UIControlEvents.ValueChanged)
        self.salesTableView.addSubview(refreshControl)
    
        self.getItemData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func getItemData()
    {
        let user = PFUser.currentUser()
        var query = PFQuery(className:"Item")
        query.whereKey("baker", equalTo:user)
        query.whereKey("onSale", equalTo:true)
        query.orderByDescending("createdAt")
        
        query.findObjectsInBackgroundWithBlock {
            (objects: [AnyObject]!, error: NSError!) -> Void in
            if error == nil {
                // The find succeeded.
                println("Successfully retrieved \(objects.count) items")
                
                let pfItems = objects as [PFObject]
                self.items = Item.itemsWithPFObjectArray(pfItems)
                self.salesTableView.reloadData()
                
            } else {
                // Log details of the failure
                println("Error: \(error) \(error.userInfo!)")
            }
        }
    }
    
    func refresh(sender:AnyObject){
        self.getItemData()
        self.refreshControl.endRefreshing()
    }
    

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier("SalesCell") as SalesCell
        
        let item = items[indexPath.row]
        cell.titleLabel.text = item.title
        cell.priceLabel.text = String(format: "$%.2f", item.price)
        cell.quantityLabel.text = String(item.quantity)
        let dateFormat = NSDateFormatter()
        dateFormat.dateFormat = "MMM d,h:mm a"
        cell.createdTimeLabel.text = dateFormat.stringFromDate(item.createdAt)
       
        if let images = item.images {
            if images.count > 0 {
                cell.itemImageView?.image = images[0]
            }
        } else {
            item.onImageLoad = {
                if item.images?.count > 0 {
                    cell.itemImageView?.image = item.images?[0]
                }
                return
            }
        }
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        //        if let dc = segue.destinationViewController as? ItemDetailViewController {
        //            if let indexPath = self.tableView.indexPathForSelectedRow() {
        //                let item = self.items[indexPath.row]
        //                dc.item = item
        //            }
        //        }
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.items.count
    }
    
    @IBAction func logoutTapped(sender: AnyObject) {
        UIStoryboard.logout()
    }
}
