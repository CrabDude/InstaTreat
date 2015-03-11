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
//    func initWithDictionary(dict: [String: AnyObject]) {
//        
//    }
//}


class Item {
    let id: AnyObject!
    var images: UIImage!
    var description: String!
    var title: String!
    var rating: Int!
    var owner: String!
    var price: Int!
    var quantity : Int!
    var tags: Array<String>!
    
    init(){
        self.id = ""
        self.images = UIImage()
        self.description = ""
        self.title = ""
        self.rating = 0
        self.owner = ""
        self.price = 0
        self.quantity = 0
        self.tags = []
    }
}

class User {
//    let email: String!
    let phoneNumber: String!
    let firstName: String!
    let lastName: String!
    let email: String!
    let address: String!
    let ccId: String!
    var isBaker: Bool!
    var userId: AnyObject!
}

class Baker: User {
    let availability: AnyObject!
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

