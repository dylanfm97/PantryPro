//
//  RecipeStore.swift
//  PantryPro
//
//  Created by Dylan Martinez on 2/8/19.
//  Copyright © 2019 Dylan Martinez. All rights reserved.
//

import Foundation

class RecipeStore {
  var allRecipes = [Recipe]()
  
  let listArchiveURL: URL = {
    let documentDirectories = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
    let documentDirectory = documentDirectories.first!
    return documentDirectory.appendingPathComponent("recipes.archive")
  }()
  
  init(){
    if let archivedRecipes = NSKeyedUnarchiver.unarchiveObject(withFile: listArchiveURL.path) as? [Recipe] {
      allRecipes = archivedRecipes
    }
  }
  
  func saveChanges() -> Bool {
    print("Sacing items to: \(listArchiveURL.path)")
    return NSKeyedArchiver.archiveRootObject(allRecipes, toFile: listArchiveURL.path)
  }
  
  @discardableResult func addRecipe(name: String) -> Recipe{
    let newRecipe = Recipe(name: name)
    allRecipes.append(newRecipe)
    return newRecipe
  }
  
  @discardableResult func addRecipe(recipe: Recipe) -> Recipe{
    allRecipes.append(recipe)
    return recipe
  }
  
  func removeList(_ recipe: Recipe){
    if let index = self.allRecipes.index(of: recipe){
      self.allRecipes.remove(at: index)
    }
  }
  
}
