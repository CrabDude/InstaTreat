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
    var soldQuantity : Int!
    var deliveryTime: String!
    var tags: [String]!
    var location: AnyObject!
    var createdAt: NSDate!
    var baker: User!
    var onImageLoad: (() -> Void)?
    var parseRef: PFObject!
    var bakerRef: PFObject!
    
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
        self.soldQuantity = 0
        self.deliveryTime = ""
        self.tags = []
        self.location = ""
        self.createdAt = NSDate()
    }
    
    init(parseObject: PFObject) {
        self.title = parseObject["title"]! as String
        self.description = parseObject["description"]! as String
        self.quantity = parseObject["quantity"]! as Int
        self.soldQuantity = parseObject["soldQuantity"]! as Int
        self.ratingCount = (parseObject["ratingCount"] ?? 0) as Int
        self.ratingTotal = (parseObject["ratingTotal"] ?? 0) as Int
        self.price = parseObject["price"]! as Float
        self.tags = parseObject["tags"]! as [String]
        self.createdAt = parseObject.createdAt
        self.deliveryTime = parseObject["deliveryTime"]! as String
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
        self.bakerRef = parseObject["baker"] as PFUser
        
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
    var isDelivered: Bool!
    var createdAt: NSDate!
    var buyer: User!
    var item: Item!
    var pfSale: PFObject!
    
    init(parseObject: PFObject) {
        self.isDelivered = parseObject["isDelivered"]! as Bool
        self.item = Item(parseObject: parseObject["item"] as PFObject)
        self.buyer = User(parseObject: parseObject["buyer"] as PFUser)
        self.quantity = parseObject["quantity"] as Int
        self.pfSale = parseObject
    }
    
    func confirmDelivered(conclusion: (NSError?)->()) {
        println("sale confirmed delivered")
        self.pfSale.setObject(true, forKey: "isDelivered")
        self.pfSale.saveInBackgroundWithBlock {
            (success, error) in
            conclusion(nil)
        }
        
    }
    
    class func salesWithPFObjectArray(parseObjects: [PFObject]) -> [Sale] {
        var sales = [Sale]()
        for parseObject in parseObjects {
            sales.append(Sale(parseObject: parseObject))
        }
        return sales
    }

}

