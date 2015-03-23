//
//  BakerSalesDetailViewController.swift
//  InstaTreat
//
//  Created by Adam Crabtree on 3/13/15.
//  Copyright (c) 2015 Adam Crabtree. All rights reserved.
//

import UIKit

class BakerSalesDetailViewController: UITableViewController, UIAlertViewDelegate {

    var sales = [Sale]()
    var alert = UIAlertController(title: "Thank You!", message: "The buyer will be notified.", preferredStyle: UIAlertControllerStyle.Alert)

    override func viewDidLoad() {
        super.viewDidLoad()

        self.tableView.rowHeight = 100
        self.tableView.allowsSelection = false
        
        var query = PFQuery(className:"Sale")
        query.whereKey("baker", equalTo:User.currentUser.pfUser)
        query.includeKey("buyer")
        query.includeKey("item")
        query.orderByDescending("createdAt")
        
        query.findObjectsInBackgroundWithBlock {
            (objects, error) in
            if error != nil {
                println(error)
                return
            }
            
            // The find succeeded.
            println("Successfully retrieved \(objects.count) items")
            
            self.sales = Sale.salesWithPFObjectArray(objects as [PFObject])
            self.tableView.reloadData()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: Table View Data Source
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        println("returning number of sections")
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        println("count of sales is \(self.sales.count)")
        return self.sales.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("SalesBuyerCell") as SalesBuyerCell
        let sale = self.sales[indexPath.row]
        
        cell.buyerNameLabel.text = sale.buyer.firstName + " " + sale.buyer.lastName
        cell.quantityLabel.text = "Quantity: \(String(sale.quantity))"
        cell.addressLabel.text = sale.address == nil ? "" : "Address: \(sale.address!)"
        cell.confirmButton.addTarget(self, action: "confirmTapped:", forControlEvents: .TouchUpInside)
        
        
        if let image = sale.buyer.image {
            cell.buyerImageView.image = image
        } else {
            sale.buyer.onImageLoad = {
                if let image = sale.buyer.image {
                    cell.buyerImageView.image = image
                }
            }
        }
        
        
        return cell
    }
    
    func confirmTapped(sender: UIButton!) {
        println("confirmTapped")
        let cell = sender.superview?.superview as SalesBuyerCell
        if let indexPath = self.tableView.indexPathForCell(cell) {
            let sale = self.sales[indexPath.row]
            sale.confirmDelivered {
                error in
                let okAction = UIAlertAction(title: "OK", style: .Default) {
                    (action) in
//                    self.dismiss()
                }
                self.alert.addAction(okAction)
                self.presentViewController(self.alert, animated: true, completion: nil)
                
            }
        }
    }
}

