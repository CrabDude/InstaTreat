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
    var images: UIImage!
    var description: String!
    var title: String!
    var rating: Float!
    var owner: String!
    var price: Float!
    var quantity : Int!
    var tags: Array<String>!
    var location: AnyObject!
    var createdAt: NSDate!
    
    init() {
        self.id = ""
        self.images = UIImage()
        self.description = ""
        self.title = ""
        self.rating = 0
        self.owner = ""
        self.price = 0
        self.quantity = 0
        self.tags = []
        self.location = ""
        self.createdAt = NSDate()
    }
//    
//    convenience init(_ dictionary: [String: AnyObject]) {
//        self.description = dictionary["discription"]! as! String
//        self.title = dictionary["title"]!
//        self.rating = dictionary["rating"]!
//        self.owner = dictionary["owner"]!
//        self.quantity = dictionary["quantity"]!
//        self.tags = dictionary["tags"]!
//    }
//    
    class func itemsWithPFObjectArray(parseItems: [PFObject]) -> [Item] {
        var items = [Item]()
//        println(items)
        for parseItem in parseItems {
//            println(parseItem["createdAt"]!)
            let item = Item()
            item.title = parseItem["title"]! as String
            item.description = parseItem["description"]! as String
            item.quantity = parseItem["quantity"]! as Int
            item.rating = parseItem["rating"]! as Float
            item.price = parseItem["price"]! as Float
            item.createdAt = parseItem.createdAt
            items.append(item)
        }
        return items
    }
}

class User {
    let phoneNumber: String!
    let firstName: String!
    let lastName: String!
    let email: String!
    let address: String!
    let paymentToken: String!
    let baker: [String:AnyObject]!
    let userId: AnyObject!
    
    init() {
        self.phoneNumber = ""
        self.firstName = ""
        self.lastName = ""
        self.email = ""
        self.address = ""
        self.paymentToken = ""
        self.baker = [String:AnyObject]()
        self.userId = ""
    }
}

class Baker: User {
    let availability: [String:AnyObject]!
    
    override init() {
        self.availability = [String:AnyObject]()
        
        super.init()
    }
}

class Buyer:User {
    var canPost: Bool!
}

class Sale {
    var quantity: Int!
    var saleId: AnyObject!
    var state:String!
    var purchasedAt: NSDate!
    var buyerId: AnyObject!
    var itemPostId: AnyObject!
}

