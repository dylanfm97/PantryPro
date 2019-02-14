//
//  RecipeCell.swift
//  PantryPro
//
//  Created by Dylan Martinez on 2/4/19.
//  Copyright © 2019 Dylan Martinez. All rights reserved.
//

import UIKit

class RecipeCell: UITableViewCell {

 
  @IBOutlet var recipeNameLabel: UILabel!
  
  override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
