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
  var items: [ListItem]?
  
  init(name: String){
    self.name = name
    self.items = []
  }
  
  func encode(with aCoder: NSCoder) {
    
  }
  
  required init?(coder aDecoder: NSCoder) {
    self.name = aDecoder.decodeObject(forKey: "artist") as! String
    self.items = aDecoder.decodeObject(forKey: "title") as! [ListItem]?

  }
  
  
}