//
//  ListItem.swift
//  PantryPro
//
//  Created by Dylan Martinez on 1/23/19.
//  Copyright © 2019 Dylan Martinez. All rights reserved.
//

import Foundation

class ListItem: NSObject, NSCoding {
  
  var quantity: Int
  var item: String
  
  init(quantity: Int, item: String){
    self.quantity = quantity
    self.item = item
  }
  
  func encode(with aCoder: NSCoder) {
    aCoder.encode(self.quantity, forKey: "quantity")
    aCoder.encode(self.item, forKey: "item")
  }
  
  required init?(coder aDecoder: NSCoder) {
    self.quantity = aDecoder.decodeInteger(forKey: "quantity")
    self.item = aDecoder.decodeObject(forKey: "item") as! String
    super.init()
  }

}
