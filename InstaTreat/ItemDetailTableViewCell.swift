//
//  ItemDetailTableViewCell.swift
//  InstaTreat
//
//  Created by Ashar Rizqi on 3/16/15.
//  Copyright (c) 2015 Adam Crabtree. All rights reserved.
//

import UIKit

class ItemDetailTableViewCell: UITableViewCell {

    @IBOutlet weak var yoLabel: UILabel!

    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
//        fatalError("init(coder:) has not been implemented")
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
