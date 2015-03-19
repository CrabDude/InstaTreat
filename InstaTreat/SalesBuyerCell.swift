//
//  SalesCell.swift
//  InstaTreat
//
//  Created by Dhanu Agnihotri on 3/13/15.
//  Copyright (c) 2015 Adam Crabtree. All rights reserved.
//

import UIKit

class SalesBuyerCell: UITableViewCell {
    
    @IBOutlet var quantityLabel: UILabel!
    @IBOutlet var buyerNameLabel: UILabel!
    @IBOutlet var buyerImageView: UIImageView!
    @IBOutlet weak var confirmButton: UIButton!
    @IBOutlet var addressLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
}
