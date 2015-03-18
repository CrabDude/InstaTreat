//
//  DetailViewController.swift
//  InstaTreat
//
//  Created by Ashar Rizqi on 3/16/15.
//  Copyright (c) 2015 Adam Crabtree. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    var item: Item!
    
    override func viewWillAppear(animated: Bool) {
//        var itemDetailnib = UINib(nibName: "ItemDetailTableViewCell", bundle: nil)
//        self.tableView.registerNib(itemDetailnib, forCellReuseIdentifier: "itemDetailTableViewCell")
        
//        var bakerDetailnib = UINib(nibName: "BakerDetailTableViewCell", bundle: nil)
//        self.tableView.registerNib(bakerDetailnib, forCellReuseIdentifier: "bakerDetailTableViewCell")

    }
    
    override func viewDidLoad() {
        println("loading view")
        self.tableView.rowHeight = 350.0
        
//        self.tableView.frame.height = CGFloat(350.0)
        println(item.otherImages)
        
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        //
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = UITableViewCell()
        if indexPath.row == 0 {
            var displayImages = []
            for imgUrl in self.item.otherImages {
                println(imgUrl)
            }
            var itemDetailnib = UINib(nibName: "ItemImagesViewCell", bundle: nil)
            self.tableView.registerNib(itemDetailnib, forCellReuseIdentifier: "itemImagesViewCell")
            cell = tableView.dequeueReusableCellWithIdentifier("itemImagesViewCell") as ItemImagesViewCell
            
        }
        else if indexPath.row == 1 {
            var itemDetailnib = UINib(nibName: "ItemDetailTableViewCell", bundle: nil)
            self.tableView.registerNib(itemDetailnib, forCellReuseIdentifier: "itemDetailTableViewCell")
            cell = tableView.dequeueReusableCellWithIdentifier("itemDetailTableViewCell") as ItemDetailTableViewCell
        }
        else if indexPath.row == 2 {
            var bakerDetailnib = UINib(nibName: "BakerDetailTableViewCell", bundle: nil)
            self.tableView.registerNib(bakerDetailnib, forCellReuseIdentifier: "bakerDetailTableViewCell")
            cell = tableView.dequeueReusableCellWithIdentifier("bakerDetailTableViewCell") as BakerDetailTableViewCell
        }
        return cell
        
//        switch indexPath.row {
//        case 0:
//            var cell = tableView.dequeueReusableCellWithIdentifier("itemDetailTableViewCell") as ItemDetailTableViewCell
//            return cell
//        case 1:
//            var cell = tableView.dequeueReusableCellWithIdentifier("bakerDetailTableViewCell") as BakerDetailTableViewCell
//            return cell
//        default:
//            var cell = tableView.dequeueReusableCellWithIdentifier("itemDetailTableViewCell") as ItemDetailTableViewCell
//            return cell
//        }
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
