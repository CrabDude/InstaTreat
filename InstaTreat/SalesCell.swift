//
//  SalesCell.swift
//  InstaTreat
//
//  Created by Dhanu Agnihotri on 3/13/15.
//  Copyright (c) 2015 Adam Crabtree. All rights reserved.
//

import UIKit

class SalesCell: UITableViewCell {

    @IBOutlet var priceLabel: UILabel!
    @IBOutlet var quantityLabel: UILabel!
    
    @IBOutlet var createdTimeLabel: UILabel!
    @IBOutlet var itemImageView: UIImageView!
    @IBOutlet var titleLabel: UILabel!
    
    
    @IBOutlet var quantityRemaining: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
