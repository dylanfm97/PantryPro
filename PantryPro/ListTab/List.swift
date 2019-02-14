//
//  List.swift
//  PantryPro
//
//  Created by Dylan Martinez on 1/23/19.
//  Copyright © 2019 Dylan Martinez. All rights reserved.
//


import Foundation

class List: NSObject, NSCoding {
  
  var name: String?
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
  
  func removeItem(item: ListItem){
    if let index = self.items.index(of: item){
      self.items.remove(at: index)
    }
  }
  
  func encode(with aCoder: NSCoder) {
    aCoder.encode(self.name, forKey: "name")
    aCoder.encode(self.items, forKey: "items")
  }

  required init?(coder aDecoder: NSCoder) {
    self.name = aDecoder.decodeObject(forKey: "name") as! String?
    self.items = aDecoder.decodeObject(forKey: "items") as! [ListItem]
    super.init()
  }
}
