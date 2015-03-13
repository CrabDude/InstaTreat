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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.salesTableView.delegate = self
        self.salesTableView.dataSource = self
        self.salesTableView.registerNib(UINib(nibName: "SalesCell", bundle: nil), forCellReuseIdentifier: "SalesCell")
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier("SalesCell") as SalesCell
        
        let item = items[indexPath.row]
        cell.titleLabel.text = "Test"
//        cell.titleLabel.text = item.title
//        cell.priceLabel.text = String(format: "%.2f", item.price)
//        let dateFormat = NSDateFormatter()
//        dateFormat.dateFormat = "EEE, MMM d, h:mm a"
//        cell.createdAtLabel.text = dateFormat.stringFromDate(item.createdAt)
//        cell.quantityLabel.text = String(item.quantity)
//        //        cell.distanceLabel.text = item.distance
        
        
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
        
//        if let image = item.baker.image {
//            cell.bakerImageView?.image = image
//        } else {
//            item.baker.onImageLoad = {
//                cell.bakerImageView?.image = item.baker.image
//                return
//            }
//        }
//        
//        if let images = item.images {
//            if images.count > 0 {
//                cell.itemImage?.image = images[0]
//            }
//        } else {
//            item.onImageLoad = {
//                if item.images?.count > 0 {
//                    cell.itemImage?.image = item.images?[0]
//                }
//                return
//            }
//        }
//        
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
        //return self.items.count
        return 1
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
