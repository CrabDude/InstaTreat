//
//  StreamViewController.swift
//  InstaTreat
//
//  Created by Ashar Rizqi on 3/10/15.
//  Copyright (c) 2015 Adam Crabtree. All rights reserved.
//

import UIKit

class StreamViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var items: Array<AnyObject>!
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        var query = PFQuery(className: "Items")
        self.items = query.findObjects()
        self.tableView.reloadData()
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier("itemCell") as ItemCell
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
}
