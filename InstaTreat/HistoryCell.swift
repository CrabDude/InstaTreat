//
//  HistoryCell.swift
//  
//
//  Created by Dhanu Agnihotri on 3/13/15.
//
//

import UIKit

class HistoryCell: UITableViewCell {

    @IBOutlet var itemImageView: UIImageView!
    @IBOutlet var totalSalesLabel: UILabel!
    @IBOutlet var saleEndedDateLabel: UILabel!
    @IBOutlet var saleRatingLabel: UILabel!
    @IBOutlet var titleLabel: UILabel!
    
   
    @IBOutlet var repostButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.itemImageView.layer.cornerRadius = 8.0
        self.itemImageView.clipsToBounds = true
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
