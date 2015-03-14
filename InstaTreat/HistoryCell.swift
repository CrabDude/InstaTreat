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
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
