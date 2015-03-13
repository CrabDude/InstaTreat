//
//  StreamViewController.swift
//  InstaTreat
//
//  Created by Ashar Rizqi on 3/10/15.
//  Copyright (c) 2015 Adam Crabtree. All rights reserved.
//

import UIKit

class StreamViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, EDStarRatingProtocol {
    
    var items = [Item]()
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        var query = PFQuery(className: "Item")
        let pfItems = query.findObjects() as [PFObject]
//        println(pfItems)
        self.items = Item.itemsWithPFObjectArray(pfItems)
        self.tableView.reloadData()
        
        println("item count: \(self.items.count)")
        
        
//        self.colors = @[ [UIColor colorWithRed:0.11f green:0.38f blue:0.94f alpha:1.0f], [UIColor colorWithRed:1.0f green:0.22f blue:0.22f alpha:1.0f], [UIColor colorWithRed:0.27f green:0.85f blue:0.46f alpha:1.0f], [UIColor colorWithRed:0.35f green:0.35f blue:0.81f alpha:1.0f]];
//        // Setup control using iOS7 tint Color
//        _starRating.backgroundColor  = [UIColor whiteColor];
//        _starRating.starImage = [[UIImage imageNamed:@"star-template"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
//        _starRating.starHighlightedImage = [[UIImage imageNamed:@"star-highlighted-template"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
//        _starRating.maxRating = 5.0;
//        _starRating.delegate = self;
//        _starRating.horizontalMargin = 15.0;
//        _starRating.editable=YES;
//        _starRating.rating= 2.5;
//        _starRating.displayMode=EDStarRatingDisplayHalf;
//        [_starRating  setNeedsDisplay];
//        _starRating.tintColor = self.colors[0];
//        [self starsSelectionChanged:_starRating rating:2.5];
//        
//        
        
        
        
        
//        _starRatingImage.displayMode=EDStarRatingDisplayAccurate;
//        [self starsSelectionChanged:_starRatingImage rating:2.5];
//        // This one will use the returnBlock instead of the delegate
//        _starRatingImage.returnBlock = ^(float rating )
//        {
//            NSLog(@"ReturnBlock: Star rating changed to %.1f", rating);
//            // For the sample, Just reuse the other control's delegate method and call it
//            [self starsSelectionChanged:_starRatingImage rating:rating];
//        };
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
        
        
        cell.starRatingView.starImage = UIImage(named: "star")
        cell.starRatingView.starHighlightedImage = UIImage(named: "starhighlighted")
        cell.starRatingView.maxRating = 5
        cell.starRatingView.delegate = self
        cell.starRatingView.horizontalMargin = 12
        cell.starRatingView.editable = true
        cell.starRatingView.rating = 3
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let vc = AppHelper.storyboard.instantiateViewControllerWithIdentifier("ItemDetailViewController") as UIViewController
        self.navigationController?.presentViewController(vc, animated: true, completion: nil)
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
    
    func starsSelectionChanged(control: EDStarRating, rating: Float) {
        println("starsSelectionChanged")
    }
    
    @IBAction func onBuy(sender: UIButton) {
        println("on buy presed")
        NSNotificationCenter.defaultCenter().postNotificationName("uniqueName", object: nil)
        let vc = AppHelper.storyboard.instantiateViewControllerWithIdentifier("SaveCardViewController") as UIViewController
        self.navigationController?.pushViewController(vc, animated: true)
        

    }
    
}
