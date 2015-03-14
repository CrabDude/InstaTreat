//
//  DataSchema.swift
//  InstaTreat
//
//  Created by Adam Crabtree on 3/4/15.
//  Copyright (c) 2015 Adam Crabtree. All rights reserved.
//

import UIKit

var itemCategories = [
    "cookies",
    "brownies",
    "breads",
    "pastries",
    "muffins",
    "candies",
    "chocolate",
    "brittles",
    "cakes",
    "pies",
    "rice krispies",
    "marshmallows"
]

//class ItemPost {
//    let id: AnyObject!
//    let quantity: Int
//    let createdAt: NSDate
//    let endDate: NSDate
//    let item: Item
//    let price: String
//    var longitude: Float!
//    var latitude: Float!
//    
//    var options = [String:Bool]()
//    
//    func init() {
//        
//    }
//    
//    func initWithDictionary(dict: [String: AnyObject]) {
//        
//    }
//}

class Item {
    let id: AnyObject!
    var images: [UIImage]?
    var description: String!
    var title: String!
    var ratingCount: Int!
    var ratingTotal: Int!
    var owner: String!
    var price: Float!
    var quantity : Int!
    var tags: [String]!
    var location: AnyObject!
    var createdAt: NSDate!
    var baker: User!
    var onImageLoad: (() -> Void)?
    var parseRef: PFObject!
    
    init() {
        self.id = ""
        self.images = []
        self.description = ""
        self.title = ""
        self.ratingCount = 0
        self.ratingTotal = 0
        self.owner = ""
        self.price = 0
        self.quantity = 0
        self.tags = []
        self.location = ""
        self.createdAt = NSDate()
    }
    
    init(parseObject: PFObject) {
        self.title = parseObject["title"]! as String
        self.description = parseObject["description"]! as String
        self.quantity = parseObject["quantity"]! as Int
        self.ratingCount = (parseObject["ratingCount"] ?? 0) as Int
        self.ratingTotal = (parseObject["ratingTotal"] ?? 0) as Int
        self.price = parseObject["price"]! as Float
        self.tags = parseObject["tags"]! as [String]
        self.createdAt = parseObject.createdAt
        self.baker = User(parseObject: parseObject["baker"] as PFUser)
        
        if let image = parseObject["image"] as? PFFile {
            image.getDataInBackgroundWithBlock {
                (imageData, error) in
                self.images = []
                if error == nil {
                    self.images?.append(UIImage(data: imageData)!)
                    self.onImageLoad?()
                }
            }
        } else {
            self.images = []
        }
        self.parseRef = parseObject
        
    }
    
    class func itemsWithPFObjectArray(parseObjects: [PFObject]) -> [Item] {
        var items = [Item]()
        for parseObject in parseObjects {
            items.append(Item(parseObject: parseObject))
        }
        return items
    }
}

class Sale {
    var quantity: Int!
    var saleId: AnyObject!
    var state:String!
    var createdAt: NSDate!
    var buyer: User!
    var item: Item!
    
    init(parseObject: PFObject) {
        self.state = parseObject["state"]! as String
        self.item = Item(parseObject: parseObject["item"] as PFObject)
        self.buyer = User(parseObject: parseObject["buyer"] as PFUser)
    }
}

