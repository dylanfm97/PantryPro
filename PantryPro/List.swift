//
//  List.swift
//  PantryPro
//
//  Created by Dylan Martinez on 1/23/19.
//  Copyright © 2019 Dylan Martinez. All rights reserved.
//


import Foundation

class List: NSObject, NSCoding {
  
  var name: String
  var items = [ListItem]()
  
  init(name: String){
    self.name = name
    self.items = []
  }
  
  init(name: String, listItems: [ListItem]){
    self.name = name
    self.items = listItems
  }
  
  func addItem(item: ListItem){
    self.items.append(item)
  }
  
  func encode(with aCoder: NSCoder) {
    aCoder.encode(self.name, forKey: "artist")
    aCoder.encode(self.items, forKey: "title")
  }
  
  required init?(coder aDecoder: NSCoder) {
    self.name = aDecoder.decodeObject(forKey: "artist") as! String
    self.items = aDecoder.decodeObject(forKey: "title") as! [ListItem]
    super.init()
  }
}
