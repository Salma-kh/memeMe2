//
//  TableViewCell.swift
//  memeMe last draft
//
//  Created by salma apple on 12/11/18.
//  Copyright © 2018 Udacity. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var TableCellImage: UIImageView!

    @IBOutlet weak var TableCellLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
