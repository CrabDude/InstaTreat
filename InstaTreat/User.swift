//
//  User.swift
//  Tweetyness
//
//  Created by Ashar Rizqi on 2/21/15.
//  Copyright (c) 2015 Ashar Rizqi. All rights reserved.
//

import Foundation

var _currentUser: User?
let userDidLoginNotification = "userDidLoginNotification"
let userDidLogoutNotification = "userDidLogoutNotification"

class User {
    let phoneNumber: Int!
    let firstName: String!
    let lastName: String!
    let address: String!
    let email: String!
    let paymentToken: String!
    let isBaker: Bool
    var image: UIImage?
    var onImageLoad: (() -> Void)?
    var pfUser: PFUser!
    
    init(parseObject: PFUser) {
        self.phoneNumber = parseObject["phoneNumber"]! as Int
        self.firstName = parseObject["firstName"]! as String
        self.lastName = parseObject["lastName"]! as String
        self.address = parseObject["address"]! as String
        self.email = parseObject["email"]! as String
        self.isBaker = parseObject["isBaker"] as Bool
        
        self.pfUser = parseObject as PFUser

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
    
    class func logout() {
        println("logging user out")
        PFUser.logOut()
        _currentUser = nil
        
        NSNotificationCenter.defaultCenter().postNotificationName(userDidLogoutNotification, object: nil)
    }
    
    class var currentUser: User! {
        get {
            let pfCurrentUser = PFUser.currentUser()
            if _currentUser == nil && pfCurrentUser != nil {
                _currentUser = User(parseObject: pfCurrentUser)
            }
            return _currentUser
        }
    }
    
}

