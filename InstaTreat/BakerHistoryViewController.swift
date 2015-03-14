//
//  BakerHistoryViewController.swift
//  InstaTreat
//
//  Created by Dhanu Agnihotri on 3/13/15.
//  Copyright (c) 2015 Adam Crabtree. All rights reserved.
//

import UIKit

class BakerHistoryViewController: UIViewController , UITableViewDelegate, UITableViewDataSource {

    @IBOutlet var historyTableView: UITableView!
    
    var items = [Item]()
    var refreshControl:UIRefreshControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.historyTableView.delegate = self
        self.historyTableView.dataSource = self
        
        self.refreshControl = UIRefreshControl()
        self.refreshControl.addTarget(self, action: "refresh:", forControlEvents: UIControlEvents.ValueChanged)
        self.historyTableView.addSubview(refreshControl)
        
        self.getItemData()

        // Do any additional setup after loading the view.
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
        query.whereKey("onSale", equalTo:false)
        query.orderByDescending("createdAt")
        
        query.findObjectsInBackgroundWithBlock {
            (objects: [AnyObject]!, error: NSError!) -> Void in
            if error == nil {
                // The find succeeded.
                println("Successfully retrieved \(objects.count) items")
                
                let pfItems = objects as [PFObject]
                self.items = Item.itemsWithPFObjectArray(pfItems)
                self.historyTableView.reloadData()
                
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
        var cell = tableView.dequeueReusableCellWithIdentifier("HistoryCell") as HistoryCell
        
        let item = items[indexPath.row]
        cell.titleLabel.text = item.title
//        cell.priceLabel.text = String(format: "%.2f", item.price)
//        cell.quantityLabel.text = String(item.quantity)
//        let dateFormat = NSDateFormatter()
//        dateFormat.dateFormat = "EEE, MMM d, h:mm a"
//        cell.createdTimeLabel.text = dateFormat.stringFromDate(item.createdAt)
        
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
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.items.count
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
