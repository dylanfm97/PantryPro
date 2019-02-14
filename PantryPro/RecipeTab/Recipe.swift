//
//  Recipe.swift
//  PantryPro
//
//  Created by Dylan Martinez on 2/8/19.
//  Copyright © 2019 Dylan Martinez. All rights reserved.
//

import Foundation

class Recipe: NSObject, NSCoding {
  
  
  var name: String?
  var ingredients = [ListItem]()
  var directions = [String]()
  
  init(name: String){
    self.name = name;
    self.ingredients = [];
    self.directions = [];
  }
  
  func addIngredient(item: ListItem){
    self.ingredients.append(item)
  }
  
  func removeIngredient(item: ListItem){
    if let index = self.ingredients.index(of: item){
      self.ingredients.remove(at: index)
    }
  }
  
  func addDirection(direction: String){
    self.directions.append(direction)
  }
  
  func removeDirection(direction: String){
    if let index = self.directions.index(of: direction){
      self.directions.remove(at: index)
    }
  }
  
  func encode(with aCoder: NSCoder) {
    aCoder.encode(self.name, forKey: "recipeName")
    aCoder.encode(self.ingredients, forKey: "recipeIngredients")
    aCoder.encode(self.directions, forKey: "recipeDirections")
  }
  
  required init?(coder aDecoder: NSCoder) {
    self.name = aDecoder.decodeObject(forKey: "recipeName") as! String?
    self.ingredients = aDecoder.decodeObject(forKey: "recipeIngredients") as! [ListItem]
    self.directions = aDecoder.decodeObject(forKey: "recipeDirections") as! [String]
    super.init()
  }
  
  
}
