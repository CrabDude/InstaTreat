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
        if indexPath.row == 0 {
            var displayImages: Array<UIImage>!
            var itemDetailnib = UINib(nibName: "ItemImagesViewCell", bundle: nil)
            self.tableView.registerNib(itemDetailnib, forCellReuseIdentifier: "itemImagesViewCell")
            var cell = tableView.dequeueReusableCellWithIdentifier("itemImagesViewCell") as ItemImagesViewCell
            var pageImages = [UIImage]()
            for url in self.item.otherImages {
                var urlB = NSURL(string: url)
                var test =  UIImage(data: NSData(contentsOfURL: NSURL(string:url)!)!)
                pageImages.append(test!)

            }

            cell.configure(pageImages)
            
            return cell
            

        }
        else if indexPath.row == 1 {
            var itemDetailnib = UINib(nibName: "ItemDetailTableViewCell", bundle: nil)
            self.tableView.registerNib(itemDetailnib, forCellReuseIdentifier: "itemDetailTableViewCell")
            var cell = tableView.dequeueReusableCellWithIdentifier("itemDetailTableViewCell") as ItemDetailTableViewCell
            return cell
        }
        else if indexPath.row == 2 {
            var bakerDetailnib = UINib(nibName: "BakerDetailTableViewCell", bundle: nil)
            self.tableView.registerNib(bakerDetailnib, forCellReuseIdentifier: "bakerDetailTableViewCell")
            var cell = tableView.dequeueReusableCellWithIdentifier("bakerDetailTableViewCell") as BakerDetailTableViewCell
            return cell
        }
        else {
            var itemDetailnib = UINib(nibName: "ItemDetailTableViewCell", bundle: nil)
            self.tableView.registerNib(itemDetailnib, forCellReuseIdentifier: "itemDetailTableViewCell")
            var cell = tableView.dequeueReusableCellWithIdentifier("itemDetailTableViewCell") as ItemDetailTableViewCell
            return cell

        }
    }

}
