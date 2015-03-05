//
//  DataSchema.swift
//  InstaTreat
//
//  Created by Adam Crabtree on 3/4/15.
//  Copyright (c) 2015 Adam Crabtree. All rights reserved.
//

import UIKit

class ItemPost {
    let quantity: Int
    let createdAt: NSDate
    let endDate: NSDate
    let item: Item
    let price: String
    
    var options = [String:Bool]()
}



class Item {
    let images: [UIImage]
    let description: String
}