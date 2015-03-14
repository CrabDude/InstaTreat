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
        
        let user = PFUser.currentUser()
        
        var query = PFQuery(className:"Item")
        query.whereKey("baker", equalTo:user)
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
//
//        self.refreshControl = UIRefreshControl()
//        self.refreshControl.addTarget(self, action: "refresh:", forControlEvents: UIControlEvents.ValueChanged)
//        self.tableView.addSubview(refreshControl)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func refresh(sender:AnyObject){
//        var query = PFQuery(className: "Item")
//        query.includeKey("baker")
//        let pfItems = query.findObjects() as [PFObject]
//        self.items = Item.itemsWithPFObjectArray(pfItems)
//        self.tableView.reloadData()
//        self.refreshControl.endRefreshing()
    }
    

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier("SalesCell") as SalesCell
        
        let item = items[indexPath.row]
        cell.titleLabel.text = item.title

//        let item = items[indexPath.row]
//        cell.titleLabel.text = "Test"
//        cell.titleLabel.text = item.title>>>>>>> origin/master
//        cell.priceLabel.text = String(format: "%.2f", item.price)
//        let dateFormat = NSDateFormatter()
//        dateFormat.dateFormat = "EEE, MMM d, h:mm a"
//        cell.createdAtLabel.text = dateFormat.stringFromDate(item.createdAt)
//        cell.quantityLabel.text = String(item.quantity)
//        //        cell.distanceLabel.text = item.distance
        
        
       
        return cell
    }
    
//    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
//        if let dc = segue.destinationViewController as? ItemDetailViewController {
//            if let indexPath = self.tableView.indexPathForSelectedRow() {
//                let item = self.items[indexPath.row]
//                dc.item = item
//            }
//        }
//    }
//    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
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
