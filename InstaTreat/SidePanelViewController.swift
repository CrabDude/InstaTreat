//
//  SidePanelViewControllerDelegate
//  Tweetyness
//
//  Created by Ashar Rizqi on 2/26/15.
//  Copyright (c) 2015 Ashar Rizqi. All rights reserved.
//

import UIKit

protocol SidePanelViewControllerDelegate {
    func menuItemSelected(menuItem: MenuItem)
}

class SidePanelViewController: UITableViewController, UITableViewDataSource, UITableViewDelegate {
//    
//    @IBOutlet weak var profileImage: UIImageView!
//    @IBOutlet weak var nameLabel: UILabel!
//    @IBOutlet weak var emailLabel: UILabel!
//    
    var delegate: SidePanelViewControllerDelegate?
    
    var menuItems: [MenuItem]!
    
    struct TableView {
        struct CellIdentifiers {
            static let MenuItemCell = "MenuItemCell"
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        println("side menu did load")
//        self.profileImage.layer.cornerRadius = 9.0
//        self.profileImage.layer.masksToBounds = true
//        self.profileImage.image = User.currentUser.image
//        
//        self.nameLabel.text = User.currentUser.firstName + " " + User.currentUser.lastName
//        self.emailLabel.text = User.currentUser.email
        
        self.tableView.reloadData()
    }
    
    // MARK: Table View Data Source
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        println("returning number of sections")
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        println("count of menuitems is \(menuItems.count)")
        return menuItems.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(TableView.CellIdentifiers.MenuItemCell) as MenuItemCell
        println(self.menuItems)
        cell.configureForMenuItem(menuItems[indexPath.row])
        return cell
    }
    
    // Mark: Table View Delegate
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        delegate?.menuItemSelected(menuItems[indexPath.row])
    }
    
}

