//
//  ListItemCell.swift
//  PantryPro
//
//  Created by Dylan Martinez on 1/24/19.
//  Copyright © 2019 Dylan Martinez. All rights reserved.
//

import UIKit

class ListItemCell: UITableViewCell {
  @IBOutlet var quantityLabel: UILabel!
  @IBOutlet var itemLabel: UILabel!
  override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
