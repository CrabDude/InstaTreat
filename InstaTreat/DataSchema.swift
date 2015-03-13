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
    var tags: Array<String>!
    var location: AnyObject!
    var createdAt: NSDate!
    var baker: User! = User()
    var onImageLoad: (() -> Void)?
    
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
    
    class func itemsWithPFObjectArray(parseItems: [PFObject]) -> [Item] {
        var items = [Item]()
        for parseItem in parseItems {
            let item = Item()
            item.title = parseItem["title"]! as String
            item.description = parseItem["description"]! as String
            item.quantity = parseItem["quantity"]! as Int
            item.ratingCount = (parseItem["ratingCount"] ?? 0) as Int
            item.ratingTotal = (parseItem["ratingTotal"] ?? 0) as Int
            item.price = parseItem["price"]! as Float
            item.createdAt = parseItem.createdAt
            item.baker = User(parseObject: parseItem["baker"] as PFObject)
            items.append(item)

            if let image = parseItem["image"] as? PFFile {
                image.getDataInBackgroundWithBlock {
                    (imageData, error) in
                    item.images = []
                    if error == nil {
                        item.images?.append(UIImage(data: imageData)!)
                        item.onImageLoad?()
                    }
                }
            } else {
                item.images = []
            }
        }
        return items
    }
}

class User {
    let phoneNumber: Int!
    let firstName: String!
    let lastName: String!
    let email: String!
    let address: String!
    let paymentToken: String!
    let isBaker: Bool
    var image: UIImage?
    var onImageLoad: (() -> Void)?
    
    init() {
        self.phoneNumber = 1234567890
        self.firstName = "John"
        self.lastName = "Doe"
        self.email = "john@doe.com"
        self.address = "123 Wallaby Way, Sydney"
        self.paymentToken = "abcdefghijklmnopqrstuvwxyz"
        self.isBaker = false
    }
    
    init(parseObject: PFObject) {
        self.phoneNumber = parseObject["phoneNumber"]! as Int
        self.firstName = parseObject["firstName"]! as String
        self.lastName = parseObject["lastName"]! as String
        self.email = parseObject["email"]! as String
        self.address = parseObject["address"]! as String
        self.isBaker = parseObject["isBaker"] as? Bool ?? false
        
        if let image = parseObject["image"] as? PFFile {
            image.getDataInBackgroundWithBlock {
                (imageData, error) in
                if error == nil {
                    self.image = UIImage(data: imageData)
                    self.onImageLoad?()
                }
            }
        }

    }
}

class Sale {
    var quantity: Int!
    var saleId: AnyObject!
    var state:String!
    var purchasedAt: NSDate!
    var buyerId: AnyObject!
    var itemPostId: AnyObject!
}

